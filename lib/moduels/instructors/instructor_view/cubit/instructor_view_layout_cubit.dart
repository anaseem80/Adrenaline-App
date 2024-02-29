import 'package:adrenaline/shared/compontents/conestans.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'instructor_view_layout_state.dart';

class InstructorViewLayoutCubit extends Cubit<InstructorViewLayoutState> {
  InstructorViewLayoutCubit() : super(InstructorViewLayoutInitial());

  static InstructorViewLayoutCubit get(context) => BlocProvider.of(context);
  List<dynamic> modules = [];
  void getCustomInstructorData(id) async {
    emit(InstructorViewLayoutLoading());
    var shared = await SharedPreferences.getInstance();
    var dio = Dio();
    await dio.get(
      baseUrl + 'getModulesData/' + id.toString(),
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer '+ shared.getString('token')!,
        },
      ),
    ).then((value)  => {
      modules.add(value.data),
      emit(InstructorViewLayoutLoaded()),
    }).catchError((onError) =>{
      print(onError),
      emit(InstructorViewLayoutFailed()),
    });
  }
}
