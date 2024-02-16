import 'dart:convert';
import 'package:arabmedicine/moduels/courses/course_screen/course_screen.dart';
import 'package:arabmedicine/moduels/courses/cubit/cubit.dart';
import 'package:arabmedicine/moduels/courses/cubit/state.dart';
import 'package:arabmedicine/moduels/instructors/cubit/instructors_layout_cubit.dart';
import 'package:arabmedicine/moduels/instructors/instructors.dart';
import 'package:arabmedicine/moduels/modules/modules.dart';
import 'package:arabmedicine/shared/compontents/compenants.dart';
import 'package:arabmedicine/shared/network/local/cache_helper.dart';
import 'package:arabmedicine/shared/network/remote/response.dart';
import 'package:arabmedicine/shared/styles/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home_screen extends StatelessWidget {
  final List<String> items = [
    'Courses',
    'Modules',
    'Instructors',
  ];
  String? selectedValue;
  String? buttonValue;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocProvider(
              create: (context) => CoursesLayoutCubit()..main(),
              child: BlocConsumer<CoursesLayoutCubit, CourseLayoutState>(
                  listener: (context, state) async {
                  },
                  builder: (context, state) {
                    var cubit = CoursesLayoutCubit.get(context);
                    if(state is CoursesLoading){
                      return Center(
                          child: CircularProgressIndicator()
                      );
                    }
                    else if (state is CoursesLoaded){
                      return SingleChildScrollView(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                "الكورسات الرائجة",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              CarouselSlider.builder(
                                itemCount: cubit.courses[0].length,
                                options: CarouselOptions(
                                  height: 230,
                                  aspectRatio: 16/9,
                                  viewportFraction: 0.8,
                                  initialPage: 0,
                                  autoPlay: true,
                                  reverse: false,
                                  autoPlayInterval: Duration(seconds: 3),
                                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                ),
                                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                          MaterialPageRoute(builder: (context) => course_screen(
                                            courseId: cubit.courses[0][itemIndex]['id'],
                                          ))
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(15.0),
                                            child: CachedNetworkImage(
                                              imageUrl: cubit.courses[0][itemIndex]['image'],
                                              imageBuilder: (context, imageProvider) => Container(
                                                height: 200,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context,url) => Container(
                                                height: 200,
                                                child: Container(
                                                  height: 15,
                                                  child: Center(child: CircularProgressIndicator()),
                                                ),
                                              ),
                                              errorWidget: (context,url,error) => Container(
                                                height: 200,
                                                child: Container(
                                                  height: 15,
                                                  child: Center(child: CircularProgressIndicator()),
                                                ),
                                              ),
                                            ),

                                          )
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(7.0),
                                          width: 60.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15.0),
                                            color: Colors.green,
                                          ),
                                          child: Text(
                                            "Top",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Container(
                                padding: EdgeInsets.all(15.0),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "احدث الكورسات",
                                        style: Theme.of(context).textTheme.headline5,
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      SizedBox(
                                        height: 350,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context, index) => CourseItem(
                                            course:cubit.courses[0][index],
                                            context: context
                                          ),
                                          separatorBuilder: (context, index) => SizedBox(
                                            width: 20.0,
                                          ),
                                          itemCount: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    else if(state is CoursesFailed){
                      return Center(
                        child: Container(
                          child: Text(state.error),
                        ),
                      );
                    }else{
                      return Container();
                    }
                  }
              )
          ),
          SizedBox(
            height: 30.0,
          ),
          Instructors(),
          SizedBox(
            height: 30.0,
          ),
          Modules(),
        ],
      ),
    );
  }
}