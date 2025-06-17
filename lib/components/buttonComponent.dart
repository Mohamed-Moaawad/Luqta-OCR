import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luqta/theme.dart';

class ButtonComponent extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  const ButtonComponent(
      {super.key, required this.text, required this.onPressed});

  @override
  State<ButtonComponent> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: MaterialButton(
        color: AppTheme.white,
        onPressed: widget.onPressed,
        child: Text(
          widget.text,
          style: TextStyle(
              color: AppTheme.textColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
