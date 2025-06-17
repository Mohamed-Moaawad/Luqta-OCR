import 'package:flutter/material.dart';
import 'package:luqta/theme.dart';
// Packages
// flutter_screenutil
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.bgColor,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'images/logo.png',
            fit: BoxFit.contain,
            width: 200.w,
            height: 150.w,
          ),
          Container(
            width: .8.sw,
            decoration: BoxDecoration(
              color: AppTheme.black,
              borderRadius: BorderRadius.circular(AppTheme.btnRadius),
            ),
            child: MaterialButton(
              minWidth: double.infinity,
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('home');
              },
              child: Text(
                'ابدأ',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.white,
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
