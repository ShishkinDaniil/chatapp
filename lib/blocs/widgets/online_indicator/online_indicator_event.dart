part of 'online_indicator_bloc.dart';

abstract class OnlineIndicatorEvent extends Equatable {
  const OnlineIndicatorEvent();

  @override
  bool get stringify => true;
}

final class OnlineIndicatorGoOnline extends OnlineIndicatorEvent {
  const OnlineIndicatorGoOnline();

  @override
  List<Object> get props => const [];
}

final class OnlineIndicatorGoOffline extends OnlineIndicatorEvent {
  const OnlineIndicatorGoOffline();

  @override
  List<Object> get props => const [];
}
