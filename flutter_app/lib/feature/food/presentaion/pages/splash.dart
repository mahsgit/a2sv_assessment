import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 10));
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/image.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 10, 
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome to",
                  style: GoogleFonts.caveatBrush(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  " SPEEDY CHOW",
                  style: GoogleFonts.caveatBrush(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
