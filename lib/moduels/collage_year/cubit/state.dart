import 'package:adrenaline/models/collagesYears/collageYears.dart';
import 'package:adrenaline/models/universites/universites.dart';

abstract class CollageYearsLayoutState {}

class CollageYearsInitial extends CollageYearsLayoutState {}

class CollageYearsLoading extends CollageYearsLayoutState {}

class CollageYearsLoaded extends CollageYearsLayoutState {
  final CollageYears data;

  CollageYearsLoaded({required this.data});
}

class CollageYearsFailed extends CollageYearsLayoutState {
  final String error;
  CollageYearsFailed(this.error);
}