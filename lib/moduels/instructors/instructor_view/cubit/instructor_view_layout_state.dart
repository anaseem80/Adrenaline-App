part of 'instructor_view_layout_cubit.dart';

@immutable
abstract class InstructorViewLayoutState {}

class InstructorViewLayoutInitial extends InstructorViewLayoutState {}

class InstructorViewLayoutLoading extends InstructorViewLayoutState {}
class InstructorViewLayoutLoaded extends InstructorViewLayoutState {}
class InstructorViewLayoutFailed extends InstructorViewLayoutState {}