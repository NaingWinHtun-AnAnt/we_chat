import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/blocs/we_chat_bloc.dart';
import 'package:we_chat/data/vos/conversation_vo.dart';
import 'package:we_chat/pages/chat_page.dart';
import 'package:we_chat/pages/qr_page.dart';
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
        body: Selector(
          selector: (BuildContext context, WeChatBloc bloc) =>
              bloc.conversationList,
          builder: (BuildContext context,
                  List<ConversationVO>? mConversationList, Widget? child) =>
              SeparatedVerticalListView(
            padding: const EdgeInsets.symmetric(
              vertical: marginMedium2,
            ),
            itemCount: mConversationList?.length ?? 0,
            itemBuilder: (BuildContext context, int index) => WeChatView(
              onTap: () =>
                  _navigateToChatPage(context, mConversationList?[index]),
              conversationVO: mConversationList?[index],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapAddContact(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext buildContext) => AlertDialog(
        backgroundColor: colorWhite,
        content: AddNewContactDialogView(
          onTapScanQrCode: () {
            Navigator.of(context).pop();
            _navigateToQrPage(context);
          },
        ),
      ),
    );
  }

  void _navigateToQrPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const QrPage(),
      ),
    );
  }

  void _navigateToChatPage(BuildContext context, ConversationVO? conversation) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ChatPage(
          conversation: conversation,
        ),
      ),
    );
  }
}

class AddNewContactDialogView extends StatelessWidget {
  final Function onTapScanQrCode;

  const AddNewContactDialogView({
    Key? key,
    required this.onTapScanQrCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconAndLabelView(
          icon: Icons.group,
          text: groupChat,
          onTap: () {},
        ),
        const SizedBox(
          width: marginMedium2,
        ),
        IconAndLabelView(
          icon: Icons.add_circle_rounded,
          text: addContact,
          onTap: () {},
        ),
        const SizedBox(
          width: marginMedium2,
        ),
        IconAndLabelView(
          icon: Icons.account_box_outlined,
          text: scanQrCode,
          onTap: () => onTapScanQrCode(),
        ),
      ],
    );
  }
}
