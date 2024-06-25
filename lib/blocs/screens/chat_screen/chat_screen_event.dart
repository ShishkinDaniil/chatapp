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

final class ChatScreenChanged extends ChatScreenEvent {
  const ChatScreenChanged();

  @override
  List<Object> get props => const [];
}

final class ChatScreenSentMessage extends ChatScreenEvent {
  final String message;
  const ChatScreenSentMessage(this.message);

  @override
  List<Object> get props => [message];
}
