
import 'package:adrenaline/shared/compontents/conestans.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



part 'course_view_layout_state.dart';

class CourseViewLayoutCubit extends Cubit<CourseViewLayoutState> {
  CourseViewLayoutCubit() : super(CourseViewLayoutInitial());
  static CourseViewLayoutCubit get(context) => BlocProvider.of(context);

  List<dynamic> course = [];
  List<dynamic> sections = [];
  bool isChecked = false;



  void getCourse(id) async {
    emit(CourseLoading());
    var shared = await SharedPreferences.getInstance();
    var dio = Dio();
    await dio.get(
      baseUrl + 'getCourse/' + id,
      options: Options(
        headers: {
          'Accept': 'application/json',
          // 'Authorization': 'Bearer '+ shared.getString('token')!,
        },
      ),
    ).then((value) =>
    {
      course.add(value.data),
      sections.add(value.data[0]['section']),
      emit(CourseLoaded()),
    }
    ).catchError((onError) =>
    {
      print(onError),
      emit(CourseFailed()),
    });
  }

  /// Review
  void reviewCourse({
    required BuildContext context,
    required String reviewDescription,
    required double reviewStar,
    required int userId,
    required int courseId,
  }) async {
    // debugPrint("${reviewDescription} -- ${reviewStar} -- ${userId} -- ${courseId}");
    var shared = await SharedPreferences.getInstance();
    emit(ReviewLoadingState());
    var headers = {
      'Authorization': 'Bearer 34|pzu17ESkuyiiHsUyhLupRZ1JmLd61OXSG4b621N6',
      'Cookie': 'XSRF-TOKEN=eyJpdiI6ImoySjl1NHpYbWZZNm1ROTRxYWZ1N2c9PSIsInZhbHVlIjoid09vaDMrSnNXejh4bERSTGVRZHFDaW05c3hUUU1VMHlKS25xMnk3TjhJbWk2ZjlTdzdSRkxnS0JCcG5WUGN5aFg2MGlWa21SSDlMMCsrWWFxaHZUMVZBWElkcUt2d0sxaGliRFhha0VFRTA0YTNCZmlZaFlNclFGVEo5STA2QngiLCJtYWMiOiI5OWY5OWU3NDdjMGJjOWVjNGJjZjE4NDk1ODQ5MTEyODgwMGVhMWRjZTA0ZmNmYzI3ZjE1NmRmZmY1Nzc2NjBlIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6Ilh5Q0V5dG5SNVhlK0VsWlpTVnNVcVE9PSIsInZhbHVlIjoiV1pJTlN3aWYyMmxKOGw2K0JCcTUzWHpBZ25pVHRuQjJGTy9Gak9WMFJSR21lYm9lWVE2bUtsSDM3b1VmVkE5Vk1tM1FYQzY4SitpOGEzQTNjOVZFYlBrd0dtOW1FYXF3SUo3VXVmVDluUVF2T0NGZTZVVHM4ZWk1TFQ3N2p1b04iLCJtYWMiOiI4NDVhMWYzODRiMDNlMWJkYmNhMzQxNGJlMTU2ZjU1OWZkYTBiOTlkZTRlZjJhNDczZmE2MWIyYTM2NmMzMDhhIiwidGFnIjoiIn0%3D'
    };
    var request = http.Request('POST', Uri.parse('https://adrenaline-edu.com/arab_api_v1/create-review?rating=${reviewStar.ceil()}&review=$reviewDescription&course_id=$courseId&userId=$userId'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      AlertDialog(title: Text('تم ارسال التقييم بنجاح'),);
      // ToastSnackBar(context: context, message: "تم ارسال التقييم بنجاح", status: Status.warning);
      // debugPrint("response --> ${await response.stream.bytesToString()}");
      emit(ReviewSuccessState());
    }
    else {
      // debugPrint(response.reasonPhrase);
      emit(ReviewErrorState(error: response.reasonPhrase.toString()));
    }
  }

}
