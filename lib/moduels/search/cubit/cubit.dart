import 'package:adrenaline/shared/compontents/imports.dart';
import 'package:dio/dio.dart';

import '../../../shared/compontents/conestans.dart';
import 'states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitSearchState());

  static SearchCubit get(context) => BlocProvider.of(context);

  List<dynamic> courses = [];
  void searchCourses({required String searchText}) async {
    emit(SearchCoursesLoadingState());
    var shared = await SharedPreferences.getInstance();
    debugPrint("token ${shared.getString('token')}");
    var dio = Dio();
    await dio.get(
      baseUrl + 'search?word=$searchText&field=courses',
      options: Options(
        headers: {
          'Authorization': shared.getString('token'),
        },
      ),
    ).then((value) {
      debugPrint("data ${value.data}");
      courses = value.data['data'];
      debugPrint("search courses ${courses}");
      emit(SearchCoursesSuccessState());
    }).catchError((onError) {
      emit(SearchCoursesErrorState(error: onError.toString()));
      debugPrint("Error ${onError.toString()}");
    });
  }

}