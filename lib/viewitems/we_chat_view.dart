import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:we_chat/data/vos/message_vo.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/widgets/image_view.dart';

class WeChatView extends StatelessWidget {
  final String? contactProfilePath;
  final MessageVO? messageVO;
  final Function onTap;

  const WeChatView({
    Key? key,
    required this.onTap,
    required this.messageVO,
    required this.contactProfilePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: marginMedium2,
        ),
        color: colorWhite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageView(
              imageUrl: contactProfilePath ?? "-",
              radius: weChatViewImageSize / 2,
              width: weChatViewImageSize,
              height: weChatViewImageSize,
            ),
            const SizedBox(
              width: marginMedium,
            ),
            Flexible(
              child: ContentSectionView(
                message: messageVO,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContentSectionView extends StatelessWidget {
  final MessageVO? message;

  const ContentSectionView({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: marginSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NameAndDateSectionView(
            contactName: message?.receiverUserName,
          ),
          const SizedBox(
            height: marginMedium,
          ),
          Text(
            message?.message ?? "-",
            maxLines: 2,
            style: const TextStyle(
              fontSize: textRegular2x,
              color: colorGrey2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class NameAndDateSectionView extends StatelessWidget {
  final String? contactName;

  const NameAndDateSectionView({
    Key? key,
    required this.contactName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          contactName ?? "-",
          style: const TextStyle(
            color: colorGrey3,
            fontSize: textRegular3x,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Text(
          "8/23/14",
          style: TextStyle(
            color: colorGrey,
          ),
        ),
      ],
    );
  }
}
