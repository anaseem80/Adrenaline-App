import 'dart:convert';

import 'package:adrenaline/models/login_model/login_model.dart';
import 'package:adrenaline/models/register_model/register_model.dart';
import 'package:adrenaline/shared/compontents/compenants.dart';
import 'package:adrenaline/shared/compontents/conestans.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:platform_device_id/platform_device_id.dart';

part 'register_layout_state.dart';

class RegisterLayoutCubit extends Cubit<RegisterLayoutState> {
  RegisterLayoutCubit() : super(RegisterLayoutInitial());

  static RegisterLayoutCubit get(context) => BlocProvider.of(context);

  RegisterModel? registerModel;

  void userRegister({
    required firstname,
    required lastname,
    required email,
    required password,
    required password_confirmation,
  }) async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    emit(RegisterLoading());
    final response = http.post(
      Uri.parse(baseUrl + 'register'),
      body: {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'password': password,
        'password_confirmation': password_confirmation,
        'device_token': deviceId.toString(),
      },
      headers:{
        'Accept': 'application/json',
      },
    ).then((value)  => {
      registerModel = RegisterModel.fromJson(jsonDecode(value.body)),
      emit(RegisterLoaded(registerModel!)),
    }).catchError((onError) =>{
      print(onError),
      emit(RegisterFailed()),
    });

  }
}
