abstract class SearchStates{}
class InitSearchState extends SearchStates {}


/// Search
class SearchCoursesLoadingState extends SearchStates {}
class SearchCoursesSuccessState extends SearchStates {}
class SearchCoursesErrorState extends SearchStates {
  final String error;
  SearchCoursesErrorState({required this.error});
}