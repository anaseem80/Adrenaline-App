import 'dart:io';

import 'package:adrenaline/layout/cubit/home_layout_cubit.dart';
import 'package:adrenaline/moduels/enrolled_courses_screen/enrolled_courses.dart';
import 'package:adrenaline/moduels/login/login.dart';
import 'package:adrenaline/shared/app_cubit.dart';
import 'package:adrenaline/shared/app_state.dart';
import 'package:adrenaline/shared/compontents/compenants.dart';
import 'package:adrenaline/shared/styles/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return version;
  }

  List<dynamic> lessons = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "إعدادات التطبيق",
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(
              height: 30,
            ),
            AppSettings(
              title: "الوضع المظلم",
              onTap: () {
                AppCubit.get(context).toggleMode();
                //HomeLayoutCubit.get(context)..clickedItem(0);
              },
              color: AppCubit.get(context).isDark ? Colors.white : Colors.black,
              context: context,
              icon: AppCubit.get(context).isDark
                  ? Icons.brightness_3_sharp
                  : Icons.brightness_4_sharp,
            ),
            SizedBox(
              height: 15,
            ),
            AppSettings(
              title: "مسح البيانات المؤقتة",
              onTap: () async {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: lowWhiteColor,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/small_logo.png",
                            width: 80,
                          ),
                        ],
                      ),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "تم مسح البيانات المخزنة بنجاح لوضع الاوفلاين",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: whiteColor,
                                  fontSize: main_size,
                                  fontFamily: 'Almarai'),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        MaterialButton(
                          child: const Text('حسناً'),
                          color: Colors.red,
                          textColor: Colors.white,
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  },
                );
                final directory =
                    (await getApplicationDocumentsDirectory()).path;
                lessons = io.Directory("$directory/").listSync();
                for (var lesson in lessons) {
                  if (lesson.path.contains("mp4")) {
                    await lesson.delete();
                  }
                }
              },
              color: Colors.red,
              context: context,
              icon: IconlyBroken.delete,
            ),
            SizedBox(
              height: 15,
            ),
            FutureBuilder(
                future: getAppVersion(),
                builder: (context, snapshot) {
                  return Text(
                    snapshot.data.toString() + " نسخة التطبيق ",
                    style: Theme.of(context).textTheme.headline3,
                  );
                })
          ],
        ),
      ),
    );
  }
}
