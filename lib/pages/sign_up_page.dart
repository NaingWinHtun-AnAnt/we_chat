import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/blocs/sign_up_bloc.dart';
import 'package:we_chat/data/vos/region_vo.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/pages/region_page.dart';
import 'package:we_chat/pages/term_of_service_page.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/resources/strings.dart';
import 'package:we_chat/widgets/button_view.dart';
import 'package:we_chat/widgets/close_button_view.dart';
import 'package:we_chat/widgets/header_text_view.dart';
import 'package:we_chat/widgets/image_view.dart';
import 'package:we_chat/widgets/region_input_view.dart';
import 'package:we_chat/widgets/text_input_view.dart';

// class RegisterPage extends StatelessWidget {
//   const RegisterPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (BuildContext context) => RegisterBloc(),
//       child: Scaffold(
//         body: Selector(
//           selector: (
//             BuildContext context,
//             RegisterBloc bloc,
//           ) =>
//               bloc.isLoading,
//           builder: (
//             BuildContext context,
//             bool isLoading,
//             Widget? child,
//           ) =>
//               Stack(
//             children: [
//               Center(
//                 child: SingleChildScrollView(
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(
//                       horizontal: marginMedium2,
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           labelRegister,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: textBig,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: marginXXLarge,
//                         ),
//                         Consumer(
//                           builder: (BuildContext context, RegisterBloc bloc,
//                                   Widget? child) =>
//                               LabelAndTextFieldView(
//                             label: labelEmail,
//                             hint: hintEmail,
//                             onChanged: (value) => bloc.onEmailChanged(value),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: marginXLarge,
//                         ),
//                         Consumer(
//                           builder: (BuildContext context, RegisterBloc bloc,
//                                   Widget? child) =>
//                               LabelAndTextFieldView(
//                             label: labelUserName,
//                             hint: hintUserName,
//                             onChanged: (value) => bloc.onUserNameChanged(value),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: marginXLarge,
//                         ),
//                         Consumer(
//                           builder: (BuildContext context, RegisterBloc bloc,
//                                   Widget? child) =>
//                               LabelAndTextFieldView(
//                             label: labelPassword,
//                             hint: hintPassword,
//                             onChanged: (value) => bloc.onPasswordChanged(value),
//                             isSecure: true,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: marginXXLarge,
//                         ),
//                         Consumer(
//                           builder: (BuildContext context, RegisterBloc bloc,
//                                   Widget? child) =>
//                               RoundCornerButtonView(
//                             onTap: () {
//                               bloc
//                                   .onTapRegister()
//                                   .then(
//                                     (value) => Navigator.of(context).pop(),
//                                   )
//                                   .catchError(
//                                     (error) => showSnackBarWithMessage(
//                                       context,
//                                       error.toString(),
//                                     ),
//                                   );
//                             },
//                             text: labelRegister,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: marginLarge,
//                         ),
//                         const ORView(),
//                         const SizedBox(
//                           height: marginLarge,
//                         ),
//                         const LoginTriggerView()
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Visibility(
//                 visible: isLoading,
//                 child: const LoadingView(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SignUpBloc(),
      child: Scaffold(
        backgroundColor: colorBlack,
        body: Consumer(
          builder: (BuildContext context, SignUpBloc bloc, Widget? child) =>
              SingleChildScrollView(
            child: Column(
              children: [
                CloseButtonView(
                  onTap: () => Navigator.of(context).pop(),
                ),
                const SizedBox(
                  height: marginXLarge,
                ),
                const HeaderTextView(
                  text: signUpByPhoneNumber,
                ),
                const SizedBox(
                  height: marginMedium3,
                ),
                bloc.chosenFile == null
                    ? GestureDetector(
                        onTap: () =>
                            _showImageResourceBottomSheet(context, bloc),
                        child: const ImageView(
                          imageUrl:
                              "https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg",
                          width: registerProfileImageSize,
                          height: registerProfileImageSize,
                        ),
                      )
                    : SizedBox(
                        height: registerProfileImageSize,
                        width: registerProfileImageSize,
                        child: Image.file(
                          bloc.chosenFile ?? File(""),
                          fit: BoxFit.cover,
                        ),
                      ),
                const SizedBox(
                  height: marginXLarge,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: marginMedium3,
                  ),
                  child: TextFieldSectionView(
                    region: bloc.region,
                    onNameChange: (value) => bloc.onUserNameChanged(value),
                    onTapRegion: () => _navigateToRegionPage(context),
                    onPhoneNumberChange: (value) =>
                        bloc.onPhoneNumberChanged(value),
                    onPasswordChange: (value) => bloc.onPasswordChanged(value),
                  ),
                ),
                const SizedBox(
                  height: marginXLarge,
                ),
                TermOfServiceView(
                  agree: bloc.isAgreeToTOS,
                  onTapAgree: (value) {
                    bloc.onTapAgreeToTOS(value);
                  },
                  onTap: () => _navigateToTermOfServicePage(
                    context,
                  ),
                ),
                const SizedBox(
                  height: 200,
                ),
                ButtonView(
                  text: signUp,
                  onTap: () {
                    bloc.isAgreeToTOS
                        ? _navigateToTermOfServicePage(
                            context,
                            showAction: true,
                            newUser: bloc.user,
                            chosenFile: bloc.chosenFile,
                          )
                        : null;
                  },
                  backgroundColor:
                      bloc.isAgreeToTOS ? colorPrimary : colorBlack2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(SignUpBloc bloc,
      {ImageSource source = ImageSource.gallery}) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      bloc.onImageSelect(File(image.path));
    }
  }

  void _showImageResourceBottomSheet(
    BuildContext context,
    SignUpBloc bloc,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => ImageResourceLayoutView(
        takePicture: () => _pickImage(
          bloc,
          source: ImageSource.camera,
        ),
        pickFromGallery: () => _pickImage(
          bloc,
          source: ImageSource.gallery,
        ),
      ),
    );
  }

  void _navigateToTermOfServicePage(
    BuildContext context, {
    bool showAction = false,
    UserVO? newUser,
    File? chosenFile,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => TermOfServicePage(
          showActions: showAction,
          newUser: newUser,
          chosenFile: chosenFile,
        ),
      ),
    );
  }

  void _navigateToRegionPage(BuildContext context) {
    final bloc = Provider.of<SignUpBloc>(context, listen: false);
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (BuildContext context) => const RegionPage(),
          ),
        )
        .then((value) => bloc.onUserRegionChanged(value as RegionVO));
  }
}

class ImageResourceLayoutView extends StatelessWidget {
  final Function takePicture;
  final Function pickFromGallery;

  const ImageResourceLayoutView({
    Key? key,
    required this.takePicture,
    required this.pickFromGallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: colorBlack2,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ResourceItemView(
            icon: Icons.camera_alt,
            label: takeFromCamera,
            onTap: () {
              Navigator.of(context).pop();
              takePicture();
            },
          ),
          const Divider(
            color: colorGrey,
          ),
          ResourceItemView(
            icon: Icons.folder,
            label: selectFromGallery,
            onTap: () {
              Navigator.of(context).pop();
              pickFromGallery();
            },
          ),
        ],
      ),
    );
  }
}

class ResourceItemView extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onTap;

  const ResourceItemView({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        color: colorBlack2,
        padding: const EdgeInsets.symmetric(
          horizontal: marginMedium3,
          vertical: marginMedium2,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: colorWhite,
            ),
            const SizedBox(
              width: marginMedium2,
            ),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: colorWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TermOfServiceView extends StatelessWidget {
  final bool agree;
  final Function(bool) onTapAgree;
  final Function onTap;

  const TermOfServiceView({
    Key? key,
    required this.agree,
    required this.onTapAgree,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: agree,
            onChanged: (value) => onTapAgree(value ?? false),
            shape: const CircleBorder(),
            activeColor: colorPrimary,
          ),
        ),
        const SizedBox(
          width: marginSmall,
        ),
        const TermOfServiceTextView(
          text: 'Agree to',
        ),
        const SizedBox(
          width: marginSmall,
        ),
        GestureDetector(
          onTap: () => onTap(),
          child: const TermOfServiceTextView(
            text: 'Term of Service',
            color: colorOptions,
          ),
        ),
      ],
    );
  }
}

class TermOfServiceTextView extends StatelessWidget {
  final String text;
  final Color color;

  const TermOfServiceTextView({
    Key? key,
    required this.text,
    this.color = colorGrey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: textRegular2x,
        color: color,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class TextFieldSectionView extends StatelessWidget {
  final RegionVO region;
  final Function(String) onNameChange;
  final Function onTapRegion;
  final Function(String) onPhoneNumberChange;
  final Function(String) onPasswordChange;

  const TextFieldSectionView({
    Key? key,
    required this.region,
    required this.onNameChange,
    required this.onTapRegion,
    required this.onPhoneNumberChange,
    required this.onPasswordChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextInputView(
          label: labelName,
          hint: hintName,
          onTextChange: (value) => onNameChange(value),
        ),
        const SizedBox(
          height: marginMedium3,
        ),
        RegionInputView(
          label: labelRegion,
          text: "${region.name} (${region.code})",
          onTap: () => onTapRegion(),
        ),
        const SizedBox(
          height: marginMedium3,
        ),
        TextInputView(
          label: labelPhone,
          hint: hintPhone,
          onTextChange: (value) => onPhoneNumberChange(value),
          inputType: TextInputType.phone,
        ),
        const SizedBox(
          height: marginMedium3,
        ),
        TextInputView(
          label: labelPassword,
          hint: hintPassword,
          onTextChange: (value) => onPasswordChange(value),
          isObscure: true,
        ),
        const SizedBox(
          height: marginMedium3,
        ),
      ],
    );
  }
}
