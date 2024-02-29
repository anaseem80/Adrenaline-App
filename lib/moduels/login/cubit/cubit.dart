import 'dart:convert';
import 'package:adrenaline/layout/home_layout.dart';
import 'package:adrenaline/models/login_model/login_model.dart';
import 'package:adrenaline/models/user/user_model.dart';
import 'package:adrenaline/shared/compontents/compenants.dart';
import 'package:adrenaline/shared/network/local/cache_helper.dart';
import 'package:dio/dio.dart';
import 'package:adrenaline/moduels/login/cubit/state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:adrenaline/shared/compontents/conestans.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';

class LoginLayoutCubit extends Cubit<LoginLayoutState> {
  LoginLayoutCubit() : super(LoginInitial());

  static LoginLayoutCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;
  void userLogin({
    required email,
    required password,
    required context,
  }) async {
    String? deviceId = await PlatformDeviceId.getDeviceId;

    emit(LoginLoading());

    final response = http.post(
      Uri.parse( baseUrl + 'login'),
      body: {
        'email': email,
        'password': password,
        'device_token': deviceId.toString(),
      },
      headers:{
        'Accept': 'application/json',
      },
    ).then((value)  => {
      loginModel = LoginModel.fromJson(jsonDecode(value.body)),
      emit(LoginLoaded(loginModel!)),
    }).catchError((onError) =>{
      emit(LoginFailed(onError)),
      print(onError)
    });

  }
}