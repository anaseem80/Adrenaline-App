import 'dart:convert';
import 'package:adrenaline/models/semesters/semesters.dart';
import 'package:adrenaline/moduels/Semester/cubit/state.dart';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:adrenaline/shared/compontents/conestans.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SemestersLayoutCubit extends Cubit<SemestersLayoutState> {
  SemestersLayoutCubit() : super(SemestersInitial());

  static SemestersLayoutCubit get(context) => BlocProvider.of(context);

  void get_Semesters(id) async {
    emit(SemestersLoading());
    var shared = await SharedPreferences.getInstance();
    var dio = Dio();
    Semesters SemestersData;
    await dio.get(
      baseUrl + 'years/$id/semesters',
      options: Options(
        headers: {
          'Accept': 'application/json',
          // 'Authorization': 'Bearer '+ shared.getString('token')!,
        },
      ),
    ).then((value) =>
    {
        Semesters ,SemestersData = Semesters.fromJson(value.data),
        emit(SemestersLoaded(data: SemestersData)),
    }
    ).catchError((onError) =>
    {
      print(onError),
      emit(SemestersFailed(onError)),
    });
  }
}