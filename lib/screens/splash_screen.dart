import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment_management_app/screens/home_screen.dart';
import 'package:payment_management_app/utils/widgets/animations/animated_text.dart';
import 'package:payment_management_app/utils/widgets/animations/scale_transition_image.dart';

import '../utils/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Timer? timer;

  ///------init method
  @override
  void initState() {
    super.initState();
    timer?.cancel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      navigateToHome(context);
    });
  }

  /// ---- method for navigating to home screen
  void navigateToHome(BuildContext context) async {
    timer = Timer(
      const Duration(seconds: 3),
          () async{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: ( (context) =>const HomeScreen() )));
      },
    );
  }

  ///------dispose method
  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  ///------build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransitionImage(
              image: Image.asset(Assets.splashImage, width: 250.w, height: 250.h),
              duration:  const Duration(seconds: 2),
            ),
            SizedBox(height: 20.h),
            AnimatedText(
              text: Text(
                'Payment Management App',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              duration:  const Duration(seconds: 2),
            ),
          ],
        ),
      ),
    );
  }
}