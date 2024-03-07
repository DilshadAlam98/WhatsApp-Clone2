import 'package:chat_application/firebase_options.dart';
import 'package:chat_application/screens/authentication/bloc/login_bloc.dart';
import 'package:chat_application/screens/authentication/ui/login.dart';
import 'package:chat_application/screens/chat/chat_listing/bloc/chat_listing_bloc.dart';
import 'package:chat_application/screens/chat/chat_room/bloc/chat_room_bloc.dart';
import 'package:chat_application/screens/home/home.dart';
import 'package:chat_application/screens/home/recent/bloc/recent_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    checkLoggedIn();
  }

  void checkLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => RecentBloc()),
        BlocProvider(create: (_) => ChatRoomBloc()),
        BlocProvider(create: (_) => ChatListingBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        home: isLoggedIn ? const HomeScreen() : LoginScreen(),
      ),
    );
  }
}
