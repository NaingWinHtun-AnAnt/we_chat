import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:we_chat/pages/login_page.dart';
import 'package:we_chat/pages/sign_up_page.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/resources/strings.dart';
import 'package:we_chat/widgets/button_view.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImageView(),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomSectionView(
              onTapLogIn: () => _navigateToLoginPage(context),
              onTapSignUp: () => _showSignUpOptionBottomSheet(context),
            ),
          ),
        ],
      ),
    );
  }

  void _showSignUpOptionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => SignInBottomSheetSectionView(
        onTapViaMobile: () => _navigateToSignUpPage(context),
      ),
    );
  }

  void _navigateToLoginPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginPage(),
      ),
    );
  }

  void _navigateToSignUpPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const SignUpPage(),
      ),
    );
  }
}

class SignInBottomSheetSectionView extends StatelessWidget {
  final Function onTapViaMobile;

  const SignInBottomSheetSectionView({
    Key? key,
    required this.onTapViaMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: colorBlack2,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            16,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SignInOptionView(
            text: signUpViaMobile,
            onTap: () {
              Navigator.of(context).pop();
              onTapViaMobile();
            },
          ),
          const Divider(
            color: colorGrey,
          ),
          SignInOptionView(
            text: signUpViaFacebook,
            onTap: () {},
          ),
          Container(
            color: colorBlack,
            height: marginMedium,
          ),
          SignInOptionView(
            text: cancel,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class SignInOptionView extends StatelessWidget {
  final String text;
  final Function onTap;

  const SignInOptionView({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: double.infinity,
        color: colorBlack2,
        padding: const EdgeInsets.symmetric(
          vertical: marginMedium2,
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: colorWhite,
              fontSize: textHeading1x,
            ),
          ),
        ),
      ),
    );
  }
}

class BottomSectionView extends StatelessWidget {
  final Function onTapLogIn;
  final Function onTapSignUp;

  const BottomSectionView({
    Key? key,
    required this.onTapLogIn,
    required this.onTapSignUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: marginMedium3,
        right: marginMedium3,
        bottom: marginMedium3,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ButtonView(
            text: labelLogin,
            backgroundColor: colorPrimary,
            onTap: () => onTapLogIn(),
          ),
          ButtonView(
            text: signUp,
            backgroundColor: colorBlack,
            onTap: () => onTapSignUp(),
          ),
        ],
      ),
    );
  }
}

class BackgroundImageView extends StatelessWidget {
  const BackgroundImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "lib/assets/we_chat_bg.jpg",
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
