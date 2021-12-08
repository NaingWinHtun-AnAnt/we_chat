import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/blocs/add_new_moment_bloc.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/resources/strings.dart';
import 'package:we_chat/viewitems/selected_file_view.dart';
import 'package:we_chat/widgets/image_view.dart';
import 'package:we_chat/widgets/loading_view.dart';

class AddNewMomentPage extends StatelessWidget {
  final int? momentId;

  const AddNewMomentPage({
    Key? key,
    this.momentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddNewMomentBloc(momentId: momentId),
      child: Selector(
        selector: (
          BuildContext context,
          AddNewMomentBloc bloc,
        ) =>
            bloc.isLoading,
        builder: (
          BuildContext context,
          bool isLoading,
          Widget? child,
        ) =>
            Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: const Text(
                  addNewMoment,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                elevation: 0.0,
                leading: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                    size: marginXLarge,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(
                    top: marginMedium,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: marginLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const ProfileImageAndNameView(),
                      const SizedBox(
                        height: marginLarge,
                      ),
                      const AddNewMomentTextFieldView(),
                      const SizedBox(
                        height: marginMedium,
                      ),
                      const MomentContentErrorView(),
                      const SizedBox(
                        height: marginMedium,
                      ),
                      const Text(
                        momentFileLabel,
                        style: TextStyle(
                          fontSize: textRegular2x,
                          fontWeight: FontWeight.w500,
                          color: colorGrey3,
                        ),
                      ),
                      const SizedBox(
                        height: marginMedium2,
                      ),
                      Consumer<AddNewMomentBloc>(
                        builder: (context, bloc, child) => Row(
                          children: [
                            GestureDetector(
                              onTap: () => _onFileSelect(context),
                              child: Container(
                                height: selectMomentFileHeight,
                                width: selectMomentFileHeight,
                                decoration: BoxDecoration(
                                  color: colorChatControl,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: colorPrimary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: marginMedium,
                            ),
                            Flexible(
                              child: SelectedFileView(
                                height: selectMomentFileHeight,
                                width: bloc.isVideoFile
                                    ? selectMomentFileHeight * 1.75
                                    : selectMomentFileHeight,
                                chosenFile: bloc.chosenFile,
                                onSelectedFileDelete: () =>
                                    bloc.onTapDeleteImage(),
                                isVideoFile: bloc.isVideoFile,
                                fileUrl: bloc.momentFileUrl,
                                isEditMode: bloc.isEditMode,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: marginLarge,
                      ),
                      CreateMomentButtonView(
                        buttonText:
                            momentId != null ? editMoment : addNewMoment,
                      ),
                      const SizedBox(
                        height: marginLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoading,
              child: const LoadingView(),
            ),
          ],
        ),
      ),
    );
  }

  void _onFileSelect(BuildContext context) async {
    final bloc = Provider.of<AddNewMomentBloc>(context, listen: false);
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      bloc.onFileSelected(
          File(
            result.files.single.path ?? "",
          ),
          (result.files.first.extension ?? "") == "mp4");
    }
  }
}

class MomentContentErrorView extends StatelessWidget {
  const MomentContentErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewMomentBloc>(
      builder: (BuildContext context, AddNewMomentBloc bloc, Widget? child) =>
          Visibility(
        visible: bloc.isAddNewPostError,
        child: const Text(
          momentContentError,
          style: TextStyle(
            color: Colors.red,
            fontSize: textRegular,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class CreateMomentButtonView extends StatelessWidget {
  final String buttonText;

  const CreateMomentButtonView({
    Key? key,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewMomentBloc>(
      builder: (BuildContext context, AddNewMomentBloc bloc, Widget? child) =>
          GestureDetector(
        onTap: () {
          bloc.onCreateNewMoment().then((value) {
            Navigator.of(context).pop();
          });
        },
        child: Container(
          width: double.infinity,
          height: marginXXLarge,
          decoration: BoxDecoration(
            color: colorPrimary,
            borderRadius: BorderRadius.circular(
              marginLarge,
            ),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: textRegular2x,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddNewMomentTextFieldView extends StatelessWidget {
  const AddNewMomentTextFieldView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewMomentBloc>(
      builder: (BuildContext context, AddNewMomentBloc bloc, Widget? child) =>
          Flexible(
        child: TextField(
          maxLines: 20,
          onChanged: (text) => bloc.onNewMomentTextChanged(text),
          controller: TextEditingController(text: bloc.moment?.content),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: momentContentHint,
          ),
        ),
      ),
    );
  }
}

class ProfileImageAndNameView extends StatelessWidget {
  const ProfileImageAndNameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewMomentBloc>(
      builder: (BuildContext context, AddNewMomentBloc bloc, Widget? child) =>
          Row(
        children: const [
          ImageView(
            imageUrl: dummyNetworkImage,
            width: momentProfileSize,
            height: momentProfileSize,
            radius: momentProfileSize / 2,
          ),
          SizedBox(
            width: marginMedium2,
          ),
          Text(
            "Naming Win Htun",
            style: TextStyle(
              fontSize: textRegular2x,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
