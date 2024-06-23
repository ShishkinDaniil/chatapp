import 'package:bloc/bloc.dart';
import 'package:chatapp/models/user/user_dto.dart';
import 'package:chatapp/models/user/user_model.dart';
import 'package:chatapp/repositories/auth_repository/auth_repository.dart';
import 'package:chatapp/utils/assert_bloc.dart';
import 'package:chatapp/utils/extentions/event_to_state_extention.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final AuthRepository authRepository;
  HomeScreenBloc(this.authRepository) : super(const HomeScreenInitial()) {
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

    final users = await authRepository.getUsers();

    yield HomeScreenLoadSuccess(users);
  }
}
