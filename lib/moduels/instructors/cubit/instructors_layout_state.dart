part of 'instructors_layout_cubit.dart';

@immutable
abstract class InstructorsLayoutState {}

class InstructorsLayoutInitial extends InstructorsLayoutState {}

class InstructorsLayoutLoading extends InstructorsLayoutState {}
class InstructorsLayoutLoaded extends InstructorsLayoutState {}
class InstructorsLayoutFailed extends InstructorsLayoutState {}

