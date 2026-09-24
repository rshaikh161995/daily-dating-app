import 'package:equatable/equatable.dart';

import '../../../data/models/user_model.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  failure,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final List<UserModel> users;
  final String errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.users = const [],
    this.errorMessage = '',
  });

  HomeState copyWith({
    HomeStatus? status,
    List<UserModel>? users,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      users: users ?? this.users,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    users,
    errorMessage,
  ];
}