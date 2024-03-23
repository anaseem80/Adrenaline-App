abstract class CourseLayoutState {}

class CoursesInitial extends CourseLayoutState {}

class CoursesLoading extends CourseLayoutState {}

class CoursesLoaded extends CourseLayoutState {}

class CoursesFailed extends CourseLayoutState {
  final String error;
  CoursesFailed(this.error);
}
//High school
class GetHighSchoolLoadingEvent extends CourseLayoutState {}

class GetHighSchoolLoadedEvent extends CourseLayoutState {}

class GetHighSchoolErrorEvent extends CourseLayoutState {}

//public
class GetPublicLoadingEvent extends CourseLayoutState {}

class GetPublicLoadedEvent extends CourseLayoutState {}

class GetPublicErrorEvent extends CourseLayoutState {}

//public medicine
class GetPublicMedicineLoadingEvent extends CourseLayoutState {}

class GetPublicMedicineLoadedEvent extends CourseLayoutState {}

class GetPublicMedicineErrorEvent extends CourseLayoutState {}
