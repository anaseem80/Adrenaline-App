import 'package:adrenaline/moduels/courses/courses_screen/cubit/courses_of_instructor_layout_cubit.dart';
import 'package:adrenaline/shared/compontents/compenants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Courses_screen extends StatelessWidget {
  int? moduleId;
  String? createdBy;
  String? instructorId;
  String? moduleName;
  String? instructorFirstName;
  String? instructorLastName;
  Courses_screen({
    this.moduleId,
    this.createdBy,
    this.instructorId,
    this.moduleName,
    this.instructorFirstName,
    this.instructorLastName,
  });
  String getOwnerModuleId() {
    if(createdBy == null){
      return instructorId!;
    }else{
      return createdBy!;
    }
    return "h";
  }
  String getModuleInstructorNames() {
    if(instructorFirstName != null){
      return instructorFirstName.toString() + " In " + moduleName.toString();
    }else{
      return moduleName.toString();
    }
    return "h";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            getModuleInstructorNames()
        ),
      ),
      body: BlocProvider(
        create: (context) => CoursesOfInstructorLayoutCubit()..getCustomInstructorData(getOwnerModuleId(), moduleId),
          child: BlocConsumer<CoursesOfInstructorLayoutCubit, CoursesOfInstructorLayoutState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = CoursesOfInstructorLayoutCubit.get(context);
            if(state is CoursesOfInstructorLayoutLoading){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else if(state is CoursesOfInstructorLayoutLoaded){
              if(cubit.coursesOfInstructor[0].length > 0){
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
                          length:  cubit.coursesOfInstructor[0].length, context: context,
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
                                  cubit.coursesOfInstructor[0].length,
                                      (index) => CourseItem(
                                      course: cubit.coursesOfInstructor[0][index],
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
      )
    );
  }
}
