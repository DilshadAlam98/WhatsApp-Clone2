part of 'chat_room_bloc.dart';

@immutable
sealed class ChatRoomEvent {}

final class FetchChatsEvents extends ChatRoomEvent {
  final ChatUser chatUser;

  FetchChatsEvents({required this.chatUser});
}

final class SendMessageEvent extends ChatRoomEvent {
  final String message;
  final ReplyMessage replyMessage;
  final MessageType messageType;

  final ChatUser chatUser;

  SendMessageEvent({
    required this.message,
    required this.replyMessage,
    required this.messageType,
    required this.chatUser,
  });
}
