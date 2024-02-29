import 'package:adrenaline/models/universites/universites.dart';

abstract class UniversitesLayoutState {}

class UniversitesInitial extends UniversitesLayoutState {}

class UniversitesLoading extends UniversitesLayoutState {}

class UniversitesLoaded extends UniversitesLayoutState {
  final Universites data;

  UniversitesLoaded({required this.data});
}

class UniversitesFailed extends UniversitesLayoutState {
  final String error;
  UniversitesFailed(this.error);
}