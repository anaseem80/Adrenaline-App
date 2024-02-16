import 'dart:async';
import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:arabmedicine/layout/home_layout.dart';
import 'package:arabmedicine/moduels/login/login.dart';
import 'package:arabmedicine/shared/app_cubit.dart';
import 'package:arabmedicine/shared/styles/styles.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:root/root.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isDeveloperModeOn = false;
  bool isRooted = false;
  bool isJailbroken = false;

  final deviceInfoPlugin = DeviceInfoPlugin();
  @override
  void initState() {
    super.initState();
    checkDevice();
  }
  @override
  ValueNotifier<int> dialogTrigger = ValueNotifier(0);
  Future<void> checkDevice() async{

    bool jailbroken = await FlutterJailbreakDetection.jailbroken;
    bool developerMode = await FlutterJailbreakDetection.developerMode;
    bool? rooted = await Root.isRooted();// android
    try {
      isDeveloperModeOn = developerMode;
      isJailbroken = jailbroken;
      isRooted = rooted!;

    } catch (error) {
    }
    setState(() {
      isDeveloperModeOn = isDeveloperModeOn;
      isJailbroken = isJailbroken;
      isRooted = isRooted;
    });
  }

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent
        ),
    );
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/splash.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/splash_logo.png",width: 200,),
            SizedBox(
              height: 50,
            ),
            CircularProgressIndicator(),
             ValueListenableBuilder(
              valueListenable: dialogTrigger,
              builder: (ctx, value, child) {
                Timer(Duration(seconds: 5), () {
                  if(isRooted == true || isJailbroken == true || isDeveloperModeOn == true){
                    Timer(Duration(seconds: 0), () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("هاتفك غير امن"),
                                Icon(Icons.warning,color: Colors.red,)
                              ],
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(":الرجاء القيام بما يلي"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  isDeveloperModeOn ? Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(' تعطيل وضع المطور '),
                                    ],
                                  ) : Container(),
                                  isRooted ? Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('إلغاء الروت'),
                                    ],
                                  ) : Container(),
                                  isJailbroken ? Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('الغاء الجيلبريك'),
                                    ],
                                  ) : Container(),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              MaterialButton(
                                child: const Text('حسناً'),
                                color:Colors.red,
                                textColor:Colors.white,
                                onPressed: () async {
                                  //exit(0);
                                },
                              )
                            ],
                          );
                        },
                      ).then((value) => {
                        exit(0),
                      });
                    });
                    Timer(Duration(seconds: 10), () {
                      exit(0);
                    });
                  }
                  if(!isJailbroken){
                    if(!isDeveloperModeOn){
                      redirect();
                    }
                  }
                  if(!isRooted){
                    if(!isDeveloperModeOn){
                      redirect();
                    }
                  }
                });
                return Container();
            })
          ],
        ),
      ),
    );
  }
  void redirect() async{
    var shared = await SharedPreferences.getInstance();
    String? token;
    if (shared.containsKey('token')) {
      token = shared.getString('token');
    }
    Widget widget;

    if (token != null) {
      widget = Home_Layout();
    } else {
      widget = LoginScreen();
    }
    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRight, child: widget));

  }
}