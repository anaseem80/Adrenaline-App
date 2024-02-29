import 'dart:convert';

import 'package:adrenaline/shared/compontents/conestans.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'course_view_layout_state.dart';

class CourseViewLayoutCubit extends Cubit<CourseViewLayoutState> {
  CourseViewLayoutCubit() : super(CourseViewLayoutInitial());
  static CourseViewLayoutCubit get(context) => BlocProvider.of(context);

  List<dynamic> course = [];
  List<dynamic> sections = [];
  bool isChecked = false;



  void getCourse(id) async {
    emit(CourseLoading());
    var shared = await SharedPreferences.getInstance();
    var dio = Dio();
    await dio.get(
      baseUrl + 'getCourse/' + id,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer '+ shared.getString('token')!,
        },
      ),
    ).then((value) =>
    {
      course.add(value.data),
      sections.add(value.data[0]['section']),
      emit(CourseLoaded()),
    }
    ).catchError((onError) =>
    {
      print(onError),
      emit(CourseFailed()),
    });
  }
}
