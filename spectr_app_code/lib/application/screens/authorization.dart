import 'package:flutter/material.dart';
import 'package:spectr/application/screen_factory/screen_factory.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spectr/application/screens/pin_code.dart';

class AuthorizationScreen extends StatelessWidget {
  const AuthorizationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SetProvider(),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const Scaffold(
          body: AuthorizationWidget(),
        ),
      ),
    );
  }
}

class AuthorizationWidget extends StatelessWidget {
  const AuthorizationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 80.0),
            const Text(
              'Введите номер телефона',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.normal,
                fontFamily: 'inter',
                letterSpacing: 0.0,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            const PhoneNumberForm(),
            const SizedBox(height: 10.0),
            const Text(
              'Отправим вам СМС с кодом подтверждения.\nРекламу присылать не будем.',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                fontFamily: 'inter',
                letterSpacing: 0.0,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 100.0),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 45,
                    width: double.infinity,
                    decoration: const BoxDecoration(),
                    child: startButton(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget startButton(BuildContext context) {
    return Consumer<SetProvider>(builder: (context, setProvider, _) {
      return ElevatedButton(
        onPressed: () {
          if (!setProvider.isPressed) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Text('Введите корректный номер'),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                )));
          } else {
            ScreenFactory.navigateToPage(context, PinCodePage());
          }
        },
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(const Color.fromARGB(255, 91, 43, 168)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: const Text(
          'Далее',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      );
    });
  }
}

class PhoneNumberForm extends StatefulWidget {
  const PhoneNumberForm({Key? key}) : super(key: key);

  @override
  _PhoneNumberFormState createState() => _PhoneNumberFormState();
}

class _PhoneNumberFormState extends State<PhoneNumberForm> {
  late PhoneNumber _phoneNumber;
  late String _countryCode;
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
    _phoneNumber = PhoneNumber(isoCode: 'RU');
    _countryCode = '+7';
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final setProvider = Provider.of<SetProvider>(context);
    return TextFormField(
      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      maxLength: 10,
      controller: _phoneNumberController,
      onChanged: (value) {
        setState(() {
          _phoneNumber = PhoneNumber(
            phoneNumber: value,
            isoCode: _phoneNumber.isoCode,
          );
          if (value.length == 10) {
            setProvider.setClick(true);
          } else {
            setProvider.setClick(false);
          }
        });
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 220, 223, 226),
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 91, 43, 168),
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        labelText: '(999)-999-99-99',
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 141, 141, 141),
        ),
        prefixIcon: GestureDetector(
          onTap: _openCountryPicker,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              _countryCode,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 15,
          minHeight: 15,
        ),
      ),
    );
  }

  void _openCountryPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Выберите страну'),
          content: CountryCodePicker(
            textStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
            onChanged: (value) {
              setState(() {
                _countryCode = value.dialCode!;
              });
              Navigator.pop(context);
            },
            initialSelection: _phoneNumber.isoCode,
            favorite: const [
              '+7',
              'RU',
            ],
          ),
        );
      },
    );
  }
}

class SetProvider with ChangeNotifier {
  bool _isPressed = false;

  bool get isPressed => _isPressed;

  void setClick(bool value) {
    _isPressed = value;
    notifyListeners();
  }
}
