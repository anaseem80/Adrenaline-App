import 'dart:async';
import 'dart:io';

import 'package:adrenaline/moduels/login/cubit/cubit.dart';
import 'package:adrenaline/moduels/login/cubit/state.dart';
import 'package:adrenaline/moduels/register/register.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:adrenaline/shared/styles/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:page_transition/page_transition.dart';
import 'package:root/root.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../layout/home_layout.dart';
import '../../shared/compontents/compenants.dart';
import '../../shared/constant/constants.dart';
class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var obsecurePass = true;
  var iconEye = Icons.remove_red_eye_sharp;
  ValueNotifier<int> dialogTrigger = ValueNotifier(0);
  bool isDeveloperModeOn = false;
  bool isRooted = false;
  bool isJailbroken = false;
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

  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkDevice(); // Initial check
    //
    // // Listen for changes in developer mode
    // FlutterJailbreakDetection.developerMode.then((developerMode) {
    //   if (developerMode != isDeveloperModeOn) {
    //     setState(() {
    //       isDeveloperModeOn = developerMode;
    //       checkDevice();
    //     });
    //   }
    // });
    //
    // // Listen for changes in jailbroken status
    // FlutterJailbreakDetection.jailbroken.then((jailbroken) {
    //   if (jailbroken != isJailbroken) {
    //     setState(() {
    //       isJailbroken = jailbroken;
    //       checkDevice();
    //     });
    //   }
    // });
    //
    // // Listen for changes in rooted status
    // Root.isRooted().then((rooted) {
    //   if (rooted != isRooted) {
    //     setState(() {
    //       isRooted = rooted!;
    //       checkDevice();
    //     });
    //   }
    // });
  }
  Future<void> _showMyDialog(message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Image.asset(
            "assets/small_logo.png",
            width: 10,
            height: 30,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  textAlign: TextAlign.end
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('حسناً'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginLayoutCubit(),
      child: BlocConsumer<LoginLayoutCubit, LoginLayoutState>(
      listener: (context, state) async {
        if(state is LoginLoaded){
          if(state.loginModelData.data != null){
            var shared = await SharedPreferences.getInstance();
            shared.setString("email", state.loginModelData.data!.email.toString());
            shared.setString("firstname", state.loginModelData.data!.firstname.toString());
            shared.setString("userID", state.loginModelData.data!.id.toString());
            userID = state.loginModelData.data!.id.toString();
            shared.setString("lastname", state.loginModelData.data!.lastname.toString());
            shared.setString("profile_photo_path", state.loginModelData.data!.user_picture.toString());
            shared.setString("token", state.loginModelData.token.toString()).then((value) => {
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => HomeLayout(),
                ),
              )
            });
            showToast(
                message: "تم التسجيل بنجاح",
                color: Colors.green,
            );
          }else{
            _showMyDialog(state.loginModelData.message);
          }
        }
      },
      builder: (context, state) {
        var cubit = LoginLayoutCubit.get(context);
        return Container(
              child: SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    title: Text("تسجيل الدخول"),
                  ),
                  body: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 18.0,
                            ),
                            Center(
                              child: Container(
                                child: Image.asset(
                                  'assets/small_logo.png',
                                  width: 170,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextFormFieldMain(
                              text: "البريد الالكتروني",
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              context:context,
                              error: "This field is required",
                              prefix: Icons.email,
                              validator: (value) {
                                if(value.isEmpty)
                                {
                                  return "هذا الحقل مطلوب";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormFieldMain(
                              text: "كلمة السر",
                              controller: passwordController,
                              type: TextInputType.name,
                              obscureText: obsecurePass,
                              context:context,
                              error: "Password",
                              prefix: Icons.lock,
                              suffix: obsecurePass ? Icons.visibility : Icons.visibility_off,
                              onSubmit: (value){
                                if(formKey.currentState!.validate()){
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context,
                                  );
                              }
                              },
                              obscureShow: () {
                                setState(() {
                                  obsecurePass = !obsecurePass;
                                });
                              },
                              validator: (value) {
                                if(value.isEmpty)
                                {
                                  return "كلمة السر قصيرة جدا";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! LoginLoading,
                              builder: (context) => DefaultButton(
                                text: "تسجيل الدخول",
                                context: context,
                                function: () async {
                                  if(formKey.currentState!.validate()){
                                    cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        context: context,
                                    );
                                  }
                                },
                              ),
                              fallback: (context) => Center(child: CircularProgressIndicator()),
                            ),
                            ValueListenableBuilder(
                                valueListenable: dialogTrigger,
                                builder: (ctx, value, child) {
                                  if(isRooted || isJailbroken|| isDeveloperModeOn){
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
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              MaterialButton(
                                                child: const Text('حسناً'),
                                                color:Colors.red,
                                                textColor:Colors.white,
                                                onPressed: () async {
                                                  exit(0);
                                                },
                                              )
                                            ],
                                          );
                                        },
                                      ).then((value) => exit(0));
                                    });
                                    Timer(Duration(seconds: 5), () {
                                      exit(0);
                                    });
                                  }
                                  return Container();
                                }),
                            SizedBox(
                              height: 60.0,
                            ),
                            Center(
                              child: Text(
                                "ليس لديك حساب؟",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            DefaultButton(
                              text: "إنشاء حساب جديد",
                              background: lowWhiteColor,
                              textColor: whiteColor,
                              context: context,
                              function: ()  {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                                );
                              },
                            ),
                          ],
                        ),
                        ),
                      ),
                    ),
                  )
                ),
              )
            );
      },
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
      widget = HomeLayout();
    } else {
      widget = LoginScreen();
    }
    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRight, child: widget));

  }
}