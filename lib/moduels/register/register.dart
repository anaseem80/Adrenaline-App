import 'dart:ui';
import 'package:adrenaline/moduels/login/login.dart';
import 'package:adrenaline/moduels/register/cubit/register_layout_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:adrenaline/shared/styles/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../layout/home_layout.dart';
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
  var countryController = TextEditingController();
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
              shared.setString("userID", state.registerModelData.data!.id.toString());
              shared.setString("lastname", state.registerModelData.data!.lastname.toString());
              shared.setString("profile_photo_path", state.registerModelData.data!.user_picture.toString());
              shared.setString("token", state.registerModelData.token.toString()).then((value) => {
                Navigator.pop(context),
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
                                      height: 20.0,
                                    ),
                                    TextFormFieldMain(
                                      onTap: () {
                                        showCountryPicker(
                                          context: context,
                                          countryListTheme: CountryListThemeData(
                                            flagSize: 25,
                                            backgroundColor: Colors.white,
                                            textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
                                            bottomSheetHeight: 500, // Optional. Country list modal height
                                            //Optional. Sets the border radius for the bottomsheet.
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20.0),
                                              topRight: Radius.circular(20.0),
                                            ),
                                            //Optional. Styles the search field.
                                            inputDecoration: InputDecoration(
                                              labelText: 'Search',
                                              hintText: 'Start typing to search',
                                              prefixIcon: const Icon(Icons.search),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: const Color(0xFF8C98A8).withOpacity(0.2),
                                                ),
                                              ),
                                            ),
                                          ),
                                          onSelect: (Country country) {
                                            countryController.text = country.flagEmoji + " " + country.name;
                                            debugPrint("flag emogi ${countryController.text}");
                                            setState(() { });
                                          },
                                        );
                                      },
                                      text: "اختر البلد" ,
                                      controller: countryController,
                                      type: TextInputType.name,
                                      context:context,
                                      error: "Country",
                                      prefix: Icons.home_work_outlined,
                                      suffix: Icons.arrow_drop_down,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'هذا الحقل مطلوب';
                                        }
                                        return null;
                                      },

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