part of 'player_layout_cubit.dart';

@immutable
abstract class PlayerLayoutState {}

class PlayerLayoutInitial extends PlayerLayoutState {}

class PlayerLayoutLoading extends PlayerLayoutState {}
class PlayerLayoutLoaded extends PlayerLayoutState {}
class PlayerLayoutFailed extends PlayerLayoutState {}

