import 'package:chatapp/application/app_icons.dart';
import 'package:chatapp/application/theme.dart';
import 'package:chatapp/blocs/screens/chat_screen/chat_screen_bloc.dart';
import 'package:chatapp/blocs/widgets/online_indicator/online_indicator_bloc.dart';
import 'package:chatapp/models/message/message_model.dart';
import 'package:chatapp/models/room/room_model.dart';
import 'package:chatapp/models/user/user_model.dart';
import 'package:chatapp/utils/widgets/divider_app_bar.dart';
import 'package:chatapp/utils/widgets/user_avaatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_list/grouped_list.dart';

class ChatScreen extends StatelessWidget {
  final ChatScreenArgs args;
  const ChatScreen({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnlineIndicatorBloc(context.read(), args.recvUser),
      child: BlocProvider(
        create: (context) => ChatScreenBloc(
          args.recvUser,
          context.read(),
          context.read(),
          args.currentUser,
          args.roomModel,
        )..add(
            const ChatScreenShown(),
          ),
        child: ChatContent(
          recvUser: args.recvUser,
          currentUser: args.currentUser,
        ),
      ),
    );
  }
}

class ChatContent extends StatefulWidget {
  final UserModel recvUser;
  final UserModel currentUser;
  const ChatContent(
      {super.key, required this.recvUser, required this.currentUser});

  @override
  State<ChatContent> createState() => _ChatContentState();
}

class _ChatContentState extends State<ChatContent> {
  final _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final recvUser = widget.recvUser;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: const EdgeInsetsDirectional.only(start: 20),
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        bottom: MyDivider(
          height: 1,
        ),
        title: Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 12, top: 12),
          child: Row(
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
                  BlocBuilder<OnlineIndicatorBloc, OnlineIndicatorState>(
                    builder: (context, state) {
                      String status;
                      if (state is OnlineIndicatorOnline) {
                        status = 'В сети';
                      } else {
                        status = 'Не в сети';
                      }
                      return Text(
                        status,
                        style: ChatTheme.onlineIndicatorTextStyle,
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<ChatScreenBloc, ChatScreenState>(
        builder: (context, state) {
          if (state is ChatScreenLoadSuccess) {
            return _buildBody(state.messages);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildBody(List<MessageModel> messages) {
    return SafeArea(
      child: Column(
        children: [
          Flexible(
            child: GroupedListView<MessageModel, DateTime>(
              reverse: true,
              order: GroupedListOrder.DESC,
              indexedItemBuilder: (context, element, index) {
                return _buildMessage(messages[index]);
              },
              groupSeparatorBuilder: (value) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(children: [
                    Flexible(
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        decoration:
                            const BoxDecoration(color: ChatTheme.dividerColor),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${value.day}.${value.month}.${value.year}',
                      style: ChatTheme.dividerMessagesTextStyle,
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        decoration:
                            const BoxDecoration(color: ChatTheme.dividerColor),
                      ),
                    ),
                  ]),
                );
              },
              elements: messages,
              groupBy: (MessageModel element) {
                final sent = element.sentTime;
                final dtu = DateTime(sent.year, sent.month, sent.day);
                return dtu;
              },
              groupComparator: (a, b) =>
                  a.year == b.year && a.month == b.month && a.day == b.day
                      ? 0
                      : (a.isBefore(b) ? 1 : -1),
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: ChatTheme.dividerColor,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const SizedBox(width: 20),
              _buildAttach(
                  SvgPicture.asset(
                    AppIcons.attach,
                    width: 24,
                    height: 24,
                    fit: BoxFit.none,
                    // ignore: deprecated_member_use
                    color: ChatTheme.attachIconsColor,
                  ),
                  () {}),
              const SizedBox(width: 8),
              Flexible(
                child: TextField(
                  controller: _messageController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    hintText: 'Сообщение',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _buildAttach(
                  const Icon(
                    Icons.send,
                    color: ChatTheme.attachIconsColor,
                    weight: 24,
                  ), () {
                final message = _messageController.text.trim();
                if (message.isNotEmpty) {
                  BlocProvider.of<ChatScreenBloc>(context)
                      .add(ChatScreenSentMessage(message));
                  _messageController.text = '';
                }
              }),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 23),
        ],
      ),
    );
  }

  Widget _buildAttach(Widget child, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
            color: ChatTheme.attachColor,
            borderRadius: BorderRadius.circular(12)),
        child: child,
      ),
    );
  }

  Widget _buildMessage(MessageModel message) {
    if (widget.currentUser.uid == message.senderId) {
      return _buildSelfMessage(message);
    } else {
      return _buildRecvMessage(message);
    }
  }

  Widget _buildSelfMessage(MessageModel message) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: const BoxDecoration(
                color: ChatTheme.selfMessageColor,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(21),
                  topStart: Radius.circular(21),
                  bottomEnd: Radius.circular(12),
                  bottomStart: Radius.circular(21),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        message.messageTxt,
                        style: ChatTheme.selfLastMessageTextStyle,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            bottom: 10,
            end: 8,
            child: Text(
              "${message.sentTime.hour}: ${message.sentTime.minute}",
              style: ChatTheme.timeSelfMessageTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecvMessage(MessageModel message) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: const BoxDecoration(
                color: ChatTheme.recvMessageColor,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(21),
                  topStart: Radius.circular(21),
                  bottomEnd: Radius.circular(21),
                  bottomStart: Radius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    message.messageTxt,
                    style: ChatTheme.recvMessageTextStyle,
                  )
                ],
              ),
            ),
          ),
          PositionedDirectional(
            bottom: 10,
            end: 8,
            child: Text(
              "${message.sentTime.hour}: ${message.sentTime.minute}",
              style: ChatTheme.timeRecvMessageTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class ChatScreenArgs {
  final UserModel recvUser;
  final UserModel currentUser;
  final RoomModel? roomModel;

  ChatScreenArgs({
    required this.recvUser,
    required this.currentUser,
    this.roomModel,
  });
}
