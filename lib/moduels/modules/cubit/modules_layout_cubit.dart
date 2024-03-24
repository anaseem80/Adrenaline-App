import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:adrenaline/shared/compontents/conestans.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'modules_layout_state.dart';

class ModulesLayoutCubit extends Cubit<ModulesLayoutState> {
  ModulesLayoutCubit() : super(ModulesLayoutInitial());

  static ModulesLayoutCubit get(context) => BlocProvider.of(context);

  List<dynamic> modules = [];

  void getModules() async {
    emit(ModulesLayoutLoading());
    var shared = await SharedPreferences.getInstance();
    var dio = Dio();
    await dio.get(
      baseUrl + 'getModules',
      options: Options(
        headers: {
          'Accept': 'application/json',
          // 'Authorization': 'Bearer '+ shared.getString('token')!,
        },
      ),
    ).then((value)  => {
        modules.add(value.data),
        emit(ModulesLayoutLoaded()),
    }).catchError((onError) =>{
        print(onError),
        emit(ModulesLayoutFailed()),
    });
  }
}
