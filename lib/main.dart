import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:luqta/screens/home.dart';
import 'package:luqta/screens/recharge_type.dart';
import 'package:luqta/screens/splash.dart';
// Packages
// flutter_screenutil
import 'package:flutter_screenutil/flutter_screenutil.dart';

// void main() {
//   runApp(const MyApp());
// }
// GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() => runApp(
      MaterialApp(
        builder: FToastBuilder(),
        home: MyApp(),
        // navigatorKey: navigatorKey,
      ),
    );

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          home: child,
          routes: {
            "home": (context) => Home(),
            "recharge_type": (context) => RechargeType(
                  companyName: '',
                  recharge_type: '',
                ),
          },
        );
      },
      child: Splash(),
    );
  }
}
