import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/blocs/login_bloc.dart';
import 'package:we_chat/data/vos/region_vo.dart';
import 'package:we_chat/pages/home_page.dart';
import 'package:we_chat/pages/region_page.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/resources/strings.dart';
import 'package:we_chat/utils/extensions.dart';
import 'package:we_chat/widgets/button_view.dart';
import 'package:we_chat/widgets/close_button_view.dart';
import 'package:we_chat/widgets/header_text_view.dart';
import 'package:we_chat/widgets/loading_view.dart';
import 'package:we_chat/widgets/region_input_view.dart';
import 'package:we_chat/widgets/text_input_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LoginBloc(),
      child: Scaffold(
        backgroundColor: colorBlack,
        body: Consumer(
          builder: (BuildContext context, LoginBloc bloc, Widget? child) =>
              Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    CloseButtonView(
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(
                      height: marginXXLarge,
                    ),
                    const HeaderTextView(text: loginViaMobileNumber),
                    const SizedBox(
                      height: marginXXLarge,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: marginMedium3,
                      ),
                      child: LoginTextFieldSectionView(
                        selectedRegion:
                            "${bloc.region.name} (${bloc.region.code})",
                        onPasswordChange: (value) =>
                            bloc.onPasswordChanged(value),
                        onEmailChange: (value) => bloc.onEmailChanged(value),
                        onRegionChange: () => _navigateToRegionPage(context),
                      ),
                    ),
                    const SizedBox(
                      height: marginMedium2,
                    ),
                    const OtherLoginOptionTextView(),
                    const SizedBox(
                      height: marginXLarge,
                    ),
                    ButtonView(
                      text: next,
                      backgroundColor: colorPrimary,
                      onTap: () => bloc
                          .onTapLogin()
                          .then(
                            (value) => _navigateToHomePage(context),
                          )
                          .catchError(
                            (error) => showSnackBarWithMessage(
                              context,
                              error.toString(),
                            ),
                          ),
                    ),
                    const SizedBox(
                      height: 388,
                    ),
                    const OptionsTextSectionView(),
                  ],
                ),
              ),
              Visibility(
                visible: bloc.isLoading,
                child: const LoadingView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToRegionPage(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (BuildContext context) => const RegionPage(),
          ),
        )
        .then(
          (value) => bloc.onRegionChanged(value as RegionVO),
        );
  }

  void _navigateToHomePage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const HomePage(),
      ),
    );
  }
}

class OptionsTextSectionView extends StatelessWidget {
  const OptionsTextSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        OptionTextView(
          text: unableToLogIn,
        ),
        SizedBox(
          width: marginMedium3,
        ),
        OptionTextView(
          text: moreOptions,
        ),
      ],
    );
  }
}

class OptionTextView extends StatelessWidget {
  final String text;

  const OptionTextView({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: colorOptions,
        fontSize: textRegular2x,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class OtherLoginOptionTextView extends StatelessWidget {
  const OtherLoginOptionTextView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: marginMedium3,
      ),
      child: const Text(
        otherLoginOptions,
        style: TextStyle(
          fontSize: textRegular3x,
          color: colorOptions,
        ),
      ),
    );
  }
}

class LoginTextFieldSectionView extends StatelessWidget {
  final String selectedRegion;
  final Function onRegionChange;
  final Function(String) onEmailChange;
  final Function(String) onPasswordChange;

  const LoginTextFieldSectionView({
    Key? key,
    required this.selectedRegion,
    required this.onRegionChange,
    required this.onEmailChange,
    required this.onPasswordChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RegionInputView(
          label: labelRegion,
          text: selectedRegion,
          onTap: () => onRegionChange(),
        ),
        const SizedBox(
          height: marginXLarge,
        ),
        TextInputView(
          label: labelEmail,
          hint: hintEmail,
          onTextChange: (value) => onEmailChange(value),
        ),
        const SizedBox(
          height: marginXLarge,
        ),
        TextInputView(
          label: labelPassword,
          hint: hintPassword,
          onTextChange: (value) => onPasswordChange(value),
          isObscure: true,
        ),
      ],
    );
  }
}
