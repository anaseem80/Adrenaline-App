part of 'modules_layout_cubit.dart';

@immutable
abstract class ModulesLayoutState {}

class ModulesLayoutInitial extends ModulesLayoutState {}

class ModulesLayoutLoading extends ModulesLayoutState {}
class ModulesLayoutLoaded extends ModulesLayoutState {}
class ModulesLayoutFailed extends ModulesLayoutState {}

