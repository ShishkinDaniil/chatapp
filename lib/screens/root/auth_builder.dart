import 'package:chatapp/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBuilder extends StatelessWidget {
  final ValueWidgetBuilder isAuthorized;
  final WidgetBuilder isNotAuthorized;

  const AuthBuilder({
    super.key,
    required this.isAuthorized,
    required this.isNotAuthorized,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.mapOrNull(
            error: (value) => value,
          ) !=
          current.mapOrNull(
            error: (value) => value,
          ),
      listener: (context, state) {
        state.whenOrNull(
          error: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 2),
                content: Text(error),
              ),
            );
          },
        );
      },
      builder: (context, state) {
        return state.whenOrNull(
              authorized: (currentUser) =>
                  isAuthorized(context, currentUser, this),
            ) ??
            isNotAuthorized(context);
      },
    );
  }
}
