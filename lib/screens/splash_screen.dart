// import 'dart:html';

import 'package:attendance_uni_app/configs/images_paths.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'login_screen.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatelessWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: SplashScreenView(
              navigateRoute: const Login(),
              duration: 4500,
              imageSize: 230,
              imageSrc: uniLogo,
              text: "Education University",
              textType: TextType.ColorizeAnimationText,
              textStyle: TextStyle(
                fontSize: size.width * 0.08,
              ),
              colors: [
                Theme.of(context).cardColor,
                Theme.of(context).hintColor,
                Theme.of(context).cardColor,
                Theme.of(context).hintColor,
                Theme.of(context).hintColor,
                Theme.of(context).cardColor,
              ],
              backgroundColor: Theme.of(context).backgroundColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size.height * 0.01),
            child: Text(
              'Developed by ODIWS',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: size.width * 0.04),
            ),
          ),
        ],
      ),
    );
  }
}
