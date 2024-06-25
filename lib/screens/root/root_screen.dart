import 'package:chatapp/screens/home/home_screen.dart';
import 'package:chatapp/screens/login/login_screen.dart';
import 'package:chatapp/screens/root/auth_builder.dart';
import 'package:flutter/widgets.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBuilder(
      isAuthorized: (context, currentUser, w) =>
          HomeScreen(args: HomeScreenArgs(currentUser: currentUser)),
      isNotAuthorized: (context) => const LoginScreen(),
    );
  }
}
