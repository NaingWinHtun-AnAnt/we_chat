import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/blocs/tos_bloc.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/pages/privacy_page.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/resources/strings.dart';
import 'package:we_chat/widgets/button_view.dart';

class TermOfServicePage extends StatelessWidget {
  final bool showActions;
  final UserVO? newUser;
  final File? chosenFile;

  const TermOfServicePage({
    Key? key,
    this.showActions = false,
    required this.newUser,
    required this.chosenFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TOSBloc(),
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
            termOfService,
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
                        termOfService,
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
            Visibility(
              visible: showActions,
              child: Align(
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
                          builder: (BuildContext context, TOSBloc bloc,
                                  Widget? child) =>
                              TOSView(
                            agree: bloc.isAgreeToTOS,
                            onTapAgree: (value) => bloc.onTapAgreeToTOS(value),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: marginLarge,
                      ),
                      Center(
                        child: Consumer(
                          builder: (BuildContext context, TOSBloc bloc,
                                  Widget? child) =>
                              ButtonView(
                            text: next,
                            backgroundColor:
                                bloc.isAgreeToTOS ? colorPrimary : colorBlack2,
                            onTap: () => bloc.isAgreeToTOS
                                ? _navigateToPrivacyPage(context)
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPrivacyPage(BuildContext context) {
    if (newUser != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => PrivacyPage(
            newUser: newUser,
            chosenFile: chosenFile,
          ),
        ),
      );
    }
  }
}

class TOSView extends StatelessWidget {
  final bool agree;
  final Function(bool) onTapAgree;

  const TOSView({
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
