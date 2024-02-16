
import 'package:arabmedicine/models/user/user_model.dart';

abstract class AppState {}

class AppInitial extends AppState {}

class AppChangeModeState extends AppState {}

class AppGetActiveUserState extends AppState {}

class AppGetActiveUserLoadingState extends AppState {}

class AppGetActiveUserFailedState extends AppState {}

class AppDeleteUserLoading extends AppState {}

class AppDeleteUserSuccess extends AppState {}

class AppDeleteUserFailed extends AppState {}