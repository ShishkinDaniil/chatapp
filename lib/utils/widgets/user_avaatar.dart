import 'package:chatapp/application/theme.dart';
import 'package:chatapp/models/user/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserAvatar extends StatelessWidget {
  final UserModel userModel;

  const UserAvatar({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: AlignmentDirectional.topEnd,
          colors: userModel.linearColors.map((e) => Color(e)).toList(),
          tileMode: TileMode.mirror,
        ),
      ),
      child: Center(
        child: Text(
          '${userModel.name[0]}${userModel.surname[0]}'.toUpperCase(),
          style: ChatTheme.homeIconProfileTextStyle,
          textScaler: TextScaler.noScaling,
        ),
      ),
    );
  }
}
