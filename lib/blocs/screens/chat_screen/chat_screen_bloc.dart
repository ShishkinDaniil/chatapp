import 'dart:async';

import 'package:chatapp/models/message/message_model.dart';
import 'package:chatapp/models/room/room_model.dart';
import 'package:chatapp/models/user/user_model.dart';
import 'package:chatapp/repositories/chat_repository/chat_repository.dart';
import 'package:chatapp/repositories/rooms_repository/rooms_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/utils/assert_bloc.dart';
import 'package:chatapp/utils/extentions/event_to_state_extention.dart';

part 'chat_screen_event.dart';
part 'chat_screen_state.dart';

class ChatScreenBloc extends Bloc<ChatScreenEvent, ChatScreenState> {
  final UserModel recvUser;
  final ChatRepository chatRepository;
  final RoomsRepository roomsRepository;
  final UserModel currentUser;
  final RoomModel? room;
  late RoomModel? _currentRoom;
  List<MessageModel> _messages = [];
  StreamSubscription<dynamic>? _streamSubscription;

  ChatScreenBloc(
    this.recvUser,
    this.chatRepository,
    this.roomsRepository,
    this.currentUser,
    this.room,
  ) : super(const ChatScreenInitial()) {
    onBlocEvent((event) => _eventToState(event));
    _currentRoom = room;
  }
  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  Stream<ChatScreenState> _eventToState(ChatScreenEvent event) async* {
    if (event is ChatScreenShown) {
      yield* _mapShownToState(event);
    } else if (event is ChatScreenChanged) {
      yield* _mapUpdateToState(event);
    } else if (event is ChatScreenSentMessage) {
      yield* _mapSentToState(event);
    } else {
      assertUnhandledEvent(event);
    }
  }

  Stream<ChatScreenState> _mapSentToState(ChatScreenSentMessage event) async* {
    _currentRoom = await chatRepository.sentMessage(
      event.message,
      currentUser,
      recvUser,
      roomModel: _currentRoom,
    );
    if (_streamSubscription == null) {
      final snapshot = await chatRepository.getMessagesSnapshot(_currentRoom!);
      _streamSubscription = snapshot.listen((event) {
        _messages =
            event.docs.map((e) => MessageModel.fromJson(e.data())).toList();
        _messages.sort((a, b) => a.sentTime.isBefore(b.sentTime) ? 1 : -1);
        if (state is ChatScreenLoadSuccess) {
          add(const ChatScreenChanged());
        }
      });
    }

    yield* _toSuccessState();
  }

  Stream<ChatScreenState> _mapUpdateToState(ChatScreenChanged event) async* {
    yield* _toSuccessState();
  }

  Stream<ChatScreenState> _mapShownToState(ChatScreenShown event) async* {
    if (_currentRoom != null) {
      _messages = await chatRepository.getMessages(_currentRoom!);
      final snapshot = await chatRepository.getMessagesSnapshot(_currentRoom!);
      _streamSubscription = snapshot.listen((event) {
        _messages =
            event.docs.map((e) => MessageModel.fromJson(e.data())).toList();
        _messages.sort((a, b) => a.sentTime.isBefore(b.sentTime) ? 1 : -1);

        if (state is ChatScreenLoadSuccess) {
          add(const ChatScreenChanged());
        }
      });
    }

    yield* _toSuccessState();
  }

  Stream<ChatScreenState> _toSuccessState() async* {
    yield const ChatScreenLoadInProgress();

    yield ChatScreenLoadSuccess(_messages);
  }
}
