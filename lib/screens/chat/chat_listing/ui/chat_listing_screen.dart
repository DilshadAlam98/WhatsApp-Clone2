import 'package:chat_application/constant/global.dart';
import 'package:chat_application/screens/chat/chat_listing/bloc/chat_listing_bloc.dart';
import 'package:chat_application/screens/chat/chat_listing/models/all_users.dart';
import 'package:chat_application/screens/chat/chat_room/chat_room_screen.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListingScreen extends StatefulWidget {
  const ChatListingScreen({super.key});

  @override
  State<ChatListingScreen> createState() => _ChatListingScreenState();
}

class _ChatListingScreenState extends State<ChatListingScreen> {
  @override
  void initState() {
    context.read<ChatListingBloc>().add(ChatListingFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "WhatsApp",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: BlocConsumer<ChatListingBloc, ChatListingState>(
        listener: (context, state) {
          if (state is RouteToRoomState) {
            push(context, screen: ChatRoomScreen(chatUser: state.chatUser));
          }
        },
        buildWhen: (previous, current) {
          return current.runtimeType != RouteToRoomState;
        },
        builder: (context, state) {
          if (state is ChatListingLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ChatListingError) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is ChatListingLoaded) {
            if (state.users.isEmpty) {
              return const Center(
                child: Text("No user Exist!!"),
              );
            }
            return ListView.separated(
              itemCount: state.users.length,
              padding: const EdgeInsets.symmetric(vertical: 15),
              itemBuilder: (context, index) {
                final user = state.users[index];
                return _ChatUserTile(user: user);
              },
              separatorBuilder: (context, index) => const Divider(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _ChatUserTile extends StatelessWidget {
  const _ChatUserTile({required this.user});

  final AllUsers user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        final chatUser = ChatUser(id: user.uuid!, name: "${user.firstName ?? ""} ${user.lastName ?? ""}");
        context.read<ChatListingBloc>().add(RouteToRoomEvent(user: chatUser));
      },
      dense: true,
      leading: const CircleAvatar(radius: 38),
      title: Text(
        "${user.firstName} ${user.lastName}",
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        user.about ?? "",
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
