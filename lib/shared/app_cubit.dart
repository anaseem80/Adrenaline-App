import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:adrenaline/models/user/user_model.dart';
import 'package:adrenaline/shared/app_state.dart';
import 'package:adrenaline/shared/compontents/conestans.dart';
import 'package:adrenaline/shared/network/local/cache_helper.dart';
import 'package:adrenaline/shared/styles/styles.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  List<dynamic> user = [];
  void getActiveUser() async {
    emit(AppGetActiveUserLoadingState());
    var shared = await SharedPreferences.getInstance();
    var dio = Dio();
    await dio.post(
      baseUrl + 'get_active_user',
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer '+ shared.getString('token')!,
        },
      ),
    ).then((value) =>
    {
      user.add(value.data),
      emit(AppGetActiveUserState()),
    }
    ).catchError((onError) =>
    {
      print(onError),
      emit(AppGetActiveUserFailedState()),
    });
  }

  bool isDark = true;

  void toggleMode(){
    isDark = !isDark;
    if(isDark){
      whiteColor = HexColor("ffffff");
      lowWhiteColor = HexColor("1e1e1e");
    }else{
      whiteColor = HexColor("000000");
      lowWhiteColor = HexColor("f7f7f7");
    }
    emit(AppChangeModeState());
  }
  String userStatus = "";
  void deleteUserAccount() async{
    emit(AppDeleteUserLoading());
    var shared = await SharedPreferences.getInstance();
    var dio = Dio();
    await dio.post(
      baseUrl + 'deleteAccount',
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer '+ shared.getString('token')!,
        },
      ),
    ).then((value) =>
    {
      userStatus = value.data['message'],
      emit(AppDeleteUserSuccess()),
    }
    ).catchError((onError) =>
    {
      print(onError),
      emit(AppDeleteUserFailed())
    });
  }
}
