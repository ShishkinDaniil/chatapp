import 'package:bloc/bloc.dart';
import 'package:chatapp/models/user/user_model.dart';
import 'package:chatapp/repositories/chat_repository/chat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chatapp/utils/assert_bloc.dart';
import 'package:chatapp/utils/extentions/event_to_state_extention.dart';

part 'chat_screen_event.dart';
part 'chat_screen_state.dart';

class ChatScreenBloc extends Bloc<ChatScreenEvent, ChatScreenState> {
  final UserModel recvUser;
  final ChatRepository chatRepository;
  ChatScreenBloc(
    this.recvUser,
    this.chatRepository,
  ) : super(const ChatScreenInitial()) {
    onBlocEvent((event) => _eventToState(event));
  }

  Stream<ChatScreenState> _eventToState(ChatScreenEvent event) async* {
    if (event is ChatScreenShown) {
      yield* _mapShownToState(event);
    } else if (event is ChatScreenUpdate) {
      yield* _mapUpdateToState(event);
    } else {
      assertUnhandledEvent(event);
    }
  }

  Stream<ChatScreenState> _mapUpdateToState(ChatScreenUpdate event) async* {
    yield* _toSuccessState();
  }

  Stream<ChatScreenState> _mapShownToState(ChatScreenShown event) async* {
    yield* _toSuccessState();
  }

  Stream<ChatScreenState> _toSuccessState() async* {
    yield const ChatScreenLoadInProgress();

    yield ChatScreenLoadSuccess(false);
  }
}
