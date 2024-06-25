import 'dart:async';

import 'package:chatapp/models/user/user_model.dart';
import 'package:chatapp/repositories/chat_repository/chat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:chatapp/utils/assert_bloc.dart';
import 'package:chatapp/utils/extentions/event_to_state_extention.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'online_indicator_event.dart';
part 'online_indicator_state.dart';

class OnlineIndicatorBloc
    extends Bloc<OnlineIndicatorEvent, OnlineIndicatorState> {
  final ChatRepository chatRepository;
  final UserModel recvUser;

  late StreamSubscription<dynamic> _onlineSubscription;

  OnlineIndicatorBloc(this.chatRepository, this.recvUser)
      : super(const OnlineIndicatorInitial()) {
    onBlocEvent((event) => _eventToState(event));
    _onlineSubscription =
        chatRepository.getOnlineStatusSnapshot(recvUser.uid).listen(
      (event) {
        if (event.snapshot.value != null) {
          add(const OnlineIndicatorGoOnline());
        } else {
          add(const OnlineIndicatorGoOffline());
        }
      },
      onError: (e) {
        add(const OnlineIndicatorGoOffline());
      },
      onDone: () {
        add(const OnlineIndicatorGoOffline());
      },
    );
  }

  Stream<OnlineIndicatorState> _eventToState(
      OnlineIndicatorEvent event) async* {
    if (event is OnlineIndicatorGoOffline) {
      yield* _mapOfflineToState(event);
    } else if (event is OnlineIndicatorGoOnline) {
      yield* _mapOnlineToState(event);
    } else {
      assertUnhandledEvent(event);
    }
  }

  Stream<OnlineIndicatorState> _mapOfflineToState(
      OnlineIndicatorGoOffline event) async* {
    yield const OnlineIndicatorOffline();
  }

  Stream<OnlineIndicatorState> _mapOnlineToState(
      OnlineIndicatorGoOnline event) async* {
    yield const OnlineIndicatorOnline();
  }

  @override
  Future<void> close() {
    _onlineSubscription.cancel();
    return super.close();
  }
}
