part of 'courses_of_instructor_layout_cubit.dart';

@immutable
abstract class CoursesOfInstructorLayoutState {}

class CoursesOfInstructorLayoutInitial extends CoursesOfInstructorLayoutState {}

class CoursesOfInstructorLayoutLoading extends CoursesOfInstructorLayoutState {}
class CoursesOfInstructorLayoutLoaded extends CoursesOfInstructorLayoutState {}
class CoursesOfInstructorLayoutFailed extends CoursesOfInstructorLayoutState {}

