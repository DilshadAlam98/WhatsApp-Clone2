part of 'chat_room_bloc.dart';

@immutable
sealed class ChatRoomState {}

final class ChatRoomInitial extends ChatRoomState {}

final class ChatRoomLoading extends ChatRoomState {}

final class ChatRoomLoaded extends ChatRoomState {
  final ChatUser currentUser;
  final ChatController chatController;

  ChatRoomLoaded({required this.currentUser, required this.chatController});
}

final class ChatRoomError extends ChatRoomState {
  final String error;

  ChatRoomError({required this.error});
}
