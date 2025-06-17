import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:luqta/theme.dart';

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:url_launcher/url_launcher.dart';

class RechargeType extends StatefulWidget {
  final String companyName;
  final String recharge_type;
  const RechargeType(
      {super.key, required this.companyName, required this.recharge_type});

  @override
  State<RechargeType> createState() => _RechargeTypeState();
}

class _RechargeTypeState extends State<RechargeType> {
  File? _image;
  // final regex = RegExp(r'((\d\s*){14,16})');
  final regex = RegExp(r'\b(?:\d{3,4}\s?){3,5}\d{3,4}\b');

  final TextEditingController _controller = TextEditingController();
  bool isError = false;
  bool isLoading = false;

  // Function get Image from device
  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      setState(() {
        _image = File(image.path);
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  // Function _extract Text From Image
  Future _extractTextFromImage(File image) async {
    setState(() {
      isLoading = true;
    });
    final textRecognizer = TextRecognizer(
      script: TextRecognitionScript.latin,
    );
    final InputImage inputImage = InputImage.fromFilePath(image.path);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    final matches = regex.allMatches(recognizedText.text);
    // final numbers = matches.map((match) => match.group(0)).toList();
    // final numbers = matches.map((e) => e.group(0)!).toList();
    // final validNumbers = matches
    //     .map((match) => match.group(0)!)
    //     .map((e) => e.replaceAll(RegExp(r'\s+'), '')) // إزالة المسافات
    //     .where((number) =>
    //         number.length >= 14 && number.length <= 16) // الطول الصحيح
    //     .toList();
    // print('validNumbers $numbers');
    final validNumber = matches
            .map((e) => e.group(0)!)
            .where((e) =>
                e.replaceAll(RegExp(r'\s+'), '').length >= 14 &&
                e.replaceAll(RegExp(r'\s+'), '').length <= 16)
            .firstOrNull ??
        '';
    setState(() {
      _controller.text = validNumber;
      isLoading = false;
    });
    handleShowDialog();
    // textRecognizer.close();
  }

  // Function open showDialog
  void handleShowDialog() async {
    if (_controller.text.isNotEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'تأكد من رقم الكارت',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              content: TextField(
                keyboardType: TextInputType.number,
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              actions: [
                // send button
                Container(
                  width: 0.4.sw,
                  decoration: BoxDecoration(
                    color: Colors.lightGreenAccent,
                    borderRadius: BorderRadius.circular(
                      AppTheme.btnRadius,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      _rechargeCard(_controller.text);
                    },
                    child: Text('شحن'),
                  ),
                ),
                // cancel button
                Container(
                  width: 0.2.sw,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(
                      AppTheme.btnRadius,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'الغاء',
                      style: TextStyle(color: AppTheme.white),
                    ),
                  ),
                )
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'حدث خطأ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.gray,
                ),
              ),
              content: Text(
                'رجاء إعادة المحاولة',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textColor,
                ),
              ),
              actions: [
                // cancel button
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(
                      AppTheme.btnRadius,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'الغاء',
                      style: TextStyle(color: AppTheme.white),
                    ),
                  ),
                )
              ],
            );
          });
    }
  }

  // Function Recharge Card
  void _rechargeCard(String number) async {
    if (widget.companyName == 'vodafone') {
      if (widget.recharge_type == 'flex') {
        print('*858*2*${number}#');
        final Uri url = Uri(scheme: 'tel', path: '*858*2*${number}#');

        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'لا يمكن الاتصال بالرقم $number';
        }
      }
      if (widget.recharge_type == 'minutes') {
        print('*858*1*${number}#');
        final Uri url = Uri(scheme: 'tel', path: '*858*1*${number}#');

        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'لا يمكن الاتصال بالرقم $number';
        }
      }
      if (widget.recharge_type == 'balance') {
        print('*858*${number}#');
        final Uri url = Uri(scheme: 'tel', path: '*858*${number}#');

        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'لا يمكن الاتصال بالرقم $number';
        }
      }
    }
    if (widget.companyName == 'etisalat') {
      if (widget.recharge_type == 'flex') {
        print('*858*2*${number}#');
        final Uri url = Uri(scheme: 'tel', path: '*556*2*${number}#');

        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'لا يمكن الاتصال بالرقم $number';
        }
      }
      if (widget.recharge_type == 'minutes') {
        print('*858*1*${number}#');
        final Uri url = Uri(scheme: 'tel', path: '*556*1*${number}#');

        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'لا يمكن الاتصال بالرقم $number';
        }
      }
      if (widget.recharge_type == 'balance') {
        print('*858*${number}#');
        final Uri url = Uri(scheme: 'tel', path: '*556*${number}#');

        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'لا يمكن الاتصال بالرقم $number';
        }
      }
    }
    if (widget.companyName == 'orange') {
      if (widget.recharge_type == 'flex') {
        print('*858*2*${number}#');
        final Uri url = Uri(scheme: 'tel', path: '*102*2*${number}#');

        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'لا يمكن الاتصال بالرقم $number';
        }
      }
      if (widget.recharge_type == 'minutes') {
        print('*858*1*${number}#');
        final Uri url = Uri(scheme: 'tel', path: '*102*1*${number}#');

        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'لا يمكن الاتصال بالرقم $number';
        }
      }
      if (widget.recharge_type == 'balance') {
        print('*858*${number}#');
        final Uri url = Uri(scheme: 'tel', path: '*102*${number}#');

        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'لا يمكن الاتصال بالرقم $number';
        }
      }
    }
    if (widget.companyName == 'we') {
      if (widget.recharge_type == 'flex') {
        final Uri url = Uri(scheme: 'tel', path: '*555*2*${number}#');

        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'لا يمكن الاتصال بالرقم $number';
        }
      }
      if (widget.recharge_type == 'minutes') {
        final Uri url = Uri(scheme: 'tel', path: '*555*1*${number}#');

        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'لا يمكن الاتصال بالرقم $number';
        }
      }
      if (widget.recharge_type == 'balance') {
        final Uri url = Uri(scheme: 'tel', path: '*555*${number}#');

        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'لا يمكن الاتصال بالرقم $number';
        }
      }
    }
  }

/*
void _makePhoneCall(String number) async {
  final Uri url = Uri(scheme: 'tel', path: number);

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'لا يمكن الاتصال بالرقم $number';
  }
}
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 0.06.sw, vertical: 20.h),
          color: AppTheme.bgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 100.h),
                child: Column(
                  children: [
                    if (widget.companyName == 'etisalat') Etisalat(),
                    // ==
                    if (widget.companyName == 'vodafone') Vodafone(),
                    // ==
                    if (widget.companyName == 'orange') Orange(),
                    // ==
                    if (widget.companyName == 'we') We(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      print('معرض');
                      await _pickImage(ImageSource.gallery).then((value) {
                        if (_image != null) {
                          _extractTextFromImage(_image!);
                        }
                      });
                    },
                    child: Container(
                        width: 0.40.sw,
                        height: 120.h,
                        margin: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          color: AppTheme.bgColor,
                          borderRadius:
                              BorderRadius.circular(AppTheme.boxRadius),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF000000)
                                  .withOpacity(0.15), // لون الظل
                              spreadRadius: 1, // مدى انتشار الظل
                              blurRadius: 2, // مدى ضبابية الظل
                              offset: Offset(0, 0), // تحريك الظل (x, y)
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/gallery.png',
                              fit: BoxFit.contain,
                              width: 50.w,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'المعرض',
                              style: TextStyle(
                                color: AppTheme.textColor,
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )),
                  ),
                  //==================
                  InkWell(
                    onTap: () {
                      print('تصوير');
                      _pickImage(ImageSource.camera).then((value) {
                        if (_image != null) {
                          _extractTextFromImage(_image!);
                        }
                      });
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
                        children: [
                          Image.asset(
                            'images/scan.png',
                            fit: BoxFit.contain,
                            width: 50.w,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'تصوير',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.textColor,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (isLoading)
          Container(
            width: 1.sw,
            height: 1.sh,
            color: Color(0x49000000),
            child: Center(
                child: SpinKitCircle(
              size: 130.sp,
              color: AppTheme.black,
            )),
          ),
      ]),
    );
  }
}

// ====================================
// = Title Components
// ====================================

// Etisalat Title
class Etisalat extends StatelessWidget {
  const Etisalat({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'images/e&-full.png',
          fit: BoxFit.contain,
          width: 180.w,
        ),
        SizedBox(height: 8.h),
        Text(
          'اتصالات',
          style: TextStyle(
              color: AppTheme.textColor,
              fontSize: 22.sp,
              fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}

// Vodafone Title
class Vodafone extends StatelessWidget {
  const Vodafone({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'images/vodafone-ful.png',
          fit: BoxFit.contain,
          width: 180.w,
        ),
        SizedBox(height: 8.h),
        Text(
          'فودافون',
          style: TextStyle(
              color: AppTheme.textColor,
              fontSize: 22.sp,
              fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}

// Orange Title
class Orange extends StatelessWidget {
  const Orange({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'images/orange-full.png',
          fit: BoxFit.contain,
          width: 180.w,
        ),
        SizedBox(height: 8.h),
        Text(
          'اورنج',
          style: TextStyle(
              color: AppTheme.textColor,
              fontSize: 22.sp,
              fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}

// We Title
class We extends StatelessWidget {
  const We({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'images/we-full.png',
          fit: BoxFit.contain,
          width: 180.w,
        ),
        SizedBox(height: 8.h),
        Text(
          'المصرية للاتصالات',
          style: TextStyle(
              color: AppTheme.textColor,
              fontSize: 22.sp,
              fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}
