import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/blocs/moment_bloc.dart';
import 'package:we_chat/data/vos/moment_vo.dart';
import 'package:we_chat/pages/add_new_moment_page.dart';
import 'package:we_chat/pages/moment_detail_page.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/resources/strings.dart';
import 'package:we_chat/viewitems/moment_view.dart';
import 'package:we_chat/widgets/image_view.dart';
import 'package:we_chat/widgets/leading_view.dart';
import 'package:we_chat/widgets/vertical_list_view.dart';

class MomentPage extends StatelessWidget {
  const MomentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MomentBloc(),
      child: Scaffold(
        backgroundColor: colorWhite,
        appBar: AppBar(
          backgroundColor: colorPrimary,
          centerTitle: true,
          leading: LeadingView(
            onTap: () {
              Navigator.of(context).pop();
            },
            text: discover,
          ),
          leadingWidth: leadingWidth,
          title: const Text(
            moments,
          ),
          actions: const [
            Icon(
              Icons.camera_alt,
            ),
            SizedBox(
              width: marginMedium2,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const ContactMomentInfoView(),
              const SizedBox(
                height: marginSmall,
              ),
              Consumer(
                builder:
                    (BuildContext context, MomentBloc bloc, Widget? child) =>
                        VerticalListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bloc.momentList?.length ?? 0,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) =>
                      MomentView(
                    alreadyLike: bloc.momentList?[index].like
                            ?.map((e) => e.id)
                            .contains(bloc.loginUser?.id) ??
                        false,
                    moment: bloc.momentList?[index],
                    commentList: bloc.momentList?[index].comment,
                    likeUserList: bloc.momentList?[index].like,
                    onTapMoment: (momentId) =>
                        _navigateToMomentDetailPage(context, momentId),
                    onTapLike: (moment) => _onTapMomentLike(
                      context,
                      moment,
                    ),
                    onTapComment: (momentId) => _navigateToMomentDetailPage(
                      context,
                      momentId,
                      isCommentMode: true,
                    ),
                    onTapEdit: (momentId) =>
                        _onTapMomentEdit(context, momentId),
                    onTapDelete: (momentId) =>
                        _onTapMomentDelete(context, momentId),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: colorPrimary,
          onPressed: () => _navigateToAddNewMomentPage(context),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _navigateToAddNewMomentPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const AddNewMomentPage(),
      ),
    );
  }

  void _navigateToMomentDetailPage(BuildContext context, int momentId,
      {bool isCommentMode = false}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => MomentDetailPage(
          momentId: momentId,
          isCommentMode: isCommentMode,
        ),
      ),
    );
  }

  void _onTapMomentLike(BuildContext context, MomentVO? moment) {
    final bloc = Provider.of<MomentBloc>(context, listen: false);
    if (moment != null) bloc.onTapMomentLike(moment);
  }

  /// navigate to moment create page with edit mode
  void _onTapMomentEdit(BuildContext context, int momentId) {
    Future.delayed(const Duration(seconds: 1)).then(
      (value) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => AddNewMomentPage(
            momentId: momentId,
          ),
        ),
      ),
    );
  }

  void _onTapMomentDelete(BuildContext context, int momentId) {
    final bloc = Provider.of<MomentBloc>(context, listen: false);
    bloc.onTapMomentDelete(momentId);
  }
}

class ContactMomentInfoView extends StatelessWidget {
  const ContactMomentInfoView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: colorWhite,
          height: MediaQuery.of(context).size.height * 0.325,
        ),
        ImageView(
          height: MediaQuery.of(context).size.height * 0.24,
          width: double.infinity,
          imageUrl: dummyNetworkImage,
        ),
        Positioned(
          top: (MediaQuery.of(context).size.height * 0.24) -
              (textRegular3x + marginMedium2),
          right: marginMedium2,
          child: const Text(
            "Naing Win Htun",
            style: TextStyle(
              fontSize: textRegular3x,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          left: momentContactImageSize * 1.1,
          top: (MediaQuery.of(context).size.height * 0.24) -
              (momentContactImageSize / 2),
          child: const ImageView(
            height: momentContactImageSize,
            width: momentContactImageSize,
            radius: momentContactImageSize / 2,
            imageUrl: dummyNetworkImage,
          ),
        ),
        Positioned(
          right: marginMedium2,
          top: (MediaQuery.of(context).size.height * 0.24) + marginMedium2,
          child: const NotifyMomentView(),
        ),
      ],
    );
  }
}

class NotifyMomentView extends StatelessWidget {
  const NotifyMomentView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: const [
        NotifyTextView(
          text: "5 May 2021",
        ),
        SizedBox(
          height: marginSmall,
        ),
        NotifyTextView(text: "2 new moments"),
      ],
    );
  }
}

class NotifyTextView extends StatelessWidget {
  final String? text;

  const NotifyTextView({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "-",
      style: const TextStyle(
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
