import 'package:adrenaline/layout/cubit/home_layout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutInitial());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  void clickedItem(i){
    currentIndex = i;
    emit(changeClickedState());
  }
}
