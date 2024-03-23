part of 'course_view_layout_cubit.dart';

@immutable
abstract class CourseViewLayoutState {}

class CourseViewLayoutInitial extends CourseViewLayoutState {}

class CourseLoading extends CourseViewLayoutState {}

class CourseLoaded extends CourseViewLayoutState {}

class CourseFailed extends CourseViewLayoutState {}

/// Review
class ReviewLoadingState extends CourseViewLayoutState {}

class ReviewSuccessState extends CourseViewLayoutState {}

class ReviewErrorState extends CourseViewLayoutState {
  final String error;
  ReviewErrorState({required this.error});
}