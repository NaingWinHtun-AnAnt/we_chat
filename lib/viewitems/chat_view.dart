import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:we_chat/data/vos/message_vo.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/widgets/image_view.dart';

class ChatView extends StatelessWidget {
  final MessageVO? message;
  final UserVO? user;
  final String? contactProfilePath;

  const ChatView({
    Key? key,
    required this.message,
    required this.contactProfilePath,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: message?.message != "",
      child: Container(
        margin: const EdgeInsets.only(
          bottom: marginMedium,
        ),
        padding: EdgeInsets.only(
          left: message?.isMyMessage(user?.id) ?? true
              ? MediaQuery.of(context).size.width * 0.14
              : marginMedium,
          right: message?.isMyMessage(user?.id) ?? true
              ? marginMedium
              : MediaQuery.of(context).size.width * 0.14,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: message?.isMyMessage(user?.id) ?? true
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            ChatImageView(
              visibility: message?.isMyMessage(user?.id) ?? true,
              imageUrl: contactProfilePath,
            ),
            const SizedBox(
              width: marginMedium,
            ),
            ChatSectionView(
              message: message,
              user: user,
            ),
          ],
        ),
      ),
    );
  }
}

class ChatImageView extends StatelessWidget {
  final bool visibility;
  final String? imageUrl;

  const ChatImageView({
    Key? key,
    required this.visibility,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      /// hide profile image if message is mine
      visible: !visibility,
      child: ImageView(
        imageUrl: imageUrl ?? "",
        radius: chatProfileSize / 2,
        width: chatProfileSize,
        height: chatProfileSize,
      ),
    );
  }
}

class ChatSectionView extends StatelessWidget {
  final UserVO? user;
  final MessageVO? message;

  const ChatSectionView({
    Key? key,
    required this.message,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: message?.isMyMessage(user?.id) ?? false
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          FileMessageView(
            fileUrl: message?.fileUrl,
            isVideoFile: message?.isVideoFile ?? false,
          ),
          ChatTextView(
            text: message?.message,
          ),
        ],
      ),
    );
  }
}

class ChatTextView extends StatelessWidget {
  final String? text;

  const ChatTextView({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: text != null,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: marginMedium,
          horizontal: marginMedium2,
        ),
        decoration: BoxDecoration(
          color: colorChatTextBackground,
          borderRadius: BorderRadius.circular(
            chatTextBorderRadius,
          ),
        ),
        child: Text(
          text ?? "",
          style: const TextStyle(
            fontSize: textRegular2x,
            fontWeight: FontWeight.w600,
            color: colorChatText,
          ),
        ),
      ),
    );
  }
}

class FileMessageView extends StatelessWidget {
  final String? fileUrl;
  final bool isVideoFile;

  const FileMessageView({
    Key? key,
    required this.fileUrl,
    required this.isVideoFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: fileUrl != null,
      child: Column(
        children: [
          isVideoFile
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: FlickVideoPlayer(
                    flickManager: FlickManager(
                      videoPlayerController:
                          VideoPlayerController.network(fileUrl ?? ""),
                    ),
                  ),
                )
              : ImageView(
                  imageUrl: fileUrl ?? "-",
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.2,
                  radius: chatTextBorderRadius * 0.5,
                ),
          const SizedBox(
            height: marginMedium,
          ),
        ],
      ),
    );
  }
}
