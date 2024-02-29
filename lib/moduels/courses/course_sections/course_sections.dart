import 'dart:io';
import 'package:adrenaline/moduels/courses/course_screen/cubit/course_view_layout_cubit.dart';
import 'package:adrenaline/moduels/mcq/mcq.dart';
import 'package:adrenaline/moduels/pdf/pdf.dart';
import 'package:adrenaline/moduels/player/player.dart';
import 'package:adrenaline/shared/compontents/compenants.dart';
import 'package:adrenaline/shared/styles/styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class Course_sections extends StatefulWidget {
  int? courseId;

  Course_sections({
    this.courseId,
  });

  @override
  State<Course_sections> createState() => _Course_sectionsState();
}

class _Course_sectionsState extends State<Course_sections> {
  var dio = Dio();
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int checkedall = 0;
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) =>
            CourseViewLayoutCubit()..getCourse(widget.courseId.toString()),
        child: BlocConsumer<CourseViewLayoutCubit, CourseViewLayoutState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = CourseViewLayoutCubit.get(context);
            if (state is CourseLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CourseLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, section) {
                          var lessonsCount =
                              cubit.sections[0][section]['lesson'].length;
                          var lesson = cubit.sections[0][section]['lesson'];
                          return Material(
                            color: lowWhiteColor,
                            child: ExpansionTile(
                              textColor: whiteColor,
                              collapsedTextColor: whiteColor,
                              initiallyExpanded: true,
                              iconColor: whiteColor,
                              collapsedIconColor: whiteColor,
                              onExpansionChanged: (val) {
                                lesson = cubit.sections[0][section]['lesson'];
                              },
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Chapter" + " " + (section + 1).toString(),
                                    style: TextStyle(
                                      color: Colors.lightGreen,
                                      fontSize: font_size,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  Text(
                                    cubit.sections[0][section]['section_name'],
                                    style: TextStyle(fontSize: font_size),
                                  ),
                                  SizedBox(
                                    height: 2.0,
                                  )
                                ],
                              ),
                              subtitle: Text(
                                lessonsCount.toString() + " " + "Lessons",
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: font_size,
                                ),
                              ),
                              children: <Widget>[
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var counter = 0;
                                      return InkWell(
                                        onTap: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => player(
                                                      url: lesson[index]['url'],
                                                      lessoneName: lesson[index]
                                                          ['lesson_name'],
                                                    )),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, right: 10.0),
                                          child: ListTile(
                                            title: Row(
                                              children: [
                                                Text(
                                                  (1 + index).toString(),
                                                  style: TextStyle(
                                                    color: whiteColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 25,
                                                ),
                                                Expanded(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      lesson[index]
                                                          ['lesson_name'],
                                                      style: TextStyle(
                                                          color: whiteColor,
                                                          fontSize: font_size),
                                                      maxLines: 100,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Row(
                                                      children: [
                                                        if (lesson[index]
                                                                ['mcq_url'] !=
                                                            null)
                                                          InkWell(
                                                            onTap: () async {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              MCQ(
                                                                                mcq: lesson[index]['mcq_url'],
                                                                              )));
                                                            },
                                                            child: Container(
                                                              color:
                                                                  Colors.black,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .add_task_sharp,
                                                                      color: Colors
                                                                          .lightGreen,
                                                                      size:
                                                                          10.0,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          5.0,
                                                                    ),
                                                                    Text(
                                                                      "Quiz",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            MediaQuery.of(context).size.width *
                                                                                0.022,
                                                                        color: Colors
                                                                            .lightGreen,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        else
                                                          Container(),
                                                        if (lesson[index][
                                                                'pdf_attach'] !=
                                                            null)
                                                          InkWell(
                                                            onTap: () async {
                                                              print("pdf");
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              PDF(
                                                                                pdf: lesson[index]['pdf_attach'],
                                                                              )));
                                                            },
                                                            child: Container(
                                                              color:
                                                                  Colors.black,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .picture_as_pdf,
                                                                      color: Colors
                                                                          .lightGreen,
                                                                      size:
                                                                          10.0,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          5.0,
                                                                    ),
                                                                    Text(
                                                                      "Pdf",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            MediaQuery.of(context).size.width *
                                                                                0.022,
                                                                        color: Colors
                                                                            .lightGreen,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        else
                                                          Container(),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                                // Checkbox(
                                                //   value: isChecked,
                                                //   onChanged: (bool? value) {
                                                //     print(value);
                                                //     setState(() {
                                                //       isChecked = !isChecked;
                                                //     });
                                                //   },
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                    itemCount: lessonsCount!)
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 5.0,
                        ),
                        itemCount: cubit.sections[0].length,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return ErrorIntrnet();
            }
          },
        ),
      ),
    );
  }
}
