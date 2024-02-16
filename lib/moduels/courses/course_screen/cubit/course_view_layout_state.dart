part of 'course_view_layout_cubit.dart';

@immutable
abstract class CourseViewLayoutState {}

class CourseViewLayoutInitial extends CourseViewLayoutState {}

class CourseLoading extends CourseViewLayoutState {}

class CourseLoaded extends CourseViewLayoutState {}

class CourseFailed extends CourseViewLayoutState {}