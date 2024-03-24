import 'dart:convert';

import 'package:adrenaline/moduels/collages/cubit/state.dart';
import 'package:adrenaline/models/collages/collages.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:adrenaline/shared/compontents/conestans.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CollagesLayoutCubit extends Cubit<CollagesLayoutState> {
  CollagesLayoutCubit() : super(CollagesInitial());

  static CollagesLayoutCubit get(context) => BlocProvider.of(context);

  var courseslenght = 0;

  List<dynamic> collages = [];

  void get_collages(id) async {
    emit(CollagesLoading());
    var shared = await SharedPreferences.getInstance();
    var dio = Dio();
    Collages collagesData;
    await dio.get(
      baseUrl + 'university/$id/college',
      options: Options(
        headers: {
          'Accept': 'application/json',
          // 'Authorization': 'Bearer '+ shared.getString('token')!,
        },
      ),
    ).then((value) =>
    {
        Collages ,collagesData = Collages.fromJson(value.data),
        emit(CollagesLoaded(data: collagesData)),
    }
    ).catchError((onError) =>
    {
      print(onError),
      emit(CollagesFailed(onError)),
    });
  }
}