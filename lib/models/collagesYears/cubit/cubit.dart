import 'dart:convert';

import 'package:adrenaline/models/collagesYears/collageYears.dart';
import 'package:adrenaline/moduels/collage_year/cubit/state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:adrenaline/shared/compontents/conestans.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CollageYearsLayoutCubit extends Cubit<CollageYearsLayoutState> {
  CollageYearsLayoutCubit() : super(CollageYearsInitial());

  static CollageYearsLayoutCubit get(context) => BlocProvider.of(context);

  void get_collage_years(id) async {
    emit(CollageYearsLoading());
    var shared = await SharedPreferences.getInstance();
    var dio = Dio();
    CollageYears CollageYearsData;
    await dio.get(
      baseUrl + 'colleges/$id/years',
      options: Options(
        headers: {
          'Accept': 'application/json',
          // 'Authorization': 'Bearer '+ shared.getString('token')!,
        },
      ),
    ).then((value) =>
    {
        CollageYears ,CollageYearsData = CollageYears.fromJson(value.data),
        emit(CollageYearsLoaded(data: CollageYearsData)),
    }
    ).catchError((onError) =>
    {
      print(onError),
      emit(CollageYearsFailed(onError)),
    });
  }
}