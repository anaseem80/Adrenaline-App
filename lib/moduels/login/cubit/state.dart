import 'package:arabmedicine/models/login_model/login_model.dart';

abstract class LoginLayoutState {}

class LoginInitial extends LoginLayoutState {}

class LoginLoading extends LoginLayoutState {}

class LoginLoaded extends LoginLayoutState {
  final LoginModel loginModelData;
  LoginLoaded(this.loginModelData);
}

class LoginFailed extends LoginLayoutState {
  final String error;
  LoginFailed(this.error);
}