import 'package:flutter/material.dart';
import 'package:movieapp/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(seconds: 3),
              builder: (context, val, _) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 210,
                      height: 210,
                      decoration: BoxDecoration(
                          color: Colors.transparent, border: Border.all(color: Colors.black, width: 1), shape: BoxShape.circle),
                    ),
                    Container(
                      width: 210,
                      height: 210,
                      decoration: BoxDecoration(
                          gradient: SweepGradient(
                              colors: const [
                                Colors.black,
                                Colors.transparent,
                              ],
                              startAngle: 0,
                              endAngle: 2 * 3.14,
                              center: Alignment.center,
                              stops: [val, val]),
                          shape: BoxShape.circle),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Image(image: AssetImage('images/wework.png')),
                    ),
                  ],
                );
              })),
    );
  }
}
