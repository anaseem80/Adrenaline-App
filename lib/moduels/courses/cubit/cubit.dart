import 'dart:convert';

import 'package:adrenaline/moduels/courses/cubit/state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:adrenaline/shared/compontents/conestans.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CoursesLayoutCubit extends Cubit<CourseLayoutState> {
  CoursesLayoutCubit() : super(CoursesInitial());

  static CoursesLayoutCubit get(context) => BlocProvider.of(context);

  var courseslenght = 0;

  List<dynamic> courses = [];

  void main() async {
    emit(CoursesLoading());
    var shared = await SharedPreferences.getInstance();
    var dio = Dio();
    await dio.get(
      baseUrl + 'getCourses',
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer '+ shared.getString('token')!,
        },
      ),
    ).then((value) =>
    {
      debugPrint("Courses ${value.data}"),
      courses = value.data,
      debugPrint("Courses ${courses[0]}"),
      emit(CoursesLoaded()),
    }
    ).catchError((onError) =>
    {
      print(onError),
      emit(CoursesFailed(onError)),
    });
  }
}