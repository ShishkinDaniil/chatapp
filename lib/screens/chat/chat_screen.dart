import 'package:chatapp/application/theme.dart';
import 'package:chatapp/blocs/chat_screen/chat_screen_bloc.dart';
import 'package:chatapp/models/user/user_model.dart';
import 'package:chatapp/utils/widgets/user_avaatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  final ChatScreenArgs args;
  const ChatScreen({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatScreenBloc(args.recvUser, context.read()),
      child: ChatContent(
        recvUser: args.recvUser,
      ),
    );
  }
}

class ChatContent extends StatefulWidget {
  final UserModel recvUser;
  const ChatContent({super.key, required this.recvUser});

  @override
  State<ChatContent> createState() => _ChatContentState();
}

class _ChatContentState extends State<ChatContent> {
  @override
  Widget build(BuildContext context) {
    final recvUser = widget.recvUser;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UserAvatar(userModel: recvUser),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${recvUser.name} ${recvUser.surname}',
                  style: ChatTheme.nameSurnameTextStyle,
                ),
                BlocBuilder<ChatScreenBloc, ChatScreenState>(
                    builder: (context, state) {
                  if (state is ChatScreenLoadSuccess) {
                    return Text(
                        state.recvUserIsOnline ? 'В сети' : 'Не в сети');
                  } else {
                    return Container();
                  }
                })
              ],
            ),
          ],
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container();
  }
}

class ChatScreenArgs {
  final UserModel recvUser;

  ChatScreenArgs({required this.recvUser});
}
