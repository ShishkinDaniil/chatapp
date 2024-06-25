part of 'online_indicator_bloc.dart';

abstract class OnlineIndicatorState extends Equatable {
  const OnlineIndicatorState();

  @override
  bool get stringify => true;
}

final class OnlineIndicatorInitial extends OnlineIndicatorState {
  const OnlineIndicatorInitial();

  @override
  List<Object> get props => const [];
}

final class OnlineIndicatorOnline extends OnlineIndicatorState {
  const OnlineIndicatorOnline();

  @override
  List<Object> get props => const [];
}

final class OnlineIndicatorOffline extends OnlineIndicatorState {
  const OnlineIndicatorOffline();

  @override
  List<Object> get props => const [];
}
