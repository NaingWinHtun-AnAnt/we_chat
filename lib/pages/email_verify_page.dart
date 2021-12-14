import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/blocs/email_verify_bloc.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/pages/login_page.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/resources/strings.dart';
import 'package:we_chat/utils/extensions.dart';
import 'package:we_chat/widgets/button_view.dart';
import 'package:we_chat/widgets/close_button_view.dart';
import 'package:we_chat/widgets/loading_view.dart';
import 'package:we_chat/widgets/text_input_view.dart';

class EmailVerifyPage extends StatelessWidget {
  final UserVO? newUser;
  final File? chosenFile;

  const EmailVerifyPage({
    Key? key,
    required this.newUser,
    required this.chosenFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => EmailVerifyBloc(newUser, chosenFile),
      child: Scaffold(
        backgroundColor: colorBlack,
        body: Selector(
          selector: (BuildContext context, EmailVerifyBloc bloc) =>
              bloc.isLoading,
          builder: (BuildContext context, bool isLoading, Widget? child) =>
              Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CloseButtonView(
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(
                      height: marginXXLarge,
                    ),
                    const Center(
                      child: Text(
                        emailVerification,
                        style: TextStyle(
                          color: colorWhite,
                          fontSize: textRegular3x,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: marginXLarge,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: marginMedium3,
                      ),
                      child: const Text(
                        emailVerificationInfo,
                        style: TextStyle(
                          color: colorWhite,
                          fontSize: textRegular,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: marginMedium,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: marginMedium3,
                      ),
                      child: const Divider(
                        color: colorGrey,
                      ),
                    ),
                    const SizedBox(
                      height: marginMedium,
                    ),
                    Consumer(
                      builder: (BuildContext context, EmailVerifyBloc bloc,
                              Widget? child) =>
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: marginMedium3,
                            ),
                            child: TextInputView(
                        label: labelEmail,
                        hint: hintEmail,
                        onTextChange: (value) => bloc.onEmailChange(value),
                      ),
                          ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                    ),
                    Center(
                      child: Consumer(
                        builder: (BuildContext context, EmailVerifyBloc bloc,
                                Widget? child) =>
                            ButtonView(
                          text: ok,
                          onTap: () => bloc.email != null
                              ? bloc
                                  .onTapOkToRegisterNewUser()
                                  .then(
                                    (value) => _navigateToLoginPage(context),
                                  )
                                  .catchError(
                                    (error) => showSnackBarWithMessage(
                                      context,
                                      error.toString(),
                                    ),
                                  )
                              : null,
                          backgroundColor:
                              bloc.email != null ? colorPrimary : colorBlack2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isLoading,
                child: const LoadingView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToLoginPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginPage(),
      ),
    );
  }
}
