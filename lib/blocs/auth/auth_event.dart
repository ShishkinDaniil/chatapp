part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthGetProfile extends AuthEvent {
  const AuthGetProfile();

  @override
  List<Object> get props => [];
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;
  const AuthLogin(this.email, this.password);

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

final class AuthGoOnline extends AuthEvent {
  const AuthGoOnline();

  @override
  List<Object> get props => [];
}

final class AuthGoOffline extends AuthEvent {
  const AuthGoOffline();

  @override
  List<Object> get props => [];
}

final class AuthUserChanged extends AuthEvent {
  final User? user;
  const AuthUserChanged(this.user);

  @override
  List<Object?> get props => [
        user,
      ];
}

final class AuthRegistration extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String surname;

  const AuthRegistration(
    this.email,
    this.password,
    this.name,
    this.surname,
  );

  @override
  List<Object> get props => [
        email,
        password,
        name,
        surname,
      ];
}
