import 'package:chatapp/models/room/room_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chatapp/application/theme.dart';
import 'package:chatapp/blocs/screens/home_screen/home_screen_bloc.dart';
import 'package:chatapp/models/user/user_model.dart';
import 'package:chatapp/screens/chat/chat_screen.dart';
import 'package:chatapp/utils/widgets/user_avaatar.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenArgs args;
  const HomeScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenBloc(
        context.read(),
        args.currentUser,
        context.read(),
      )..add(
          const HomeScreenShown(),
        ),
      child: HomeContent(
        currentUser: args.currentUser,
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  final UserModel currentUser;
  const HomeContent({
    super.key,
    required this.currentUser,
  });

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          if (state is HomeScreenLoadSuccess) {
            return _buildBody(state);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildBody(HomeScreenLoadSuccess state) {
    final users = state.users;
    final rooms = state.rooms;
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        BlocProvider.of<HomeScreenBloc>(context, listen: false)
            .add(const HomeScreenUpdate());
      },
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            floating: false,
            expandedHeight: 125.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.fadeTitle],
              expandedTitleScale: 1,
              titlePadding: EdgeInsetsDirectional.only(
                  top: MediaQuery.of(context).padding.top),
              title: const Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 20),
                      child: Text(
                        'Чаты',
                        style: ChatTheme.homePageTitleTextSyle,
                        textScaler: TextScaler.noScaling,
                      ),
                    ),
                    Spacer(),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: ChatTheme.dividerColor,
                    ),
                  ],
                ),
              ),
              background: Container(
                color: Colors.white,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 20,
                      end: 20,
                      bottom: 24,
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Поиск',
                        prefixIcon: Icon(
                          Icons.search,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _buildRoomItem(rooms[index]);
              },
              childCount: rooms.length,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _buildUserItem(users[index]);
              },
              childCount: users.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomItem(RoomModel roomModel) {
    final currentUser = widget.currentUser;
    final recvUser = roomModel.participants.firstWhere(
      (element) => element.uid != currentUser.uid,
    );
    final name = recvUser.name;
    final surname = recvUser.surname;
    final lastMessage = roomModel.lastMessage;
    final lastDate = lastMessage.sentTime;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              args: ChatScreenArgs(
                recvUser: recvUser,
                currentUser: widget.currentUser,
                roomModel: roomModel,
              ),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
        child: Stack(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    UserAvatar(
                      userModel: recvUser,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$name $surname',
                          style: ChatTheme.nameSurnameTextStyle,
                        ),
                        Row(
                          children: [
                            if (lastMessage.senderId == currentUser.uid)
                              const Text(
                                'Вы: ',
                                style: ChatTheme.selfLastMessageTextStyle,
                              ),
                            Text(
                              lastMessage.messageTxt,
                              style: ChatTheme.lastMessageTextStyle,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: ChatTheme.dividerColor,
              ),
            ],
          ),
          PositionedDirectional(
            end: 12,
            top: 10,
            child: Text(
              '${lastDate.day}.${lastDate.month}.${lastDate.year}',
              style: ChatTheme.lastMessageDateTextStyle,
            ),
          )
        ]),
      ),
    );
  }

  Widget _buildUserItem(UserModel userModel) {
    final name = userModel.name;
    final surname = userModel.surname;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              args: ChatScreenArgs(
                recvUser: userModel,
                currentUser: widget.currentUser,
              ),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  UserAvatar(
                    userModel: userModel,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '$name $surname',
                    style: ChatTheme.nameSurnameTextStyle,
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: ChatTheme.dividerColor,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreenArgs {
  final UserModel currentUser;

  HomeScreenArgs({
    required this.currentUser,
  });
}
