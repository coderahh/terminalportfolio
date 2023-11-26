import 'dart:math';
import 'package:flutter/material.dart';
import 'package:terminal_portfolio/app_colors.dart';

// Represents the welcome widget.
class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  int _currentCharIndex1 = 0;
  final text1 = '***Welcome to my space***';
  int _currentCharIndex2 = 0;
  final text2 = 'this is my interactive web terminal :)';
  int _currentCharIndex3 = 0;
  final text3 = 'type';
  int _currentCharIndex4 = 0;
  final text4 = ' help ';
  int _currentCharIndex5 = 0;
  final text5 = 'to see all available commands.';

  @override
  void initState() {
    super.initState();

    _typeWrittingAnimation1();

    Future.delayed(const Duration(milliseconds: 3000), () {
      _typeWrittingAnimation2();
    });

    Future.delayed(const Duration(milliseconds: 7000), () {
      _typeWrittingAnimation3();
    });

    // Initialize animation controller
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this,
        reverseDuration: const Duration(milliseconds: 3000))
      ..repeat();

    // Define the animation
    _animation = Tween<double>(
      begin: 0.1,
      end: 0.4,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Text animation functions

  void _typeWrittingAnimation1() {
    if (_currentCharIndex1 < text1.length) {
      _currentCharIndex1++;
    }

    setState(() {});

    Future.delayed(const Duration(milliseconds: 100), () {
      _typeWrittingAnimation1();
    });
  }

  void _typeWrittingAnimation2() {
    if (_currentCharIndex2 < text2.length) {
      _currentCharIndex2++;
    }

    setState(() {});

    Future.delayed(const Duration(milliseconds: 100), () {
      _typeWrittingAnimation2();
    });
  }

  void _typeWrittingAnimation3() {
    if (_currentCharIndex3 < text3.length) {
      _currentCharIndex3++;
    }
    if (_currentCharIndex4 < text4.length) {
      _currentCharIndex4++;
    }
    if (_currentCharIndex5 < text5.length) {
      _currentCharIndex5++;
    }

    setState(() {});

    Future.delayed(const Duration(milliseconds: 100), () {
      _typeWrittingAnimation3();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WelcomePainter(
          _animation.value), // Custom painter for the background animation
      child: Container(
        width: double.infinity,
        height: 300.0,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated text 1
            Text(
              text1.substring(0, _currentCharIndex1),
              style: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    for (double i = 1; i < 4; i++)
                      Shadow(color: AppColors.pinkColor, blurRadius: 3 * i)
                  ]),
            ),
            // Animated text 2
            Container(
              padding: const EdgeInsetsDirectional.only(top: 20.0),
              child: Text(
                text2.substring(0, _currentCharIndex2),
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      for (double i = 1; i < 4; i++)
                        Shadow(color: AppColors.orangeColor, blurRadius: 3 * i)
                    ]),
              ),
            ),
            // Animated text 3
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text3.substring(0, _currentCharIndex3),
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  text4.substring(0, _currentCharIndex4),
                  style:
                      TextStyle(fontSize: 15.0, color: Colors.white, shadows: [
                    for (double i = 1; i < 4; i++)
                      Shadow(color: AppColors.pinkColor, blurRadius: 3 * i)
                  ]),
                ),
                Text(
                  text5.substring(0, _currentCharIndex5),
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for the background animation.
class WelcomePainter extends CustomPainter {
  final double animationValue;

  WelcomePainter(this.animationValue);

  double _degreeToRadian(double deg) => deg * (pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.grey.withOpacity(animationValue);

    final borderPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final topPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2.2, size.height / 3)
      ..lineTo(size.width / 1.8, size.height / 3)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(topPath, paint);
    canvas.drawPath(topPath, borderPaint);

    final bottomPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2.2, size.height / 1.5)
      ..lineTo(size.width / 1.8, size.height / 1.5)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(bottomPath, paint);
    canvas.drawPath(bottomPath, borderPaint);
  }

  @override
  bool shouldRepaint(WelcomePainter oldDelegate) =>
      animationValue != oldDelegate.animationValue;
}
