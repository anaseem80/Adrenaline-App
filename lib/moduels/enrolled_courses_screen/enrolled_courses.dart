import 'package:adrenaline/shared/compontents/compenants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/widgets/empty_data_widget.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class EnrolledCourses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => EnrolledCoursesLayoutCubit()..main(),
      child:
          BlocConsumer<EnrolledCoursesLayoutCubit, EnrolledCourseLayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = EnrolledCoursesLayoutCubit.get(context);
          if (state is EnrolledCoursesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is EnrolledCoursesLoaded) {
            if (cubit.enrolledCourses[0].length > 0) {
              return LayoutBuilder(builder: (context, size) {
                final widthConstrain = size.maxWidth;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      screen_items_length(
                        title: "الكورسات الخاصة بك",
                        length: cubit.enrolledCourses[0].length,
                        context: context,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10.0, left: 10.0),
                        //margin: EdgeInsets.only(right: 10.0, left: 10.0),
                        child: GridView.builder(
                          itemCount: cubit.enrolledCourses[0].length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => CourseItem(
                              course: cubit.enrolledCourses[0][index],
                              context: context),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                (MediaQuery.of(context).orientation ==
                                        Orientation.landscape)
                                    ? 4
                                    : 2,
                            crossAxisSpacing: widthConstrain * 0.03,
                            mainAxisExtent: 350,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: (1 / 2.5),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
            } else {
              return EmptyData(text:" 😞 انت غير مفعل في اي كورس حتي الان",);
            }
          } else if (state is EnrolledCoursesFailed) {
            return Text(state.error);
          } else {
            return ErrorIntrnet();
          }
        },
      ),
    );
  }
}
