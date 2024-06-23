part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  bool get stringify => true;
}

final class HomeScreenShown extends HomeScreenEvent {
  const HomeScreenShown();

  @override
  List<Object> get props => const [];
}

final class HomeScreenUpdate extends HomeScreenEvent {
  const HomeScreenUpdate();

  @override
  List<Object> get props => const [];
}
