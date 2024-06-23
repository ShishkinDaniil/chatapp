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
          colors: <Color>[
            Color(userModel.linearColors.first),
            Color(userModel.linearColors.last),
          ],
          tileMode: TileMode.mirror,
        ),
      ),
      child: Center(
        child: Text(
          '${userModel.name[1]}${userModel.surname[1]}'.toUpperCase(),
          style: ChatTheme.homeIconProfileTextStyle,
          textScaler: TextScaler.noScaling,
        ),
      ),
    );
  }
}
