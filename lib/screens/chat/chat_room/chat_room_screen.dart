import 'package:chat_application/screens/chat/chat_room/bloc/chat_room_bloc.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key, required this.chatUser});

  final ChatUser chatUser;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  void initState() {
    context.read<ChatRoomBloc>().add(FetchChatsEvents(chatUser: widget.chatUser));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatRoomBloc, ChatRoomState>(
        listener: (context, state) => true,
        builder: (context, state) {
          if (state is ChatRoomLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ChatRoomError) {
            return Center(child: Text(state.error));
          }
          if (state is ChatRoomLoaded) {
            return ChatView(
              currentUser: state.currentUser,
              chatController: state.chatController,
              onSendTap: (message, replyMessage, messageType) {
                context.read<ChatRoomBloc>().add(SendMessageEvent(
                      message: message,
                      replyMessage: replyMessage,
                      messageType: messageType,
                      chatUser: widget.chatUser,
                    ));
              },
              featureActiveConfig: const FeatureActiveConfig(
                lastSeenAgoBuilderVisibility: true,
                receiptsBuilderVisibility: true,
              ),
              chatViewState: ChatViewState.hasMessages,
              chatViewStateConfig: ChatViewStateConfiguration(
                loadingWidgetConfig: const ChatViewStateWidgetConfiguration(
                    // loadingIndicatorColor: theme.outgoingChatBubbleColor,
                    ),
                onReloadButtonTap: () {},
              ),
              typeIndicatorConfig: const TypeIndicatorConfiguration(
                  // flashingCircleBrightColor: theme.flashingCircleBrightColor,
                  // flashingCircleDarkColor: theme.flashingCircleDarkColor,
                  ),
              appBar: ChatViewAppBar(
                // elevation: theme.elevation,

                backGroundColor: Colors.teal,
                // profilePicture: Data.profileImage,
                // backArrowColor: theme.backArrowColor,
                chatTitle: state.currentUser.name,
                chatTitleTextStyle: const TextStyle(
                  // color: theme.appBarTitleTextStyle,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 0.25,
                  color: Colors.white,
                ),
                userStatus: "online",
                userStatusTextStyle: const TextStyle(color: Colors.black),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.dark_mode_outlined, color: Colors.white),
                  ),
                  IconButton(
                    tooltip: 'More',
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                  ),
                ],
              ),
              chatBackgroundConfig: const ChatBackgroundConfiguration(
                // backgroundColor: Colors.black,
                // messageTimeIconColor: theme.messageTimeIconColor,
                // messageTimeTextStyle: TextStyle(color: theme.messageTimeTextColor),
                defaultGroupSeparatorConfig: DefaultGroupSeparatorConfiguration(
                  textStyle: TextStyle(
                    // color: theme.chatHeaderColor,
                    fontSize: 17,
                  ),
                ),
                // backgroundColor: theme.backgroundColor,
              ),
              sendMessageConfig: SendMessageConfiguration(
                imagePickerIconsConfig: const ImagePickerIconsConfiguration(
                    // cameraIconColor: theme.cameraIconColor,
                    // galleryIconColor: theme.galleryIconColor,
                    ),
                // replyMessageColor: theme.replyMessageColor,
                // defaultSendButtonColor: theme.sendButtonColor,
                // replyDialogColor: theme.replyDialogColor,
                // replyTitleColor: theme.replyTitleColor,
                textFieldBackgroundColor: Colors.grey.shade300,
                // closeIconColor: theme.closeIconColor,
                textFieldConfig: TextFieldConfiguration(
                  onMessageTyping: (status) {
                    /// Do with status
                    debugPrint(status.toString());
                  },
                  compositionThresholdTime: const Duration(seconds: 1),
                  textStyle: const TextStyle(color: Colors.black),
                ),
                // micIconColor: theme.replyMicIconColor,
                voiceRecordingConfiguration: const VoiceRecordingConfiguration(
                  // backgroundColor: theme.waveformBackgroundColor,
                  // recorderIconColor: theme.recordIconColor,
                  waveStyle: WaveStyle(
                    showMiddleLine: false,
                    // waveColor: theme.waveColor ?? Colors.white,
                    extendWaveform: true,
                  ),
                ),
              ),
              chatBubbleConfig: ChatBubbleConfiguration(
                outgoingChatBubbleConfig: const ChatBubble(
                  linkPreviewConfig: LinkPreviewConfiguration(
                      // backgroundColor: theme.linkPreviewOutgoingChatColor,
                      // bodyStyle: theme.outgoingChatLinkBodyStyle,
                      // titleStyle: theme.outgoingChatLinkTitleStyle,
                      ),
                  receiptsWidgetConfig: ReceiptsWidgetConfig(showReceiptsIn: ShowReceiptsIn.all),
                  // color: theme.outgoingChatBubbleColor,
                ),
                inComingChatBubbleConfig: ChatBubble(
                  linkPreviewConfig: const LinkPreviewConfiguration(
                    linkStyle: TextStyle(
                      // color: theme.inComingChatBubbleTextColor,
                      decoration: TextDecoration.underline,
                    ),
                    // backgroundColor: theme.linkPreviewIncomingChatColor,
                    // bodyStyle: theme.incomingChatLinkBodyStyle,
                    // titleStyle: theme.incomingChatLinkTitleStyle,
                  ),
                  // textStyle: TextStyle(color: theme.inComingChatBubbleTextColor),
                  onMessageRead: (message) {
                    /// send your message reciepts to the other client
                    debugPrint('Message Read');
                  },
                  // senderNameTextStyle: TextStyle(color: theme.inComingChatBubbleTextColor),
                  // color: theme.inComingChatBubbleColor,
                ),
              ),
              replyPopupConfig: const ReplyPopupConfiguration(
                  // backgroundColor: theme.replyPopupColor,
                  // buttonTextStyle: TextStyle(color: theme.replyPopupButtonColor),
                  // topBorderColor: theme.replyPopupTopBorderColor,
                  ),
              reactionPopupConfig: const ReactionPopupConfiguration(
                shadow: BoxShadow(
                  // color: isDarkTheme ? Colors.black54 : Colors.grey.shade400,
                  blurRadius: 20,
                ),
                // backgroundColor: theme.reactionPopupColor,
              ),
              messageConfig: MessageConfiguration(
                messageReactionConfig: MessageReactionConfiguration(
                  // backgroundColor: theme.messageReactionBackGroundColor,
                  // borderColor: theme.messageReactionBackGroundColor,
                  // reactedUserCountTextStyle: TextStyle(color: theme.inComingChatBubbleTextColor),
                  // reactionCountTextStyle: TextStyle(color: theme.inComingChatBubbleTextColor),
                  reactionsBottomSheetConfig: ReactionsBottomSheetConfiguration(
                    // backgroundColor: theme.backgroundColor,
                    reactedUserTextStyle: const TextStyle(
                        // color: theme.inComingChatBubbleTextColor,
                        ),
                    reactionWidgetDecoration: BoxDecoration(
                      // color: theme.inComingChatBubbleColor,
                      boxShadow: const [
                        BoxShadow(
                          // color: isDarkTheme ? Colors.black12 : Colors.grey.shade200,
                          offset: Offset(0, 20),
                          blurRadius: 40,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                imageMessageConfig: ImageMessageConfiguration(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  shareIconConfig: ShareIconConfiguration(
                      // defaultIconBackgroundColor: theme.shareIconBackgroundColor,
                      // defaultIconColor: theme.shareIconColor,
                      ),
                ),
              ),
              profileCircleConfig: const ProfileCircleConfiguration(
                  // profileImageUrl: Data.profileImage,
                  ),
              repliedMessageConfig: RepliedMessageConfiguration(
                // backgroundColor: theme.repliedMessageColor,
                // verticalBarColor: theme.verticalBarColor,
                repliedMsgAutoScrollConfig: RepliedMsgAutoScrollConfig(
                  enableHighlightRepliedMsg: true,
                  highlightColor: Colors.pinkAccent.shade100,
                  highlightScale: 1.1,
                ),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.25,
                ),
                // replyTitleTextStyle: TextStyle(color: theme.repliedTitleTextColor),
              ),
              swipeToReplyConfig: const SwipeToReplyConfiguration(
                  // replyIconColor: theme.swipeToReplyIconColor,
                  ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
