import 'dart:async';
import 'dart:io';
import 'package:adrenaline/moduels/Intro_video/IntroVideo.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:adrenaline/moduels/downloads/downloads.dart';
import 'package:adrenaline/moduels/settings/settings.dart';
import 'package:adrenaline/moduels/user/user_settings.dart';
import 'package:adrenaline/shared/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:root/root.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../moduels/courses/home_screen.dart';
import '../moduels/enrolled_courses_screen/enrolled_courses.dart';
import '../shared/styles/styles.dart';
import 'package:ios_insecure_screen_detector/ios_insecure_screen_detector.dart';

import 'cubit/home_layout_cubit.dart';
import 'cubit/home_layout_state.dart';

class HomeLayout extends StatefulWidget {
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  bool isDeveloperModeOn = false;
  bool isRooted = false;
  bool isJailbroken = false;
  late StreamSubscription<bool> streamSubscription;
  Stream<bool> checkIfScreenRecording() async* {
    final IosInsecureScreenDetector insecureScreenDetector =
        IosInsecureScreenDetector();
    await insecureScreenDetector.initialize();

    while (true) {
      await Future.delayed(const Duration(seconds: 5)); // to avoid memory leak
      bool isCaptured = await insecureScreenDetector.isCaptured();
      yield isCaptured;
    }
  }



  Future<void> checkDevice() async {
    bool jailbroken = await FlutterJailbreakDetection.jailbroken;
    bool developerMode = await FlutterJailbreakDetection.developerMode;
    bool? rooted = await Root.isRooted(); // android
    try {
      isDeveloperModeOn = developerMode;
      isJailbroken = jailbroken;
      isRooted = rooted!;
    } catch (error) {}
    setState(() {
      isDeveloperModeOn = isDeveloperModeOn;
      isJailbroken = isJailbroken;
      isRooted = isRooted;
    });
  }

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
    // if (Platform.isIOS) {
    //   streamSubscription = checkIfScreenRecording().listen((isRecording) {
    //     if (isRecording) {
    //       showDialog<void>(
    //         context: context,
    //         barrierDismissible: false, // user must tap button!
    //         builder: (BuildContext context) {
    //           return AlertDialog(
    //             title: Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 Text(
    //                     "تسجيل الشاشة غير مسموح به هنا الرجاء القيام بتعطيل التسجيل"),
    //                 Icon(
    //                   Icons.warning,
    //                   color: Colors.red,
    //                 )
    //               ],
    //             ),
    //             content: SingleChildScrollView(
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.end,
    //                 crossAxisAlignment: CrossAxisAlignment.end,
    //                 children: [],
    //               ),
    //             ),
    //           );
    //         },
    //       );
    //     }
    //   });
    // }
  }

  void dispose() {
    if (Platform.isIOS) {
      streamSubscription.cancel();
    }
    super.dispose();
  }

  final List<String> items = [
    'Courses',
    'Modules',
    'Instructors',
  ];
  String? selectedValue;
  String? buttonValue;

  List<Widget> screens_HomeLayout = [
    HomeScreen(),
    EnrolledCourses(),
    Downloads(),
    User(),
    Settings(),
  ];

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();

  var currentTime;
  ValueNotifier<int> dialogTrigger = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();
    return BlocProvider(
      create: (context) => HomeLayoutCubit(),
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeLayoutCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Image.asset(
                      AppCubit.get(context).isDark
                          ? "assets/dark_logo.png"
                          : "assets/small_logo.png",
                      width: 150,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => MyVideoModal(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45.0),
                      ),
                      primary: Colors.black,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                    ),
                    child: Text(
                      "طريقة إستخدام المنصة",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              bottom: PreferredSize(
                child: Container(
                  height: 1.0,
                  color: Colors.grey[50], // Choose the color of your border
                ),
                preferredSize: Size.fromHeight(1.0),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                const url =
                    'https://www.facebook.com/messages/t/101555342175775';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Icon(Icons.sms_sharp),
              backgroundColor: HexColor("#b92097"),
            ),
            body: RefreshIndicator(
              key: _refreshIndicatorKey,
              color: Colors.black,
              backgroundColor: Colors.white,
              strokeWidth: 2.0,
              onRefresh: () async {
                return Future<void>.delayed(const Duration(seconds: 5), () {
                  setState(() {});
                });
              },
              child: Column(
                children: [
                  // ValueListenableBuilder(
                  //     valueListenable: dialogTrigger,
                  //     builder: (ctx, value, child) {
                  //       if (isRooted || isJailbroken || isDeveloperModeOn) {
                  //         Timer(Duration(seconds: 0), () {
                  //           showDialog<void>(
                  //             context: context,
                  //             barrierDismissible:
                  //                 false, // user must tap button!
                  //             builder: (BuildContext context) {
                  //               return AlertDialog(
                  //                 title: Row(
                  //                   mainAxisAlignment: MainAxisAlignment.end,
                  //                   children: [
                  //                     Text("هاتفك غير امن"),
                  //                     Icon(
                  //                       Icons.warning,
                  //                       color: Colors.red,
                  //                     )
                  //                   ],
                  //                 ),
                  //                 content: SingleChildScrollView(
                  //                   child: Column(
                  //                     mainAxisAlignment: MainAxisAlignment.end,
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.end,
                  //                     children: [
                  //                       Text(":الرجاء القيام بما يلي"),
                  //                       SizedBox(
                  //                         height: 5,
                  //                       ),
                  //                       isDeveloperModeOn
                  //                           ? Row(
                  //                               crossAxisAlignment:
                  //                                   CrossAxisAlignment.start,
                  //                               mainAxisAlignment:
                  //                                   MainAxisAlignment.end,
                  //                               children: [
                  //                                 Text(' تعطيل وضع المطور '),
                  //                               ],
                  //                             )
                  //                           : Container(),
                  //                       isRooted
                  //                           ? Row(
                  //                               crossAxisAlignment:
                  //                                   CrossAxisAlignment.start,
                  //                               mainAxisAlignment:
                  //                                   MainAxisAlignment.end,
                  //                               children: [
                  //                                 Text('إلغاء الروت'),
                  //                               ],
                  //                             )
                  //                           : Container(),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 actions: <Widget>[
                  //                   MaterialButton(
                  //                     child: const Text('حسناً'),
                  //                     color: Colors.red,
                  //                     textColor: Colors.white,
                  //                     onPressed: () async {
                  //                       exit(0);
                  //                     },
                  //                   )
                  //                 ],
                  //               );
                  //             },
                  //           ).then((value) => exit(0));
                  //         });
                  //         Timer(Duration(seconds: 5), () {
                  //           exit(0);
                  //         });
                  //       }
                  //       return Container();
                  //     }),
                  Expanded(
                    child: screens_HomeLayout[cubit.currentIndex],
                  )
                ],
              ),
            ),
            bottomNavigationBar: Theme(
              data: ThemeData(
                iconTheme: IconThemeData(
                  color: whiteColor,
                ),
              ),
              child: BottomNavigationBar(
                backgroundColor: lowWhiteColor,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.black,
                currentIndex: currentIndex, // Assume you have a variable currentIndex to keep track of the selected item
                onTap: (index) {
                  cubit.clickedItem(index);
                },
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(IconlyBroken.bag2, size: 28),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.cast_for_education_sharp, size: 25),
                    label: "كورساتي",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconlyBroken.download, size: 25),
                    label: "تنزيلاتي",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconlyBroken.user2, size: 25),
                    label: "المستخدم",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconlyBroken.setting, size: 25),
                    label: "الإعدادات",
                  ),
                ],
              )
              ,
            ),
          );
        },
      ),
    );
  }
}
