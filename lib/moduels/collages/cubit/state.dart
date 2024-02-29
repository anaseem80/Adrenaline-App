import 'package:adrenaline/models/collages/collages.dart';

abstract class CollagesLayoutState {}

class CollagesInitial extends CollagesLayoutState {}

class CollagesLoading extends CollagesLayoutState {}

class CollagesLoaded extends CollagesLayoutState {
  final Collages data;

  CollagesLoaded({required this.data});
}

class CollagesFailed extends CollagesLayoutState {
  final String error;
  CollagesFailed(this.error);
}