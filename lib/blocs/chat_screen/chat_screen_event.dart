part of 'chat_screen_bloc.dart';

abstract class ChatScreenEvent extends Equatable {
  const ChatScreenEvent();

  @override
  bool get stringify => true;
}

final class ChatScreenShown extends ChatScreenEvent {
  const ChatScreenShown();

  @override
  List<Object> get props => const [];
}

final class ChatScreenUpdate extends ChatScreenEvent {
  const ChatScreenUpdate();

  @override
  List<Object> get props => const [];
}
