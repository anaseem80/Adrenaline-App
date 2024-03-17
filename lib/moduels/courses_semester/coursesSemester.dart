// ignore_for_file: must_be_immutable

import 'package:adrenaline/shared/compontents/compenants.dart';
import 'package:adrenaline/shared/compontents/imports.dart';
import 'package:flutter/material.dart';

import 'cubit/cubit.dart';
import 'cubit/state.dart';

class CoursesSemester extends StatelessWidget {
  int? semesterId;
  CoursesSemester({
    this.semesterId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => CoursesSemesterLayoutCubit()..getCoursesSemester(semesterId),
        child: BlocConsumer<CoursesSemesterLayoutCubit, CoursesSemesterLayoutState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = CoursesSemesterLayoutCubit.get(context);
            if(state is CoursesSemesterLoading){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else if(state is CoursesSemesterLoaded){
              if(cubit.courses[0].length > 0){
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 7.0,
                        left: 7.0
                    ),
                    child: Column(
                      children: [
                        screen_items_length(
                          title: "الكورسات",
                          length:  cubit.courses[0].length, context: context,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                            padding: EdgeInsets.all(15.0),
                            margin: EdgeInsets.only(
                                right: 10.0,
                                left: 10.0
                            ),
                            child: GridView.count(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: (MediaQuery.of(context).orientation == Orientation.landscape) ? 4 : 2,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0,
                                childAspectRatio: 1 / 2.5,
                                children: List.generate(
                                  cubit.courses[0].length,
                                      (index) => CourseItem(
                                      course: cubit.courses[0][index],
                                      context: context
                                  ),)
                            )
                        )
                      ],
                    ),
                  ),
                );
              }else{
                return Center(
                  child: Text(
                    "No data to show",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                );
              }
            }else{
              return ErrorIntrnet();
            }
          },
        ),
      ),
    );
  }
}
