part of 'chat_listing_bloc.dart';

@immutable
sealed class ChatListingEvent {}

final class ChatListingFetchEvent extends ChatListingEvent {}

final class RouteToRoomEvent extends ChatListingEvent {
  final ChatUser user;

  RouteToRoomEvent({required this.user});
}
