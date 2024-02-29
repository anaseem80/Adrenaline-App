import 'package:adrenaline/moduels/login/login.dart';
import 'package:adrenaline/shared/app_cubit.dart';
import 'package:adrenaline/shared/app_state.dart';
import 'package:adrenaline/shared/compontents/compenants.dart';
import 'package:adrenaline/shared/styles/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends StatelessWidget {
  @override
  var formKey = GlobalKey<FormState>();
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var oldPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var obsecurePass = true;
  var iconEye = Icons.remove_red_eye_sharp;
  String? email;
  Future<String> getUserName() async {
    var shared = await SharedPreferences.getInstance();
    return shared.getString('firstname').toString() + " " + shared.getString('lastname').toString();
  }
  Future<String> getUserPicture() async {
    var shared = await SharedPreferences.getInstance();
    return shared.getString('profile_photo_path').toString();
  }
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/user.png"),
                  radius: 60,
                ),
                SizedBox(
                  height: 15.0,
                ),
                FutureBuilder(
                  future: getUserName(),
                  builder: (context, snapshot) {
                    return Text(
                      '${snapshot.data}',
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: main_size
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            // settingsWidget(
            //   IconData: IconlyBroken.user2,
            //   textSetting: "تعديل البيانات",
            //   onTap: () {
            //     print("user");
            //   }
            // ),
            SizedBox(
              height: 15.0,
            ),
            UserSettingsWidget(
              IconData: IconlyBroken.logout,
              textSetting: "تسجيل الخروج",
              iconColor: whiteColor,
              context: context,
              onTap: () async {
                var shared = await SharedPreferences.getInstance();
                shared.remove('token').then((value) => {
                  shared.remove("firstname"),
                  shared.remove("lastname"),
                  shared.remove("profile_photo_path"),
                  if(value){
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => LoginScreen(),
                      ),
                    )
                  }
                });
              }
            ),
            SizedBox(
              height: 15.0,
            ),
            UserSettingsWidget(
                IconData: IconlyBroken.delete,
                iconColor: Colors.red,
                textSetting: "حذف الحساب الخاص بي",
                context: context,
                onTap: () async {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: lowWhiteColor,
                        title: Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.warning,color: Colors.red,)
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "هل أنت متأكد بأنك تريد تمسح الحساب الخاص بك! ستقفد إية بيانات مسجلة لديك",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Almarai',
                                  color: whiteColor,
                                  fontSize: MediaQuery.of(context).size.width > 600 ? 18 : 13,
                                  height: 2,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          MaterialButton(
                            child: const Text('إلغاء',style: TextStyle(fontFamily: 'Almarai',),),
                            color:Colors.white70,
                            textColor:Colors.black,
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                          ),
                          BlocProvider(
                            create: (context) => AppCubit(),
                            child: BlocConsumer<AppCubit, AppState>(
                                listener: (context, state) async{
                                  if(state is AppDeleteUserLoading){
                                    showToast(
                                      message: "جاري المسح برجاء الإنتظار",
                                      color: Colors.red,
                                    );
                                  }else if(state is AppDeleteUserSuccess){
                                    Navigator.pop(context);
                                    showToast(
                                      message: "تم مسح الحساب بنجاح",
                                      color: Colors.green,
                                    );
                                    var shared = await SharedPreferences.getInstance();
                                    shared.remove('token').then((value) => {
                                      shared.remove("firstname"),
                                      shared.remove("lastname"),
                                      shared.remove("profile_photo_path"),
                                      if(value){
                                        Navigator.pushReplacement<void, void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) => LoginScreen(),
                                          ),
                                        )
                                      }
                                    });
                                  }else{
                                    showToast(
                                      message: "حدث خطأ غير متوقع الرجاء المحاولة في وقت لاحق",
                                      color: Colors.green,
                                    );
                                  }
                                },
                                builder: (context, state){
                                  var cubit = AppCubit.get(context);
                                  return ConditionalBuilder(
                                    condition: AppState is! AppDeleteUserLoading,
                                    builder: (context) => MaterialButton(
                                      child: const Text(
                                        'حسناً',
                                        style: TextStyle(
                                          fontFamily: 'Almarai',
                                        ),
                                      ),
                                      color:Colors.red,
                                      textColor:Colors.white,
                                      onPressed: () async {
                                        //Navigator.pop(context);
                                        cubit.deleteUserAccount();
                                      },
                                    ),
                                    fallback: (context) => Center(child: CircularProgressIndicator()),
                                  );

                                }
                            ),
                          )
                        ],
                      );
                    },
                  );
                }
            ),
          ],
        ),
      ),
    );

  }
}
