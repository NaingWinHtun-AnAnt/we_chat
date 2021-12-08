import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/blocs/privacy_bloc.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/pages/email_verify_page.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/resources/strings.dart';
import 'package:we_chat/widgets/button_view.dart';

class PrivacyPage extends StatelessWidget {
  final UserVO? newUser;
  final File? chosenFile;

  const PrivacyPage({
    Key? key,
    required this.newUser,
    required this.chosenFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PrivacyBloc(),
      child: Scaffold(
        backgroundColor: colorBlack,
        appBar: AppBar(
          backgroundColor: colorBlack,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.close),
          ),
          centerTitle: true,
          elevation: 0.8,
          title: const Text(
            privacyPolicy,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(
                  marginMedium3,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Center(
                      child: Text(
                        privacyPolicy,
                        style: TextStyle(
                          color: colorWhite,
                          fontSize: textHeading1x,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: marginMedium2,
                    ),
                    Text(
                      "INTRODUCTION",
                      style: TextStyle(
                        color: colorWhite,
                        fontSize: textRegular3x,
                      ),
                    ),
                    SizedBox(
                      height: marginMedium,
                    ),
                    Text(
                      "Easily generate and manage a Terms and Conditions document that is professional, customizable from over 100 clauses, available in 9 languages, drafted by an international legal team and up to date with the main international legislations.Easily generate and manage a Terms and Conditions document that is professional, customizable from over 100 clauses, available in 9 languages, drafted by an international legal team and up to date with the main international legislations.Easily generate and manage a Terms and Conditions document that is professional, customizable from over 100 clauses, available in 9 languages, drafted by an international legal team and up to date with the main international legislations.Easily generate and manage a Terms and Conditions document that is professional, customizable from over 100 clauses, available in 9 languages, drafted by an international legal team and up to date with the main international legislations.Easily generate and manage a Terms and Conditions document that is professional, customizable from over 100 clauses, available in 9 languages, drafted by an international legal team and up to date with the main international legislations.Easily generate and manage a Terms and Conditions document that is professional, customizable from over 100 clauses, available in 9 languages, drafted by an international legal team and up to date with the main international legislations.Easily generate and manage a Terms and Conditions document that is professional, customizable from over 100 clauses, available in 9 languages, drafted by an international legal team and up to date with the main international legislations.Easily generate and manage a Terms and Conditions document that is professional, customizable from over 100 clauses, available in 9 languages, drafted by an international legal team and up to date with the main international legislations.",
                      style: TextStyle(
                        color: colorWhite,
                        fontSize: textRegular2x,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: marginLarge,
                ),
                color: colorBlack,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Consumer(
                        builder: (BuildContext context, PrivacyBloc bloc,
                                Widget? child) =>
                            PrivacyView(
                          agree: bloc.isAgreeToPrivacy,
                          onTapAgree: (value) =>
                              bloc.onTapAgreeToPrivacy(value),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: marginLarge,
                    ),
                    Center(
                      child: Consumer(
                        builder: (BuildContext context, PrivacyBloc bloc,
                                Widget? child) =>
                            ButtonView(
                          text: next,
                          backgroundColor: bloc.isAgreeToPrivacy
                              ? colorPrimary
                              : colorBlack2,
                          onTap: () => bloc.isAgreeToPrivacy
                              ? _navigateToEmailVerifyPage(context)
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToEmailVerifyPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => EmailVerifyPage(
          newUser: newUser,
          chosenFile: chosenFile,
        ),
      ),
    );
  }
}

class PrivacyView extends StatelessWidget {
  final bool agree;
  final Function(bool) onTapAgree;

  const PrivacyView({
    Key? key,
    required this.agree,
    required this.onTapAgree,
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
        const Text(
          "I have read and accept the above terms",
          style: TextStyle(
            color: colorWhite,
          ),
        ),
      ],
    );
  }
}
