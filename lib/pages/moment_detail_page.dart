import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/blocs/moment_detail_bloc.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/resources/strings.dart';
import 'package:we_chat/viewitems/moment_view.dart';

class MomentDetailPage extends StatelessWidget {
  final int momentId;
  final bool isCommentMode;

  const MomentDetailPage({
    Key? key,
    required this.momentId,
    this.isCommentMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          MomentDetailBloc(momentId, isCommentMode),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: colorWhite,
            ),
          ),
          automaticallyImplyLeading: false,
          title: const Text(
            momentDetail,
            style: TextStyle(color: colorWhite),
          ),
          centerTitle: true,
          backgroundColor: colorPrimary,
        ),
        body: Consumer(
          builder:
              (BuildContext context, MomentDetailBloc bloc, Widget? child) =>
                  Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: bloc.isCommentMode
                        ? textControlHeight + marginLarge
                        : 0,
                  ),
                  child: MomentView(
                    alreadyLike: bloc.alreadyLike,
                    moment: bloc.moment,
                    likeUserList: bloc.likeUserList,
                    commentList: bloc.commentUserList,
                    onTapMoment: (moment) {},
                    onTapEdit: (momentId) {},
                    onTapDelete: (momentId) {},
                    onTapLike: (moment) => bloc.onTapLike(moment.id),
                    onTapComment: (momentId) =>
                        bloc.onTapComment(bloc.isCommentMode),
                  ),
                ),
              ),
              Visibility(
                visible: bloc.isCommentMode,
                child: SizedBox(
                  height: double.infinity,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AddNewCommentView(
                      onTextChange: (value) =>
                          bloc.onNewCommentTextChanged(value),
                      onTapSendComment: () =>
                          bloc.onTapCommentToAddNewComment(momentId),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddNewCommentView extends StatelessWidget {
  final Function(String) onTextChange;
  final Function onTapSendComment;

  const AddNewCommentView({
    Key? key,
    required this.onTextChange,
    required this.onTapSendComment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        marginMedium2,
      ),
      color: colorWhite,
      child: SizedBox(
        height: textControlHeight,
        child: Center(
          child: TextFormField(
            onChanged: (value) => onTextChange(value),
            onFieldSubmitted: (value) => onTapSendComment(),
            autofocus: true,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () => onTapSendComment(),
                child: const Icon(
                  Icons.send,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  marginMedium,
                ),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
