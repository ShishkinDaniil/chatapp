import 'package:chatapp/models/room/room_model.dart';
import 'package:chatapp/models/user/user_model.dart';
import 'package:chatapp/repositories/auth_repository/auth_repository.dart';
import 'package:chatapp/repositories/rooms_repository/rooms_repository.dart';
import 'package:chatapp/utils/assert_bloc.dart';
import 'package:chatapp/utils/extentions/event_to_state_extention.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final UserModel currentUser;
  final AuthRepository authRepository;
  final RoomsRepository roomsRepository;
  HomeScreenBloc(this.authRepository, this.currentUser, this.roomsRepository)
      : super(const HomeScreenInitial()) {
    onBlocEvent((event) => _eventToState(event));
  }

  Stream<HomeScreenState> _eventToState(HomeScreenEvent event) async* {
    if (event is HomeScreenShown) {
      yield* _mapShownToState(event);
    } else if (event is HomeScreenUpdate) {
      yield* _mapUpdateToState(event);
    } else {
      assertUnhandledEvent(event);
    }
  }

  Stream<HomeScreenState> _mapUpdateToState(HomeScreenUpdate event) async* {
    yield* _toSuccessState();
  }

  Stream<HomeScreenState> _mapShownToState(HomeScreenShown event) async* {
    yield* _toSuccessState();
  }

  Stream<HomeScreenState> _toSuccessState() async* {
    yield const HomeScreenLoadInProgress();

    final rooms = await roomsRepository.getRooms(currentUser);
    final except = rooms
        .map((e) => e.participants
            .firstWhere((element) => element.uid != currentUser.uid))
        .toList();
    except.add(currentUser);

    final users =
        await authRepository.getUsers(currentUser: currentUser, except: except);

    yield HomeScreenLoadSuccess(users, rooms);
  }
}
