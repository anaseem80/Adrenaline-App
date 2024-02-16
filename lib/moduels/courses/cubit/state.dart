abstract class CourseLayoutState {}

class CoursesInitial extends CourseLayoutState {}

class CoursesLoading extends CourseLayoutState {}

class CoursesLoaded extends CourseLayoutState {}

class CoursesFailed extends CourseLayoutState {
  final String error;
  CoursesFailed(this.error);
}