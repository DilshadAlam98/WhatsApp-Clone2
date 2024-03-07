import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_application/screens/chat/chat_room/models/message_response.dart';
import 'package:chatview/chatview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

part 'chat_room_event.dart';
part 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final stores = FirebaseFirestore.instance;

  ChatRoomBloc() : super(ChatRoomInitial()) {
    on<FetchChatsEvents>(_onChatRoomEvent);
    on<SendMessageEvent>(_onSendMessageEvent);
  }

  FutureOr<void> _onSendMessageEvent(SendMessageEvent event, Emitter emit) async {
    try {
      final ids = [uid, event.chatUser.id];
      ids.sort();
      final roomId = ids.join("_");
      final messageReq = MessageResponse(
        messageType: event.messageType.name,
        message: event.message,
        replyMessage: ReplyMessageRes(
          message: event.replyMessage.message,
          messageType: event.messageType.name,
          replyTo: event.chatUser.id,
          replyBy: uid,
          messageId: DateTime.now().toString(),
        ),
        id: DateTime.now().toString(),
        createdAt: DateTime.now().toString(),
        sendBy: uid,
      );
      await stores.collection("chat_room").doc(roomId).collection('chat').doc().set(messageReq.toJson());
    } on FirebaseException catch (e) {
      print("Error: ${e.message}");
    }
  }

  Future<FutureOr<void>> _onChatRoomEvent(FetchChatsEvents event, Emitter emit) async {
    try {
      emit(ChatRoomLoading());

      final user = await stores.collection("users").doc(uid).get();

      /// fetching message;
      List<Message> initialMessages = [];
      final ids = [uid, event.chatUser.id];
      ids.sort();
      final roomId = ids.join("_");
      print(roomId);
      stores
          .collection("chat_room")
          .doc(roomId)
          .collection("chat")
          // .orderBy("timestamp", descending: true)
          .snapshots()
          .listen((event) {
        for (var v in event.docs) {
          final messageRes = MessageResponse.fromJson(v.data());
          final createdAt = DateTime.parse(messageRes.createdAt!);
          final message = Message(
            message: messageRes.message!,
            createdAt: createdAt,
            sendBy: messageRes.sendBy!,
          );
          initialMessages.add(message);
        }
      });
      final currentUser = ChatUser(
        id: user.data()?['uuid'],
        name: "${user.data()?['first_name']} ${user.data()?['last_name']}",
      );
      final chatController = ChatController(
        initialMessageList: initialMessages,
        scrollController: ScrollController(),
        chatUsers: [event.chatUser],
      );
      emit(ChatRoomLoaded(currentUser: currentUser, chatController: chatController));
    } on FirebaseException catch (e) {
      emit(ChatRoomError(error: e.message ?? ""));
    }
  }
}
