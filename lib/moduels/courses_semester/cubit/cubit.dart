import 'package:adrenaline/moduels/courses_semester/cubit/state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adrenaline/shared/compontents/conestans.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CoursesSemesterLayoutCubit extends Cubit<CoursesSemesterLayoutState> {
  CoursesSemesterLayoutCubit() : super(CoursesSemesterInitial());

  static CoursesSemesterLayoutCubit get(context) => BlocProvider.of(context);

  List<dynamic> courses = [];
  bool isChecked = false;



  void getCoursesSemester(id) async {
    emit(CoursesSemesterLoading());
    var shared = await SharedPreferences.getInstance();
    var dio = Dio();
    await dio.get(
      baseUrl + 'semesters/$id/courses',
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer '+ shared.getString('token')!,
        },
      ),
    ).then((value) =>
    {
      courses.add(value.data),
      emit(CoursesSemesterLoaded()),
    }
    ).catchError((onError) =>
    {
      emit(CoursesSemesterFailed(onError)),
    });
  }
}