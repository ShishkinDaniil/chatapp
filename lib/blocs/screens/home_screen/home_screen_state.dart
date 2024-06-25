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
  final List<RoomModel> rooms;
  const HomeScreenLoadSuccess(this.users, this.rooms);

  @override
  List<Object> get props => [users, rooms];
}
