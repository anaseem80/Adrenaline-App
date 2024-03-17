
abstract class CoursesSemesterLayoutState {}

class CoursesSemesterInitial extends CoursesSemesterLayoutState {}

class CoursesSemesterLoading extends CoursesSemesterLayoutState {}

class CoursesSemesterLoaded extends CoursesSemesterLayoutState {}

class CoursesSemesterFailed extends CoursesSemesterLayoutState {
  final String error;
  CoursesSemesterFailed(this.error);
}