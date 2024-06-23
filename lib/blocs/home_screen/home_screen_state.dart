part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  bool get stringify => true;
}

final class HomeScreenInitial extends HomeScreenState {
  const HomeScreenInitial();

  @override
  List<Object> get props => const [];
}

final class HomeScreenLoadInProgress extends HomeScreenState {
  const HomeScreenLoadInProgress();

  @override
  List<Object> get props => [];
}

final class HomeScreenLoadSuccess extends HomeScreenState {
  final List<UserModel> users;
  const HomeScreenLoadSuccess(this.users);

  @override
  List<Object> get props => [users];
}
