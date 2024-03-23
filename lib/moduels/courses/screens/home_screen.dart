import 'package:adrenaline/moduels/Search/screens/search.dart';
import 'package:adrenaline/moduels/courses/cubit/cubit.dart';
import 'package:adrenaline/moduels/courses/cubit/state.dart';
import 'package:adrenaline/moduels/courses/screens/widgets/course_item_widget.dart';
import 'package:adrenaline/moduels/instructors/instructors.dart';
import 'package:adrenaline/moduels/universites/universites.dart';
import 'package:adrenaline/shared/compontents/compenants.dart';
import 'package:adrenaline/shared/navigations/navigations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'course_screen/course_screen.dart';

class HomeScreen extends StatelessWidget {
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
              create: (context) => CoursesLayoutCubit()..main()..getHighSchoolCoursesData()..getPublicCoursesData(),
              child: BlocConsumer<CoursesLayoutCubit, CourseLayoutState>(
                  listener: (context, state) async {
                  },
                  builder: (context, state) {
                    var cubit = CoursesLayoutCubit.get(context);
                    return SingleChildScrollView(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [

                            /// Search
                            Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: TextField(
                                onSubmitted: (value) {
                                  NavigationFunctions.routingPage(
                                    context: context,
                                    page: SearchScreen(searchText: value),
                                  );
                                },
                                decoration: InputDecoration(
                                  hintText: 'بحث',
                                  prefixIcon: Icon(Icons.search),
                                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, .1)), // RGB for black
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(color: Color.fromRGBO(0, 0, 255, .1)), // RGB for blue
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),

                            /// Courses
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "الكورسات الرائجة",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            if (cubit.courses.isNotEmpty)
                              CarouselSlider.builder(
                                itemCount: cubit.courses.length,
                                options: CarouselOptions(
                                  height: 230,
                                  aspectRatio: 16/9,
                                  viewportFraction: 0.8,
                                  initialPage: 0,
                                  autoPlay: true,
                                  reverse: true,
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
                                            MaterialPageRoute(builder: (context) => CourseScreen(
                                              courseId: cubit.courses[itemIndex]['id'],
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
                                                  imageUrl: cubit.courses[itemIndex]['image'],
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

                            /// high school Courses
                            Container(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "الثانوية العامة",
                                    style: Theme.of(context).textTheme.headline5,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  if (cubit.courses.isNotEmpty)
                                    SizedBox(
                                      height: 350,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        reverse: true,
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, index) => CourseItemWidget(
                                            course:cubit.highSchoolCoursesModel!.data![index],
                                            context: context
                                        ),
                                        separatorBuilder: (context, index) => SizedBox(
                                          width: 20.0,
                                        ),
                                        itemCount: cubit.highSchoolCoursesModel!.data!.length,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),

                            /// Latest Offers
                            if (cubit.courses.isNotEmpty)
                              Container(
                                padding: EdgeInsets.all(15.0),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "public courses",
                                        style: Theme.of(context).textTheme.headline5,
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      SizedBox(
                                        height: 350,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          reverse: true,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context, index) => CourseItemWidget(
                                              course:cubit.publicCoursesModel!.data![index],
                                              context: context
                                          ),
                                          separatorBuilder: (context, index) => SizedBox(
                                            width: 20.0,
                                          ),
                                          itemCount: cubit.publicCoursesModel!.data!.length,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
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

                              /// Search
                              Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: TextField(
                                  onSubmitted: (value) {
                                    NavigationFunctions.routingPage(
                                      context: context,
                                      page: SearchScreen(searchText: value),
                                    );
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'بحث',
                                    prefixIcon: Icon(Icons.search),
                                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, .1)), // RGB for black
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(color: Color.fromRGBO(0, 0, 255, .1)), // RGB for blue
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),

                              /// Courses
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "الكورسات الرائجة",
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              if (cubit.courses.isNotEmpty)
                              CarouselSlider.builder(
                                itemCount: cubit.courses.length,
                                options: CarouselOptions(
                                  height: 230,
                                  aspectRatio: 16/9,
                                  viewportFraction: 0.8,
                                  initialPage: 0,
                                  autoPlay: true,
                                  reverse: true,
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
                                          MaterialPageRoute(builder: (context) => CourseScreen(
                                            courseId: cubit.courses[itemIndex]['id'],
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
                                              imageUrl: cubit.courses[itemIndex]['image'],
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

                              /// high school Courses
                              Container(
                                padding: EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "الثانوية العامة",
                                      style: Theme.of(context).textTheme.headline5,
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    if (cubit.courses.isNotEmpty)
                                    SizedBox(
                                      height: 350,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        reverse: true,
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, index) => CourseItem(
                                            course:cubit.courses[index],
                                            context: context
                                        ),
                                        separatorBuilder: (context, index) => SizedBox(
                                          width: 20.0,
                                        ),
                                        itemCount: cubit.courses.length,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),

                              /// Latest Offers
                              if (cubit.courses.isNotEmpty)
                              Container(
                                padding: EdgeInsets.all(15.0),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "اخر العروض",
                                        style: Theme.of(context).textTheme.headline5,
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      SizedBox(
                                        height: 350,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          reverse: true,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context, index) => CourseItem(
                                              course:cubit.courses[index],
                                              context: context
                                          ),
                                          separatorBuilder: (context, index) => SizedBox(
                                            width: 20.0,
                                          ),
                                          itemCount: cubit.courses.length,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
            height: 5.0,
          ),
          Universites_Component(),
          SizedBox(
            height: 30.0,
          ),
          Instructors(),
          SizedBox(
            height: 30.0,
          ),
          // Modules(),
        ],
      ),
    );
  }
}