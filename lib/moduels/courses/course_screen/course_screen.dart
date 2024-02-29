import 'dart:io';

import 'package:adrenaline/moduels/courses/course_screen/cubit/course_view_layout_cubit.dart';
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

class course_screen extends StatelessWidget {
  int? courseId;

  course_screen({
    this.courseId,
  });
  int? lessonsCount;
  dynamic? lessonName;

  String? enrollend_string_or_not;
  Color? enrollend_color_or_not;
  IconData? enrollend_icon_or_not;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            CourseViewLayoutCubit()..getCourse(courseId.toString()),
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
                            cubit.course[0][0]['is_enrolled']
                                ? Column(
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
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      SizedBox(height: constrain.maxHeight * 0.04),
                      Container(
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
                                          courseId: courseId,
                                        )),
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
                              borderRadius: BorderRadius.circular(35)),
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
    );
  }
}
