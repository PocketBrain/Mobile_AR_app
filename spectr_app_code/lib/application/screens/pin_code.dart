import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:spectr/application/screen_factory/screen_factory.dart';
import 'package:spectr/application/screens/main_menu.dart';

class PinCodePage extends StatelessWidget {
  const PinCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80.0),
              const Text(
                'Введите код из СМС',
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PinCodeTextField(
                  keyboardType: TextInputType.phone,
                  //enableActiveFill: true,
                  autoFocus: true,
                  textStyle: const TextStyle(fontSize: 38, fontFamily: 'inter'),
                  appContext: context,
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,

                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 60,
                    fieldWidth: 60,
                    selectedColor: const Color.fromARGB(255, 200, 200, 203),
                    errorBorderColor: const Color.fromARGB(255, 62, 28, 116),
                    inactiveColor: const Color.fromARGB(255, 200, 200, 203),
                    activeFillColor: const Color.fromARGB(255, 200, 200, 203),
                    activeColor: const Color.fromARGB(255, 62, 28, 116),
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.white,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Мы отправили СМС на +7 (999) 999-99-99\nОбычно СМС приходит в течении минуты.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
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
      ),
    );
  }

  Widget startButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ScreenFactory.navigateToPage(context, const MainPageScreen());
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
  }
}
