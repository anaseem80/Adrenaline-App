import 'package:adrenaline/moduels/banners/cubit/banners_state.dart';
import 'package:adrenaline/moduels/banners/models/banners_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/compontents/conestans.dart';
import '../../../shared/enums/enums.dart';

class BannersCubit extends Cubit<BannersState> {
  BannersCubit() : super(BannersInitialState());

  static BannersCubit get(context) => BlocProvider.of(context);


  //main banners
  BannersModel? mainBannersModel = BannersModel(
      message: '',statusCode: 0,banners: []
  );

  RequestState mainBannersState = RequestState.none;

  void getMainBannersData() async{
    emit(GetMainBannersLoadingEvent());
    mainBannersState=RequestState.loading;
    await Dio().get(
      baseUrl+'banners/data',
      queryParameters: {'type':'main'},
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    ).then((value) {
      mainBannersModel = BannersModel.fromJson(value.data);
      print(value.data);
      mainBannersState = RequestState.loaded;
      emit(GetMainBannersLoadedEvent());
    }).catchError((error) {
      mainBannersState = RequestState.error;
      emit(GetMainBannersErrorEvent());
    });
  }

  //universities banners
  BannersModel? universitiesBannersModel = BannersModel(
      message: '',statusCode: 0,banners: []
  );

  RequestState universitiesBannersState = RequestState.none;

  void getUniversitiesBannersData() async{
    emit(GetCollegeBannersLoadingEvent());
    universitiesBannersState=RequestState.loading;
    await Dio().get(
      baseUrl+'banners/data',
      queryParameters: {'type':'college'},
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    ).then((value) {
      universitiesBannersModel = BannersModel.fromJson(value.data);
      print(value.data);
      universitiesBannersState = RequestState.loaded;
      emit(GetCollegeBannersLoadedEvent());
    }).catchError((error) {
      universitiesBannersState = RequestState.error;
      emit(GetCollegeBannersErrorEvent());
    });
  }

  //public course banners
  BannersModel? publicCoursesBannersModel = BannersModel(
      message: '',statusCode: 0,banners: []
  );

  RequestState publicCoursesBannersState = RequestState.none;

  void getPublicCoursesBannersData() async{
    emit(GetPublicBannersLoadingEvent());
    publicCoursesBannersState=RequestState.loading;
    await Dio().get(
      baseUrl+'banners/data',
      queryParameters: {'type':'public_course'},
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    ).then((value) {
      publicCoursesBannersModel = BannersModel.fromJson(value.data);
      print(value.data);
      publicCoursesBannersState = RequestState.loaded;
      emit(GetPublicBannersLoadedEvent());
    }).catchError((error) {
      publicCoursesBannersState = RequestState.error;
      emit(GetPublicBannersLoadedEvent());
    });
  }


}