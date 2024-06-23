part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  factory AuthState.notAuthorized() = _AuthStateNotAuthorized;

  factory AuthState.authorized() = _AuthStateAuthorized;

  factory AuthState.waiting() = _AuthStateWaiting;

  factory AuthState.error(dynamic error) = _AuthStateError;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}

// sealed class AuthState extends Equatable {
//   const AuthState();

//   @override
//   List<Object> get props => [];
// }

// final class AuthInitial extends AuthState {
//   const AuthInitial();

//   @override
//   List<Object> get props => [];
// }

// final class AuthError extends AuthState {
//   const AuthError();

//   @override
//   List<Object> get props => [];
// }

// final class AuthAuthorizedSuccess extends AuthState {
//   const AuthAuthorizedSuccess();

//   @override
//   List<Object> get props => [];
// }

// final class AuthNotAuthorized extends AuthState {
//   const AuthNotAuthorized();

//   @override
//   List<Object> get props => [];
// }
