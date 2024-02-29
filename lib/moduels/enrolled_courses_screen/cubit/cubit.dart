import 'dart:convert';

import 'package:adrenaline/moduels/courses/cubit/state.dart';
import 'package:adrenaline/moduels/enrolled_courses_screen/cubit/state.dart';
import 'package:adrenaline/shared/server_gate.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:adrenaline/shared/compontents/conestans.dart';
import 'package:shared_preferences/shared_preferences.dart';
class EnrolledCoursesLayoutCubit extends Cubit<EnrolledCourseLayoutState> {
  EnrolledCoursesLayoutCubit() : super(EnrolledCoursesInitial());

  static EnrolledCoursesLayoutCubit get(context) => BlocProvider.of(context);

  ServerGate serverGate  = ServerGate();



  List<dynamic> enrolledCourses = [];

  // void getData()async {
  //   emit(EnrolledCoursesLoading());
  //   var shared = await SharedPreferences.getInstance();
  //   serverGate.addInterceptors();
  //   CustomResponse response  = await serverGate.getFromServer(
  //     url: 'getEnrolledCourses',
  //     headers: {
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer '+ shared.getString('token')!,
  //     },
  //   );
  //   if(response.success) {
  //     enrolledCourses.add(response.response!.data);
  //     emit(EnrolledCoursesLoaded());
  //   }else{emit(EnrolledCoursesFailed(response.msg));
  //   }
  //
  // }

  void main() async {
    emit(EnrolledCoursesLoading());
    var shared = await SharedPreferences.getInstance();
    var dio = Dio();
    await dio.get(
      baseUrl + 'getEnrolledCourses',
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer '+ shared.getString('token')!,
        },
      ),
    ).then((value) =>
    {
      enrolledCourses.add(value.data),
      emit(EnrolledCoursesLoaded()),
    }
    ).catchError((onError) =>
    {
      emit(EnrolledCoursesFailed(onError)),
    });
  }
}