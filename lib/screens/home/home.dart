import 'package:chat_application/constant/global.dart';
import 'package:chat_application/screens/chat/chat_listing/ui/chat_listing_screen.dart';
import 'package:chat_application/screens/chat/chat_room/chat_room_screen.dart';
import 'package:chat_application/screens/home/bloc/home_bloc.dart';
import 'package:chat_application/screens/home/model/tab_entity.dart';
import 'package:chat_application/screens/home/recent/ui/recent_chat.dart';
import 'package:chat_application/screens/home/story/ui/story_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late HomeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = HomeBloc();
    _controller =
        TabController(length: TabEntity.getTabs().length, vsync: this);
    _controller.addListener(() {
      _bloc.tabIndex.value = _controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ValueListenableBuilder(
        valueListenable: _bloc.tabIndex,
        builder: (context, value, child) {
          if (value == 1) {
            return FloatingActionButton(
              backgroundColor: Colors.teal,
              child: const Icon(Icons.edit),
              onPressed: () {
                print("Status Tab");
              },
            );
          }
          return FloatingActionButton(
            backgroundColor: Colors.teal,
            child: const Icon(Icons.message),
            onPressed: () => push(context, screen: const ChatListingScreen()),
          );
        },
      ),
      appBar: AppBar(
        bottom: TabBar(
          controller: _controller,
          tabs: TabEntity.getTabs()
              .map((e) => Tab(
                    child: Text(
                      e.lable,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ))
              .toList(),
        ),
        backgroundColor: Colors.teal,
        title: const Text(
          "WhatsApp",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          RecentChat(),
          StoryScreen(),
        ],
      ),
    );
  }
}
