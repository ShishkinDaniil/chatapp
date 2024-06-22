import 'dart:ui';

import 'package:chatapp/application/routes.dart';
import 'package:chatapp/application/theme.dart';
import 'package:chatapp/blocs/auth/auth_bloc.dart';
import 'package:chatapp/repositories/auth_repository/auth_repository.dart';
import 'package:chatapp/screens/login/auth_redirect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildApp(context);
  }

  Widget _buildApp(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              context.read(),
            ),
          )
        ],
        child: _AppLifeCycleWatcherForOnlineIndicator(
          child: MaterialApp(
            theme: ChatTheme.chatThemeData,
            builder: (context, child) => const AuthRedirect(),
          ),
        ),
      ),
    );
  }
}

class _AppLifeCycleWatcherForOnlineIndicator extends StatefulWidget {
  final Widget child;

  const _AppLifeCycleWatcherForOnlineIndicator({required this.child});

  @override
  State<_AppLifeCycleWatcherForOnlineIndicator> createState() =>
      _AppLifeCycleWatcherForOnlineIndicatorState();
}

class _AppLifeCycleWatcherForOnlineIndicatorState
    extends State<_AppLifeCycleWatcherForOnlineIndicator> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();

    _listener = AppLifecycleListener(
      onStateChange: _onStateChanged,
      onExitRequested: () async {
        print('exited');
        return AppExitResponse.exit;
      },
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _onStateChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        print('paused');
      case AppLifecycleState.resumed:
        print('resumed');
      case AppLifecycleState.detached:
        print('detached');
      case AppLifecycleState.inactive:
        print('inactive');
      case AppLifecycleState.hidden:
        print('hidden');
    }
  }
}
