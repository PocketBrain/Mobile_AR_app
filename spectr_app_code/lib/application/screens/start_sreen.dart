import 'package:flutter/material.dart';
import 'package:spectr/application/screen_factory/screen_factory.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:spectr/application/screens/authorization.dart';
import '../themes/app_text_style.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: StartWidget());
  }
}

class StartWidget extends StatelessWidget {
  final colorizeColors = [
    const Color.fromARGB(255, 139, 84, 237),
    const Color.fromARGB(255, 130, 96, 191),
    const Color.fromARGB(255, 104, 68, 166),
    const Color.fromARGB(255, 82, 52, 135),
    const Color.fromARGB(255, 65, 39, 112),
    const Color.fromARGB(255, 51, 29, 90),
    const Color.fromARGB(255, 38, 18, 73),
  ];

  StartWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 55, 131, 186),
            Color.fromARGB(255, 44, 19, 86),
          ],
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // DecoratedBox(decoration: ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedTextKit(
                pause: const Duration(microseconds: 100),
                repeatForever: true,
                animatedTexts: [
                  ColorizeAnimatedText(
                    'SPECTR',
                    speed: const Duration(milliseconds: 1000),
                    textStyle: const TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'seoulnamsan',
                        letterSpacing: 2),
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
              ),
            )),
            const SizedBox(height: 30),
            const Text(
              'Окунись в культурный мир с \n AR-технологиями',
              style: AppTextStyle.startText,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: const BoxDecoration(),
                  child: const EnterButton(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EnterButton extends StatelessWidget {
  const EnterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ScreenFactory.navigateToPage(context, const AuthorizationScreen());
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: const Text('Начать',
          style: TextStyle(fontSize: 18, color: Colors.black)),
    );
  }
}

class GradientText extends StatefulWidget {
  const GradientText({Key? key}) : super(key: key);

  @override
  _GradientTextState createState() => _GradientTextState();
}

class _GradientTextState extends State<GradientText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = TweenSequence<Color?>(
      [
        TweenSequenceItem(
          tween: ColorTween(
            begin: const Color.fromARGB(255, 38, 18, 73),
            end: const Color.fromARGB(255, 130, 98, 191),
          ),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: ColorTween(
            end: const Color.fromARGB(255, 38, 18, 73),
            begin: const Color.fromARGB(255, 130, 98, 191),
          ),
          weight: 1,
        ),
        // Добавьте дополнительные элементы TweenSequenceItem для других цветов
      ],
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          'SPECTR',
          style: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontFamily: 'seoulnamsan',
            letterSpacing: 0.0,
            color: _animation.value,
          ),
        );
      },
    );
  }
}
