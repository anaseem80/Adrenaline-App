import 'dart:convert';
import 'package:adrenaline/models/Lectures_model/lectures.dart';
import 'package:dio/dio.dart';
import 'package:adrenaline/shared/compontents/conestans.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'player_layout_state.dart';

class PlayerLayoutCubit extends Cubit<PlayerLayoutState> {
  PlayerLayoutCubit() : super(PlayerLayoutInitial());

  static PlayerLayoutCubit get(context) => BlocProvider.of(context);

  List<dynamic> videos = [];
  var response;
  Lecture? lecture;
  void getVideo(url) async {
    emit(PlayerLayoutLoading());
    var shared = await SharedPreferences.getInstance();
    var formData = FormData.fromMap({
      "youtube_url":url,
    });
    var dio = Dio();
    await dio.post(
      baseUrl + 'get_youtube_qualities',
      data: formData,
      options: Options(
        headers: {
          'Accept': 'application/json',
          // 'Authorization': 'Bearer '+ shared.getString('token')!,
        },
      ),
    ).then((value) async => {
        videos.add(value.data),
        lecture = await Lecture.fromJson(value.data),
        print(videos),
        emit(PlayerLayoutLoaded()),
    }).catchError((onError) =>{
        print(onError),
        emit(PlayerLayoutFailed()),
    });
  }
}
