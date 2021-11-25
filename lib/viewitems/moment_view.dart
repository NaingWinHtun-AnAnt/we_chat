import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:video_player/video_player.dart';
import 'package:we_chat/data/vos/comment_vo.dart';
import 'package:we_chat/data/vos/like_vo.dart';
import 'package:we_chat/data/vos/moment_vo.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/resources/strings.dart';
import 'package:we_chat/widgets/image_view.dart';
import 'package:we_chat/widgets/vertical_list_view.dart';

class MomentView extends StatelessWidget {
  final MomentVO? moment;
  final List<LikeVO>? likeUserList;
  final List<CommentVO>? commentList;
  final Function(int) onTapLike;
  final Function(int) onTapComment;
  final Function(int) onTapEdit;
  final Function(int) onTapDelete;

  const MomentView({
    Key? key,
    required this.moment,
    required this.likeUserList,
    required this.commentList,
    required this.onTapLike,
    required this.onTapComment,
    required this.onTapEdit,
    required this.onTapDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: marginMedium2,
      ),
      color: colorWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContentView(
            moment: moment,
          ),
          const SizedBox(
            height: marginMedium2,
          ),
          MomentFileView(
            momentFileUrl: moment?.momentFileUrl,
            isVideoFile: moment?.isVideoFile ?? false,
          ),
          OptionsButtonSectionView(
            onTapLike: () => onTapLike(moment?.id ?? 0),
            onTapComment: () => onTapComment(moment?.id ?? 0),
            onTapEdit: () => onTapEdit(moment?.id ?? 0),
            onTapDelete: () => onTapDelete(moment?.id ?? 0),
          ),
          const SizedBox(
            height: marginMedium2,
          ),
          Container(
            height: marginSmall,
            color: colorGrey3,
          ),
          const SizedBox(
            height: marginMedium2,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: momentViewImageSize,
            ),
            child: LikeAndCommentSectionView(
              likeUserList: likeUserList,
              commentList: commentList,
            ),
          ),
        ],
      ),
    );
  }
}

class MomentFileView extends StatelessWidget {
  final bool isVideoFile;
  final String? momentFileUrl;

  const MomentFileView({
    Key? key,
    required this.momentFileUrl,
    required this.isVideoFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: momentFileUrl != null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: marginMedium,
            ),
            child: isVideoFile
                ? FlickVideoPlayer(
                    flickManager: FlickManager(
                      videoPlayerController:
                          VideoPlayerController.network(momentFileUrl ?? ""),
                    ),
                  )
                : ImageView(
                    imageUrl: momentFileUrl ?? "-",
                    radius: momentViewImageRadius,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.33,
                  ),
          ),
          const SizedBox(
            height: marginMedium2,
          ),
        ],
      ),
    );
  }
}

class OptionsButtonSectionView extends StatelessWidget {
  final Function onTapLike;
  final Function onTapComment;
  final Function onTapEdit;
  final Function onTapDelete;

  const OptionsButtonSectionView({
    Key? key,
    required this.onTapLike,
    required this.onTapComment,
    required this.onTapEdit,
    required this.onTapDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: marginMedium,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => onTapLike(),
            child: const Icon(
              Icons.favorite_border_rounded,
              color: colorGrey3,
            ),
          ),
          const SizedBox(
            width: marginMedium2,
          ),
          GestureDetector(
            onTap: () => onTapComment(),
            child: const Icon(
              Icons.comment_outlined,
              color: colorGrey3,
            ),
          ),
          const SizedBox(
            width: marginMedium,
          ),
          PopupMenuButton(
            icon: const Icon(
              Icons.more_horiz_rounded,
              color: colorGrey3,
            ),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: const Text(
                  momentEdit,
                ),
                onTap: () => onTapEdit(),
              ),
              PopupMenuItem(
                child: const Text(
                  momentDelete,
                ),
                onTap: () => onTapDelete(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ContentView extends StatelessWidget {
  final MomentVO? moment;

  const ContentView({
    required this.moment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(left: momentViewImageSize / 2),
          child: ImageView(
            imageUrl: moment?.userImageUrl ?? "",
            radius: momentViewImageSize / 2,
            height: momentViewImageSize,
            width: momentViewImageSize,
          ),
        ),
        Positioned(
          top: momentViewImageSize * 0.4 - textRegular,
          right: marginMedium2,
          child: Text(
            moment?.uploadedTimeAgo() ?? "",
            style: const TextStyle(
              fontSize: textRegular,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: momentViewImageSize * 0.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: colorGrey,
              ),
              Container(
                margin: const EdgeInsets.only(left: momentViewImageSize * 1.7),
                child: Text(
                  moment?.userName ?? "-",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: textRegular3x,
                  ),
                ),
              ),
              const SizedBox(
                height: marginMedium2,
              ),
              Container(
                margin: const EdgeInsets.only(left: momentViewImageSize),
                child: Text(
                  moment?.content ?? "-",
                  style: const TextStyle(
                    fontSize: textRegular2x,
                    fontWeight: FontWeight.w600,
                    color: colorGrey2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LikeAndCommentSectionView extends StatelessWidget {
  final List<LikeVO>? likeUserList;
  final List<CommentVO>? commentList;

  const LikeAndCommentSectionView({
    Key? key,
    this.likeUserList,
    this.commentList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Visibility(
          visible: likeUserList != null && (likeUserList?.isNotEmpty ?? true),
          child: DrawableTextView(
            iconData: Icons.favorite,
            content: Text(
              (likeUserList != null && likeUserList!.isNotEmpty)
                  ? likeUserList
                          ?.reduce(
                            (value, element) => LikeVO(
                              id: 213134,
                              userName: "${value.userName},${element.userName}",
                            ),
                          )
                          .userName ??
                      "-"
                  : "-",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: textRegular2x,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: marginSmall,
        ),
        Visibility(
          visible: commentList != null && (commentList?.isNotEmpty ?? true),
          child: DrawableTextView(
            iconData: Icons.chat,
            content: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: VerticalListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: commentList?.length ?? 0,
                itemBuilder: (BuildContext context, int index) => CommentView(
                  comment: commentList?[index],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CommentView extends StatelessWidget {
  final CommentVO? comment;

  const CommentView({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          comment?.userName ?? "-",
          style: const TextStyle(
            fontSize: textRegular2x,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          width: marginSmall,
        ),
        Text(
          comment?.comment ?? "-",
          style: const TextStyle(
            fontSize: textRegular,
            fontWeight: FontWeight.w500,
            color: colorGrey2,
          ),
        ),
      ],
    );
  }
}

class DrawableTextView extends StatelessWidget {
  final IconData iconData;
  final Widget content;

  const DrawableTextView({
    Key? key,
    required this.iconData,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          iconData,
          size: 20,
          color: colorGrey,
        ),
        const SizedBox(
          width: marginMedium,
        ),
        Flexible(child: content),
      ],
    );
  }
}
