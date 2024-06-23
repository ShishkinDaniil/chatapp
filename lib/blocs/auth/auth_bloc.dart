import 'dart:async';
import 'dart:convert' as convert;

import 'package:bloc/bloc.dart';
import 'package:chatapp/repositories/auth_repository/auth_repository.dart';
import 'package:chatapp/utils/assert_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:chatapp/utils/extentions/event_to_state_extention.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_event.dart';
part 'auth_state.dart';

part 'auth_bloc.freezed.dart';
part 'auth_bloc.g.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  late StreamSubscription<dynamic> _streamSubscription;
  final AuthRepository authRepository;
  bool isOnline = false;
  AuthBloc(this.authRepository) : super(AuthState.notAuthorized()) {
    onBlocEvent((event) => _eventToState(event));
    _streamSubscription = authRepository.streamAuthState.listen(
      (event) {
        add(AuthUserChanged(event));
      },
      onError: (e) {
        add(const AuthUserChanged(null));
      },
    );
  }

  Stream<AuthState> _eventToState(AuthEvent event) async* {
    if (event is AuthLogin) {
      yield* _mapLoginToState(event);
    } else if (event is AuthRegistration) {
      yield* _mapRegToState(event);
    } else if (event is AuthGoOnline) {
      yield* _mapGoOnlineToState(event);
    } else if (event is AuthGoOffline) {
      yield* _mapGoOfflineToState(event);
    } else if (event is AuthUserChanged) {
      yield* _mapChangeToState(event);
    } else {
      assertUnhandledEvent(event);
    }
  }

  Stream<AuthState> _mapGoOnlineToState(AuthGoOnline event) async* {
    await authRepository.chageOnlineStatus(true);
    isOnline = true;
  }

  Stream<AuthState> _mapGoOfflineToState(AuthGoOffline event) async* {
    await authRepository.chageOnlineStatus(false);
    isOnline = false;
  }

  Stream<AuthState> _mapChangeToState(AuthUserChanged event) async* {
    if (state is _AuthStateNotAuthorized) {
      yield AuthState.waiting();
    }
    if (event.user == null) {
      yield _AuthStateNotAuthorized();
    } else {
      yield _AuthStateAuthorized();
    }
  }

  Stream<AuthState> _mapLoginToState(AuthLogin event) async* {
    try {
      final user = await authRepository.signInWithEmailAndPassword(
        event.email,
        event.password,
      );

      yield _AuthStateAuthorized();
    } catch (e) {
      yield _AuthStateError(e);
    }
  }

  Stream<AuthState> _mapRegToState(AuthRegistration event) async* {
    try {
      final user = authRepository.signUpWithEmailAndPassword(
        event.email,
        event.password,
        event.surname,
        event.name,
      );
      yield _AuthStateAuthorized();
    } catch (e) {
      yield _AuthStateError(e);
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    final state = AuthState.fromJson(json);
    return state.whenOrNull(authorized: () => AuthState.authorized());
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state
            .whenOrNull(authorized: () => AuthState.authorized())
            ?.toJson() ??
        AuthState.notAuthorized().toJson();
  }
}

extension HomeBlocExtension on BuildContext {
  AuthBloc get authBloc {
    try {
      return BlocProvider.of(this);
    } catch (e) {
      rethrow;
    }
  }
}
