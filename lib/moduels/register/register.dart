import 'dart:ui';

import 'package:arabmedicine/layout/home_layout.dart';
import 'package:arabmedicine/moduels/login/cubit/cubit.dart';
import 'package:arabmedicine/moduels/login/cubit/state.dart';
import 'package:arabmedicine/moduels/login/login.dart';
import 'package:arabmedicine/moduels/register/cubit/register_layout_cubit.dart';
import 'package:arabmedicine/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:arabmedicine/shared/styles/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/compontents/compenants.dart';
class RegisterScreen extends StatefulWidget {

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var passwordConfirmController = TextEditingController();
  var obsecurePass = true;
  var obsecurePassConfirm = true;

  var iconEye = Icons.remove_red_eye_sharp;
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterLayoutCubit(),
      child: BlocConsumer<RegisterLayoutCubit, RegisterLayoutState>(
        listener: (context, state) async {
          if(state is RegisterLoaded){
            if(state.registerModelData.token != null){
              print(state.registerModelData.token);
              var shared = await SharedPreferences.getInstance();
              shared.setString("email", state.registerModelData.data!.email.toString());
              shared.setString("firstname", state.registerModelData.data!.firstname.toString());
              shared.setString("lastname", state.registerModelData.data!.lastname.toString());
              shared.setString("profile_photo_path", state.registerModelData.data!.user_picture.toString());
              shared.setString("token", state.registerModelData.token.toString()).then((value) => {
                Navigator.pop(context),
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => Home_Layout(),
                  ),
                )
              });

              showToast(
                message: "تم التسجيل بنجاح",
                color: Colors.green,
              );
            }else{
              var errors = state.registerModelData.errors;
              if(errors != null){
                if(errors.containsKey("email")){
                  showToast(
                    message: errors['email'][0].toString(),
                    color: Colors.red,
                  );
                }
                if(errors.containsKey("password")){
                  for(var passworderr in errors['password']){
                    showToast(
                      message: passworderr,
                      color: Colors.red ,
                    );
                  }
                }
              }
              print(errors);
            }
          }
        },
        builder: (context, state) {
          var cubit = RegisterLayoutCubit.get(context);
          return Container(
                  child: SafeArea(
                    child: Scaffold(
                        appBar: AppBar(
                          title: Text("تسجيل حساب جديد"),
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
                                    TextFormFieldMain(
                                      text: "الاسم الاول",
                                      controller: firstNameController,
                                      type: TextInputType.name,
                                      context:context,
                                      error: "This field is required",
                                      prefix: Icons.person,
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
                                      text: "الاسم الثاني",
                                      controller: lastNameController,
                                      type: TextInputType.name,
                                      context:context,
                                      error: "This field is required",
                                      prefix: Icons.person,
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
                                      text: "كلمة المرور",
                                      controller: passwordController,
                                      type: TextInputType.name,
                                      obscureText: obsecurePass,
                                      context:context,
                                      error: "Password",
                                      prefix: Icons.lock,
                                      suffix: obsecurePass ? Icons.visibility : Icons.visibility_off,
                                      onSubmit: (value){
                                        if(formKey.currentState!.validate()){

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
                                          return "هذا الحقل مطلوب";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    TextFormFieldMain(
                                      text: "تأكيد كلمة المرور",
                                      controller: passwordConfirmController,
                                      type: TextInputType.name,
                                      obscureText: obsecurePassConfirm,
                                      context:context,
                                      error: "Password",
                                      prefix: Icons.lock,
                                      suffix: obsecurePassConfirm ? Icons.visibility : Icons.visibility_off,
                                      onSubmit: (value){
                                        if(formKey.currentState!.validate()){

                                        }
                                      },
                                      obscureShow: () {
                                        setState(() {
                                          obsecurePassConfirm = !obsecurePassConfirm;
                                        });
                                      },
                                      validator: (value) {
                                        if(value.isEmpty)
                                        {
                                          return "هذا الحقل مطلوب";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    ConditionalBuilder(
                                      condition: state is! RegisterLoading,
                                      builder: (context) => DefaultButton(
                                        text: "إنشاء حساب جديد",
                                        context: context,
                                        function: () async {

                                          if(formKey.currentState!.validate()){
                                            cubit.userRegister(
                                              firstname: firstNameController.text,
                                              lastname: lastNameController.text,
                                              email: emailController.text,
                                              password: passwordController.text,
                                              password_confirmation: passwordConfirmController.text,
                                            );
                                          }
                                        },
                                      ),
                                      fallback: (context) => Center(child: CircularProgressIndicator()),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Center(
                                      child: Text(
                                        "لديك حساب بالفعل؟",
                                        style: Theme.of(context).textTheme.headline3,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    DefaultButton(
                                      text: "تسجيل الدخول",
                                      background: lowWhiteColor,
                                      textColor: whiteColor,
                                      context: context,
                                      function: ()  {
                                        Navigator.pop(context);

                                        Navigator.pushReplacement<void, void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) => LoginScreen(),
                                          ),
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
}