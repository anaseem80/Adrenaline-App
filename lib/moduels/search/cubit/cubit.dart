import 'package:adrenaline/moduels/Search/cubit/states.dart';
import 'package:adrenaline/moduels/search/cubit/states.dart';
import 'package:adrenaline/shared/compontents/imports.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitSearchState());

  static SearchCubit get(context) => BlocProvider.of(context);


}