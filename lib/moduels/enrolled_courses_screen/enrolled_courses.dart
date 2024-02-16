import 'package:arabmedicine/moduels/enrolled_courses_screen/cubit/cubit.dart';
import 'package:arabmedicine/moduels/enrolled_courses_screen/cubit/state.dart';
import 'package:arabmedicine/shared/compontents/compenants.dart';
import 'package:arabmedicine/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class enrolled_courses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
                final hightConstrain = size.maxHeight;
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
              return Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/exercise-walk.gif"),
                          radius: 70,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            "😞 انت غير مفعل في اي كورس حتي الان",
                            style: Theme.of(context).textTheme.headline3,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
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
