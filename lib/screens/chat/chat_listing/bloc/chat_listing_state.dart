part of 'chat_listing_bloc.dart';

@immutable
sealed class ChatListingState {}

final class ChatListingInitial extends ChatListingState {}

final class ChatListingLoading extends ChatListingState {}

final class ChatListingLoaded extends ChatListingState {
  final List<AllUsers> users;

  ChatListingLoaded({required this.users});
}

final class ChatListingError extends ChatListingState {
  final String error;

  ChatListingError({required this.error});
}

final class RouteToRoomState extends ChatListingState {
  final ChatUser chatUser;

  RouteToRoomState({required this.chatUser});
}
