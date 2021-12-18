import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/widgets/image_view.dart';

class SelectedFileView extends StatelessWidget {
  final File? chosenFile;
  final Function onSelectedFileDelete;
  final bool isVideoFile;
  final bool isEditMode;
  final double? width;
  final double height;
  final String? fileUrl;

  const SelectedFileView({
    Key? key,
    required this.chosenFile,
    required this.onSelectedFileDelete,
    required this.isVideoFile,
    this.width = double.infinity,
    required this.height,
    this.fileUrl,
    this.isEditMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: chosenFile != null || fileUrl != null,
      child: SizedBox(
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            height * 0.1,
          ),
          child: Stack(
            children: [
              isVideoFile
                  ? FlickVideoPlayer(
                      flickManager: FlickManager(
                        videoPlayerController: VideoPlayerController.file(
                          chosenFile ?? File(""),
                        ),
                      ),
                    )
                  : isEditMode && fileUrl != null
                      ? Visibility(
                          visible: fileUrl != null,
                          child: ImageView(
                            imageUrl: fileUrl ?? "No Network Image",
                            width: width ?? 0,
                            height: height,
                          ),
                        )
                      : Image.file(
                          chosenFile ?? File(""),
                          width: width,
                          height: height,
                          fit: BoxFit.cover,
                        ),
              Align(
                alignment: Alignment.topRight,
                child: Visibility(
                  visible: chosenFile != null || fileUrl != null,
                  child: GestureDetector(
                    onTap: () => onSelectedFileDelete(),
                    child: const Padding(
                      padding: EdgeInsets.all(
                        marginMedium,
                      ),
                      child: Icon(
                        Icons.delete_rounded,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
