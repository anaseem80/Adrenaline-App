import 'dart:convert';
import 'package:adrenaline/moduels/instructors/instructor_view/instructor_view.dart';
import 'package:dio/dio.dart';
import 'package:adrenaline/shared/compontents/conestans.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/instructor_model.dart';

part 'instructors_layout_state.dart';

class InstructorsLayoutCubit extends Cubit<InstructorsLayoutState> {
  InstructorsLayoutCubit() : super(InstructorsLayoutInitial());

  static InstructorsLayoutCubit get(context) => BlocProvider.of(context);

  InstructorModel instructors = InstructorModel(
    statusCode: 0,
    message: '',
    data: []
  ) ;

  void getInstructors() async {
    var shared = await SharedPreferences.getInstance();
    var dio = Dio();
    await dio.get(
      baseUrl + 'getInstructors',
      options: Options(
        headers: {
          'Accept': 'application/json',
          // 'Authorization': 'Bearer '+ shared.getString('token')!,
        },
      ),
    ).then((value)  => {
        instructors = InstructorModel.fromJson(value.data),
        emit(InstructorsLayoutLoaded()),
    }).catchError((onError) =>{
        print(onError),
        emit(InstructorsLayoutFailed()),
    });
  }
}
