import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:luqta/components/buttonComponent.dart';
import 'package:luqta/screens/recharge_type.dart';
import 'package:luqta/theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String rechargeType = '';

  void _checkType(String companyName) {
    if (rechargeType.isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RechargeType(
          companyName: companyName,
          recharge_type: rechargeType,
        ),
      ));
    } else {
      Fluttertoast.showToast(
        msg: 'اختر نظام الشحنة',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.settings),
        onPressed: () {
          scaffoldKey.currentState!.showBottomSheet(
            (context) => Container(
              width: 1.sw,
              height: 0.4.sh,
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 10),
              decoration: BoxDecoration(
                color: AppTheme.textColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppTheme.boxRadius),
                  topRight: Radius.circular(AppTheme.boxRadius),
                ),
              ),
              child: Column(
                children: [
                  ButtonComponent(
                    text: 'فليكس',
                    onPressed: () {
                      setState(() {
                        rechargeType = 'flex';
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ButtonComponent(
                    text: 'دقايق',
                    onPressed: () {
                      setState(() {
                        rechargeType = 'minutes';
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ButtonComponent(
                    text: 'رصيد',
                    onPressed: () {
                      setState(() {
                        rechargeType = 'balance';
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      key: scaffoldKey,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
        color: AppTheme.bgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 0.05.sw,
              children: [
                InkWell(
                  onTap: () {
                    _checkType('etisalat');
                  },
                  child: Container(
                      width: 0.40.sw,
                      height: 120.h,
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppTheme.bgColor,
                        borderRadius: BorderRadius.circular(AppTheme.boxRadius),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Color(0xFF000000).withOpacity(0.15), // لون الظل
                            spreadRadius: 1, // مدى انتشار الظل
                            blurRadius: 2, // مدى ضبابية الظل
                            offset: Offset(0, 0), // تحريك الظل (x, y)
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/e&.png',
                            fit: BoxFit.contain,
                            width: 70.w,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            'اتصالات',
                            style: TextStyle(
                              color: AppTheme.textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    _checkType('vodafone');
                  },
                  child: Container(
                      width: 0.40.sw,
                      height: 120.h,
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppTheme.bgColor,
                        borderRadius: BorderRadius.circular(AppTheme.boxRadius),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Color(0xFF000000).withOpacity(0.15), // لون الظل
                            spreadRadius: 1, // مدى انتشار الظل
                            blurRadius: 2, // مدى ضبابية الظل
                            offset: Offset(0, 0), // تحريك الظل (x, y)
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/vodafone.png',
                            fit: BoxFit.contain,
                            width: 70.w,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            'فودافون',
                            style: TextStyle(
                              color: AppTheme.textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    _checkType('orange');
                  },
                  child: Container(
                      width: 0.40.sw,
                      height: 120.h,
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppTheme.bgColor,
                        borderRadius: BorderRadius.circular(AppTheme.boxRadius),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Color(0xFF000000).withOpacity(0.15), // لون الظل
                            spreadRadius: 1, // مدى انتشار الظل
                            blurRadius: 2, // مدى ضبابية الظل
                            offset: Offset(0, 0), // تحريك الظل (x, y)
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/orange.png',
                            fit: BoxFit.contain,
                            width: 70.w,
                            scale: 1.0,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            'اورنج',
                            style: TextStyle(
                              color: AppTheme.textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    _checkType('we');
                  },
                  child: Container(
                      width: 0.40.sw,
                      height: 120.h,
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppTheme.bgColor,
                        borderRadius: BorderRadius.circular(AppTheme.boxRadius),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Color(0xFF000000).withOpacity(0.15), // لون الظل
                            spreadRadius: 1, // مدى انتشار الظل
                            blurRadius: 2, // مدى ضبابية الظل
                            offset: Offset(0, 0), // تحريك الظل (x, y)
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/we.png',
                            fit: BoxFit.contain,
                            width: 70.w,
                            scale: 1.0,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            'وي',
                            style: TextStyle(
                              color: AppTheme.textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
            // Text('$rechargeType'),
            // Container(
            //   alignment: Alignment.center,
            //   child: _image == null
            //        Text('No Image')
            //       : Image.file(
            //           _image!,
            //           width: 170,
            //         ),
            // ),
            // SelectableText(
            //   text != null ? '$text' : 'No Text',
            //   style: TextStyle(
            //     color: AppTheme.textColor,
            //     fontSize: 15.sp,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
