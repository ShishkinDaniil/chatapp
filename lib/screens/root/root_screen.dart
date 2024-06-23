import 'package:chatapp/blocs/auth/auth_bloc.dart';
import 'package:chatapp/screens/home/home_screen.dart';
import 'package:chatapp/screens/login/login_screen.dart';
import 'package:chatapp/screens/root/auth_builder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBuilder(
      isAuthorized: (context) => const HomeScreen(),
      isNotAuthorized: (context) => const LoginScreen(),
    );
  }
}
