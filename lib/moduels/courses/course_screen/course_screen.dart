import 'dart:io';

import 'package:adrenaline/moduels/courses/course_screen/cubit/course_view_layout_cubit.dart';
import 'package:adrenaline/moduels/courses/course_screen/rates/rates.dart';
import 'package:adrenaline/moduels/courses/course_sections/course_sections.dart';
import 'package:adrenaline/shared/compontents/compenants.dart';
import 'package:adrenaline/shared/styles/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class course_screen extends StatefulWidget {
  int? courseId;

  course_screen({
    this.courseId,
  });

  @override
  State<course_screen> createState() => _course_screenState();
}

class _course_screenState extends State<course_screen> {
  int? lessonsCount;

  dynamic? lessonName;

  String? enrollend_string_or_not;

  Color? enrollend_color_or_not;

  IconData? enrollend_icon_or_not;

  double rating = 0.0;

  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: BlocProvider(
          create: (context) =>
              CourseViewLayoutCubit()..getCourse(widget.courseId.toString()),
          child: BlocConsumer<CourseViewLayoutCubit, CourseViewLayoutState>(
            listener: (context, state) {
              var cubit = CourseViewLayoutCubit.get(context);
              if (state is CourseLoaded) {}
            },
            builder: (context, state) {
              var cubit = CourseViewLayoutCubit.get(context);
              if (state is CourseLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CourseLoaded) {
                if (cubit.course[0][0]['is_enrolled'] ||
                    cubit.course[0][0]['free'] == "1") {
                  enrollend_string_or_not = "الذهاب الي الكورس";
                  enrollend_color_or_not = Colors.orange;
                  enrollend_icon_or_not = Icons.arrow_circle_right_rounded;
                } else {
                  enrollend_string_or_not = "تواصل معنا لفتح الكورس";
                  enrollend_color_or_not = Colors.green;
                  enrollend_icon_or_not = Icons.arrow_circle_right_rounded;
                }
                return LayoutBuilder(builder: (context, constrain) {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        title: Text(
                          cubit.course[0][0]['name'],
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: title_course_size,
                          ),
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          background: CachedNetworkImage(
                            imageUrl: cubit.course[0][0]['image'],
                            imageBuilder: (context, imageProvider) => Container(
                              height: 1000,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              height: 200,
                              child: Container(
                                height: 15,
                                child: Center(child: CircularProgressIndicator()),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              height: 200,
                              child: Container(
                                height: 15,
                                child: Center(child: CircularProgressIndicator()),
                              ),
                            ),
                          ),
                        ),
                        pinned: true,
                        expandedHeight:
                            MediaQuery.of(context).size.height * 0.360,
                        systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.transparent,
                        ),
                      ),
                      SliverList(
                      delegate: SliverChildListDelegate([
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              TabBar(
                                tabs: [
                                  Tab(
                                    child: Text(
                                      "معلومات",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: whiteColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: title_course_size),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      "المحتوي",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: whiteColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: title_course_size),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      "التقييمات",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: whiteColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: title_course_size),
                                    ),
                                  ),
                                ],
                              ),
                              SingleChildScrollView(
                                child: SizedBox(
                                  height: 500, // Adjust the height as needed
                                  child: TabBarView(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(17.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "معلومات عن الكورس",
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      color: whiteColor,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: title_course_size),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: HexColor("#124baf"),
                                                      borderRadius:
                                                      BorderRadius.circular(10.0)),
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    cubit.course[0][0]['price'] != null
                                                        ? cubit.course[0][0]['price']
                                                        .toString() +
                                                        " EGP"
                                                        : "Free",
                                                    style: TextStyle(
                                                      fontSize: font_size,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            ExpandableText(
                                              cubit.course[0][0]['description'].toString(),
                                              expandText: 'show more',
                                              collapseText: 'show less',
                                              maxLines: 6,
                                              linkColor: Colors.blue,
                                              style: TextStyle(
                                                color: whiteColor,
                                                fontSize: font_size,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 70.0,
                                          ),
                                          Text(
                                            "ماذا سوف تتعلم؟",
                                            style: TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: title_course_size,
                                            ),
                                          ),
                                          ListView.separated(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, section) {
                                              lessonsCount = cubit
                                                  .sections[0][section]['lesson']
                                                  .length;
                                              lessonName = cubit.sections[0]
                                              [section]['lesson'];
                                              return ExpansionTileWidget(
                                                section: cubit.sections[0][section],
                                                lesson: cubit.sections[0][section]
                                                ['lesson'],
                                                lessonsCount: lessonsCount,
                                                context: context,
                                              );
                                            },
                                            separatorBuilder: (context, index) =>
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                            itemCount: cubit.sections[0].length,
                                          ),
                                        ],
                                      ),
                                      SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                "قم بتقييم الكورس",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: title_course_size,
                                                ),
                                              ),
                                              SizedBox(height: 16),
                                              RatingBar.builder(
                                                initialRating: rating,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemSize: 30,
                                                itemCount: 5,
                                                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                itemBuilder: (context, _) => Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (value) {
                                                  setState(() {
                                                    rating = value;
                                                  });
                                                },
                                              ),
                                              SizedBox(height: 24),
                                              TextField(
                                                controller: reviewController,
                                                maxLines: 5,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.black87,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText: 'أكتب تقييمك هنا',
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  contentPadding: EdgeInsets.all(16.0),
                                                ),
                                              ),
                                              SizedBox(height: 24),
                                              ElevatedButton(
                                                onPressed: () {
                                                  // Send API request with the rating and review
                                                  print(rating);
                                                  print(reviewController.text);
                                                  // sendFeedback(rating, reviewController.text);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.blue, // Background color
                                                  onPrimary: Colors.white, // Text color
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                                  child: Text(
                                                    'تقييم',
                                                    style: TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 40),
                                              Text(
                                                "تقييمات المستخدمين",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: title_course_size,
                                                ),
                                              ),
                                              SizedBox(height: 16),
                                              // Replace this with your actual user ratings data
                                              for (int i = 0; i < 5; i++)
                                                UserRatingWidget(
                                                  userName: "Ahmed",
                                                  userImage: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                                  userRating: 5,
                                                  userMessage: 'كورس ممتاز جداكورس ممتاز جداكورس ممتاز جداكورس ممتاز جداكورس ممتاز جداكورس ممتاز جداكورس ممتاز جداكورس ممتاز جداكورس ممتاز جداكورس ممتاز جداكورس ممتاز جداكورس ممتاز جداكورس ممتاز جداكورس ممتاز جدا',
                                                ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),


                            // instructors(cubit.course[0].owner, context, ""),
                        SizedBox(height: constrain.maxHeight * 0.04),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: constrain.maxHeight * 0.06,
                            padding: EdgeInsetsDirectional.only(
                              start: constrain.maxWidth * 0.04,
                              end: constrain.maxWidth * 0.04,
                            ),
                            child: FloatingActionButton.extended(
                              onPressed: () async {
                                if (cubit.course[0][0]['is_enrolled'] ||
                                    cubit.course[0][0]['free'] == "1") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Course_sections(
                                        courseId: widget.courseId,
                                      ),
                                    ),
                                  );
                                } else {
                                  var url =
                                      "https://wa.me/+201024579388?text=السلام عليكم اريد تفعيلي في كورس " +
                                          " ( " +
                                          cubit.course[0][0]['name'] +
                                          " ) " +
                                          ". كودي هو ( رجاء كتابة كودك هنا ) ";
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                }
                              },
                              backgroundColor: enrollend_color_or_not,
                              icon: Icon(enrollend_icon_or_not),
                              label: Text(
                                enrollend_string_or_not.toString(),
                                style: TextStyle(
                                  fontSize: main_size,
                                  fontFamily: 'Almarai',
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                            ),
                          ),
                        ),
                      ])),
                    ],
                  );
                });
              } else {
                return ErrorIntrnet();
              }
            },
          ),
        ),
      ),
    );
  }
}
