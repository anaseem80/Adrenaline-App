part of 'register_layout_cubit.dart';

@immutable
abstract class RegisterLayoutState {}

class RegisterLayoutInitial extends RegisterLayoutState {}

class RegisterLoading extends RegisterLayoutState {}

class RegisterLoaded extends RegisterLayoutState {
  final RegisterModel registerModelData;
  RegisterLoaded(this.registerModelData);
}

class RegisterFailed extends RegisterLayoutState {}