abstract class EnrolledCourseLayoutState {}

class EnrolledCoursesInitial extends EnrolledCourseLayoutState {}

class EnrolledCoursesLoading extends EnrolledCourseLayoutState {}

class EnrolledCoursesLoaded extends EnrolledCourseLayoutState {}

class EnrolledCoursesFailed extends EnrolledCourseLayoutState {
  final String error;
  EnrolledCoursesFailed(this.error);
}