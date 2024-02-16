import 'package:arabmedicine/shared/compontents/conestans.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'courses_of_instructor_layout_state.dart';

class CoursesOfInstructorLayoutCubit extends Cubit<CoursesOfInstructorLayoutState> {
  CoursesOfInstructorLayoutCubit() : super(CoursesOfInstructorLayoutInitial());

  static CoursesOfInstructorLayoutCubit get(context) => BlocProvider.of(context);

  List<dynamic> coursesOfInstructor = [];
  void getCustomInstructorData(insId, moduleId) async {
    emit(CoursesOfInstructorLayoutLoading());
    var shared = await SharedPreferences.getInstance();
    var dio = Dio();
    await dio.get(
      baseUrl + 'getCoursesByInstructorModule/insId/' + insId.toString() + "/moduleId/" + moduleId.toString(),
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer '+ shared.getString('token')!,
        },
      ),
    ).then((value)  => {
      coursesOfInstructor.add(value.data),
      emit(CoursesOfInstructorLayoutLoaded()),
    }).catchError((onError) =>{
      print(onError),
      emit(CoursesOfInstructorLayoutFailed()),
    });
  }
}
