import 'dart:ui';

import 'package:chatapp/application/theme.dart';
import 'package:chatapp/blocs/auth/auth_bloc.dart';
import 'package:chatapp/repositories/auth_repository/auth_repository.dart';
import 'package:chatapp/repositories/chat_repository/chat_repository.dart';
import 'package:chatapp/screens/root/root_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildApp(context);
  }

  Widget _buildApp(BuildContext context) {
    return _buildRepositories(
      MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              context.read(),
            )..add(const AuthGoOnline()),
          )
        ],
        child: _AppLifeCycleWatcherForOnlineIndicator(
          child: MaterialApp(
            theme: ChatTheme.chatThemeData,
            home: const RootScreen(),
          ),
        ),
      ),
    );
  }

  Widget _buildRepositories(Widget child) {
    final firestore = FirebaseFirestore.instance;
    final firebaseAuth = FirebaseAuth.instance;

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            fireStore: firestore,
            firebaseAuth: firebaseAuth,
          ),
        ),
        RepositoryProvider<ChatRepository>(
          create: (context) => ChatRepository(
            fireStore: firestore,
            firebaseAuth: firebaseAuth,
          ),
        ),
      ],
      child: child,
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
      onShow: () {
        final bloc = context.authBloc;

        bloc.state.whenOrNull(
          authorized: () {
            if (!bloc.isOnline) {
              bloc.add(const AuthGoOnline());
            }
          },
        );
      },
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
    final bloc = context.authBloc;

    bloc.state.whenOrNull(
      authorized: () {
        switch (state) {
          case AppLifecycleState.paused:
            if (bloc.isOnline) {
              bloc.add(const AuthGoOffline());
            }
          case AppLifecycleState.resumed:
            if (!bloc.isOnline) {
              bloc.add(const AuthGoOnline());
            }
          case AppLifecycleState.detached:
            if (bloc.isOnline) {
              bloc.add(const AuthGoOffline());
            }
          case AppLifecycleState.inactive:
            if (bloc.isOnline) {
              bloc.add(const AuthGoOffline());
            }
          case AppLifecycleState.hidden:
            if (bloc.isOnline) {
              bloc.add(const AuthGoOffline());
            }
        }
      },
    );
  }
}
