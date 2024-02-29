
import 'package:adrenaline/models/semesters/semesters.dart';

abstract class SemestersLayoutState {}

class SemestersInitial extends SemestersLayoutState {}

class SemestersLoading extends SemestersLayoutState {}

class SemestersLoaded extends SemestersLayoutState {
  final Semesters data;

  SemestersLoaded({required this.data});
}

class SemestersFailed extends SemestersLayoutState {
  final String error;
  SemestersFailed(this.error);
}