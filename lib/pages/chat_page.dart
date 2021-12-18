import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/blocs/chat_bloc.dart';
import 'package:we_chat/data/vos/message_vo.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/resources/strings.dart';
import 'package:we_chat/viewitems/chat_view.dart';
import 'package:we_chat/viewitems/selected_file_view.dart';
import 'package:we_chat/widgets/leading_view.dart';
import 'package:we_chat/widgets/vertical_list_view.dart';

class ChatPage extends StatelessWidget {
  final String contactUserId;
  final String contactUserName;
  final String contactProfilePath;

  const ChatPage({
    Key? key,
    required this.contactUserId,
    required this.contactUserName,
    required this.contactProfilePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ChatBloc(contactUserId),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorPrimary,
          leading: LeadingView(
            onTap: () {
              Navigator.of(context).pop();
            },
            text: weChat,
          ),
          leadingWidth: leadingWidth,
          centerTitle: true,
          title: Text(contactUserName),
          actions: const [
            Icon(Icons.person),
            SizedBox(
              width: marginMedium2,
            ),
          ],
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Selector(
              selector: (BuildContext context, ChatBloc bloc) =>
                  bloc.messageList,
              builder: (BuildContext context, List<MessageVO>? mMessageList,
                      Widget? child) =>
                  VerticalListView(
                itemCount: mMessageList?.length ?? 0,
                reverse: true,
                padding: const EdgeInsets.only(
                  top: marginMedium,
                  bottom: textControlHeight + marginMedium3,
                ),
                itemBuilder: (BuildContext context, int index) =>
                    Consumer<ChatBloc>(
                  builder:
                      (BuildContext context, ChatBloc bloc, Widget? child) =>
                          ChatView(
                    user: bloc.loginUser,
                    message: mMessageList?[index],
                    contactProfilePath: contactProfilePath,
                  ),
                ),
              ),
            ),
            Consumer(
              builder: (BuildContext context, ChatBloc bloc, Widget? child) =>
                  ChatControlView(
                onTextChange: (message) => _onTextChange(context, message),
                onTapSend: () => _onTapSend(context),
                text: bloc.text,
                onSelectFile: () => onSelectFile(context),
                isVideoFile: bloc.isVideoFile,
                onSelectedFileDelete: () => bloc.onSelectedFileDelete(),
                selectedFile: bloc.selectedFile,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTextChange(BuildContext context, String message) {
    final bloc = Provider.of<ChatBloc>(context, listen: false);
    bloc.onMessageTextChange(message);
  }

  void onSelectFile(BuildContext context) async {
    final bloc = Provider.of<ChatBloc>(context, listen: false);
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      bloc.onFileSelected(
          File(
            result.files.single.path ?? "",
          ),
          (result.files.first.extension ?? "") == "mp4");
    }
  }

  void _onTapSend(
    BuildContext context,
  ) {
    final bloc = Provider.of<ChatBloc>(context, listen: false);
    bloc.onTapSendMessage(contactUserId, contactUserName, contactProfilePath);
  }
}

class ChatControlView extends StatelessWidget {
  final Function(String) onTextChange;
  final Function onTapSend;
  final Function onSelectFile;
  final Function onSelectedFileDelete;
  final bool isVideoFile;
  final File? selectedFile;
  final String? text;

  const ChatControlView({
    Key? key,
    this.text,
    required this.onTextChange,
    required this.onTapSend,
    required this.onSelectFile,
    required this.onSelectedFileDelete,
    required this.isVideoFile,
    required this.selectedFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        marginMedium,
      ),
      color: colorChatControl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectedFileView(
            isVideoFile: isVideoFile,
            height: selectChatFileSize,
            width: selectChatFileSize,
            onSelectedFileDelete: () => onSelectedFileDelete(),
            chosenFile: selectedFile,
          ),
          const SizedBox(
            height: marginMedium,
          ),
          Row(
            children: [
              const Icon(Icons.mic),
              const SizedBox(
                width: marginCardMedium2,
              ),
              Flexible(
                child: SizedBox(
                  height: textControlHeight,
                  child: TextFormField(
                    onChanged: (value) => onTextChange(value),
                    onFieldSubmitted: (value) => onTapSend(),
                    controller: TextEditingController(text: text),
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () => onTapSend(),
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
              const SizedBox(
                width: marginCardMedium2,
              ),
              GestureDetector(
                onTap: () => onSelectFile(),
                child: const Icon(
                  Icons.add,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
