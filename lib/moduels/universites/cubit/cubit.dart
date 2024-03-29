import 'package:adrenaline/moduels/universites/cubit/state.dart';
import 'package:adrenaline/models/universites/universites.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adrenaline/shared/compontents/conestans.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UniversitesLayoutCubit extends Cubit<UniversitesLayoutState> {
  UniversitesLayoutCubit() : super(UniversitesInitial());

  static UniversitesLayoutCubit get(context) => BlocProvider.of(context);

  void get_universites() async {
    emit(UniversitesLoading());
    var shared = await SharedPreferences.getInstance();
    var dio = Dio();
    Universites universitesData;
    await dio.get(
      baseUrl + 'getUniversity',
      options: Options(
        headers: {
          'Accept': 'application/json',
          // 'Authorization': 'Bearer '+ shared.getString('token')!,
        },
      ),
    ).then((value) =>
    {
        // debugPrint("Response --> ${value.data}"),
        universitesData = Universites.fromJson(value.data),
        emit(UniversitesLoaded(data: universitesData)),
    }
    ).catchError((onError)=>
    {
      print(onError),
      emit(UniversitesFailed(onError.toString()))
    });
  }
}