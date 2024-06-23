part of 'chat_screen_bloc.dart';

abstract class ChatScreenState extends Equatable {
  const ChatScreenState();

  @override
  bool get stringify => true;
}

final class ChatScreenInitial extends ChatScreenState {
  const ChatScreenInitial();

  @override
  List<Object> get props => const [];
}

final class ChatScreenLoadInProgress extends ChatScreenState {
  const ChatScreenLoadInProgress();

  @override
  List<Object> get props => [];
}

final class ChatScreenLoadSuccess extends ChatScreenState {
  final bool recvUserIsOnline;
  const ChatScreenLoadSuccess(
    this.recvUserIsOnline,
  );

  @override
  List<Object> get props => [
        recvUserIsOnline,
      ];
}
