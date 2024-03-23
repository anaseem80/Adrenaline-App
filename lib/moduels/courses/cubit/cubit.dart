
import 'package:adrenaline/moduels/courses/cubit/state.dart';
import 'package:adrenaline/moduels/courses/models/course_model.dart';
import 'package:adrenaline/shared/enums/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adrenaline/shared/compontents/conestans.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoursesLayoutCubit extends Cubit<CourseLayoutState> {
  CoursesLayoutCubit() : super(CoursesInitial());

  static CoursesLayoutCubit get(context) => BlocProvider.of(context);

  List<dynamic> courses = [];

  void main() async {
    emit(CoursesLoading());
    var shared = await SharedPreferences.getInstance();
    var dio = Dio();
    await dio.get(
      baseUrl + 'getCourses',
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + shared.getString('token')!,
        },
      ),
    ).then((value) =>
    {
      debugPrint("Courses ${value.data}"),
      courses = value.data,
      debugPrint("Courses ${courses[0]}"),
      emit(CoursesLoaded()),
    }
    ).catchError((onError) =>
    {
      print(onError),
      // emit(CoursesFailed(onError)),
    });
  }


//high school
CourseModel? highSchoolCoursesModel = CourseModel(
  message: '',data: [],statusCode: 0
);

  RequestState highSchoolState = RequestState.none;

  void getHighSchoolCoursesData() {
    emit(GetHighSchoolLoadingEvent());
   highSchoolState=RequestState.loading;
      Dio().get(
       baseUrl+'courses/getCoursesbyType',
      queryParameters: {'type':'high_school'},
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    ).then((value) {
      highSchoolCoursesModel = CourseModel.fromJson(value.data);
      highSchoolState=RequestState.loaded;
      emit(GetHighSchoolLoadedEvent());
    }).catchError((error) {
      highSchoolState = RequestState.error;
      emit(GetHighSchoolErrorEvent());
    });
  }

  //public
  CourseModel? publicCoursesModel = CourseModel(
      message: '',data: [],statusCode: 0
  );

  RequestState publicState = RequestState.none;

  void getPublicCoursesData() async{
    emit(GetPublicLoadingEvent());
    highSchoolState=RequestState.loading;
   await Dio().get(
     baseUrl+'courses/getCoursesbyType',
     queryParameters: {'type':'public'},
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    ).then((value) {
      print(value.data);
      print('aghyad');
      publicCoursesModel = CourseModel.fromJson(value.data);
      publicState = RequestState.loaded;
      emit(GetPublicLoadedEvent());
    }).catchError((error) {
     publicState = RequestState.error;
      emit(GetPublicErrorEvent());
    });
  }

  //public medicine
  CourseModel? publicMedicineCoursesModel = CourseModel(
      message: '',data: [],statusCode: 0
  );

  RequestState publicMedicineState = RequestState.none;

  void getPublicMedicineCoursesData() async{
    emit(GetPublicMedicineLoadingEvent());
    highSchoolState=RequestState.loading;
    await Dio().get(
      baseUrl+'/courses/getCoursesbyType',
      queryParameters: {'type':'public_medicine'},
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    ).then((value) {
      print(value.data);
      publicMedicineCoursesModel=CourseModel.fromJson(value.data);
      publicMedicineState=RequestState.loaded;
      emit(GetPublicMedicineLoadedEvent());
    }).catchError((error) {
      publicMedicineState = RequestState.error;
      emit(GetPublicMedicineErrorEvent());
    });
  }





}