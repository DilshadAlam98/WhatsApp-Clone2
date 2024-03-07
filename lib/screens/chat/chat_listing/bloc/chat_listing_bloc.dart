import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_application/screens/chat/chat_listing/models/all_users.dart';
import 'package:chatview/chatview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'chat_listing_event.dart';
part 'chat_listing_state.dart';

class ChatListingBloc extends Bloc<ChatListingEvent, ChatListingState> {
  ChatListingBloc() : super(ChatListingInitial()) {
    on<ChatListingFetchEvent>(_onFetchChatUsers);

    on<RouteToRoomEvent>(_onRouteToRoom);
  }

  FutureOr<void> _onRouteToRoom(RouteToRoomEvent event, Emitter emit) {
    emit(RouteToRoomState(chatUser: event.user));
  }

  Future<FutureOr<void>> _onFetchChatUsers(ChatListingFetchEvent event, Emitter emit) async {
    try {
      emit(ChatListingLoading());
      final firestore = FirebaseFirestore.instance;
      List<AllUsers> users = [];
      final res =
          await firestore.collection("users").where("uuid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
      for (var v in res.docs) {
        users.add(AllUsers.fromJson(v.data()));
      }
      emit(ChatListingLoaded(users: users));
    } on FirebaseException catch (e) {
      emit(ChatListingError(error: e.message ?? ""));
    }
  }
}
