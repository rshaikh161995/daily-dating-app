import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchUsers extends HomeEvent {}

class RefreshUsers extends HomeEvent {}