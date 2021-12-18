import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/blocs/we_chat_bloc.dart';
import 'package:we_chat/data/vos/message_vo.dart';
import 'package:we_chat/pages/chat_page.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/resources/strings.dart';
import 'package:we_chat/viewitems/we_chat_view.dart';
import 'package:we_chat/widgets/icon_and_label_view.dart';
import 'package:we_chat/widgets/separated_vertical_list_view.dart';

class WeChatPage extends StatelessWidget {
  const WeChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => WeChatBloc(),
      child: Scaffold(
        backgroundColor: colorWhite,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(weChat),
          actions: [
            GestureDetector(
              onTap: () => _onTapAddContact(context),
              child: const Icon(Icons.add),
            ),
            const SizedBox(
              width: marginMedium2,
            ),
          ],
          backgroundColor: colorPrimary,
        ),
        body: Consumer(
          builder: (BuildContext context, WeChatBloc bloc, Widget? child) =>
              SeparatedVerticalListView(
            padding: const EdgeInsets.symmetric(
              vertical: marginMedium2,
            ),
            itemCount: bloc.recentMessageList?.length ?? 0,
            itemBuilder: (BuildContext context, int index) => WeChatView(
              onTap: () => _navigateToChatPage(
                  context, bloc.recentMessageList?[index], bloc.user?.id ?? ""),
              messageVO: bloc.recentMessageList?[index],
              contactProfilePath: bloc.contactProfilePath,
            ),
          ),
        ),
      ),
    );
  }

  void _onTapAddContact(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext buildContext) => const AlertDialog(
        backgroundColor: colorWhite,
        content: AddNewContactDialogView(),
      ),
    );
  }

  void _navigateToChatPage(
      BuildContext context, MessageVO? message, String loginUserId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ChatPage(
          contactUserId: loginUserId == (message?.receiveUserId ?? "")
              ? message?.receiveUserId ?? ""
              : message?.userId ?? "",
          contactUserName: message?.receiverUserName ?? "",
          contactProfilePath: message?.receiverProfilePath ?? "",
        ),
      ),
    );
  }
}

class AddNewContactDialogView extends StatelessWidget {
  const AddNewContactDialogView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        IconAndLabelView(
          icon: Icons.group,
          text: groupChat,
        ),
        SizedBox(
          width: marginMedium2,
        ),
        IconAndLabelView(
          icon: Icons.add_circle_rounded,
          text: addContact,
        ),
        SizedBox(
          width: marginMedium2,
        ),
        IconAndLabelView(
          icon: Icons.account_box_outlined,
          text: scanQrCode,
        ),
      ],
    );
  }
}
