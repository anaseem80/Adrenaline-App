import 'dart:convert';
import 'package:arabmedicine/moduels/instructors/instructor_view/instructor_view.dart';
import 'package:dio/dio.dart';
import 'package:arabmedicine/shared/compontents/conestans.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'instructors_layout_state.dart';

class InstructorsLayoutCubit extends Cubit<InstructorsLayoutState> {
  InstructorsLayoutCubit() : super(InstructorsLayoutInitial());

  static InstructorsLayoutCubit get(context) => BlocProvider.of(context);

  List<dynamic> instructors = [];

  void getInstructors() async {
    var shared = await SharedPreferences.getInstance();
    var dio = Dio();
    await dio.get(
      baseUrl + 'getInstructorsData',
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer '+ shared.getString('token')!,
        },
      ),
    ).then((value)  => {
        instructors.add(value.data),
        emit(InstructorsLayoutLoaded()),
    }).catchError((onError) =>{
        print(onError),
        emit(InstructorsLayoutFailed()),
    });
  }
}
