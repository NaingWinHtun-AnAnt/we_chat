import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/blocs/my_profile_bloc.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/resources/strings.dart';
import 'package:we_chat/widgets/icon_and_label_view.dart';
import 'package:we_chat/widgets/image_view.dart';
import 'package:we_chat/widgets/round_corner_button_view.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MyProfileBloc(),
      child: Scaffold(
        backgroundColor: colorWhite,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Selector(
                selector: (BuildContext context, MyProfileBloc bloc) =>
                    bloc.user,
                builder: (
                  BuildContext context,
                  UserVO? mUser,
                  Widget? child,
                ) =>
                    UserInfoSectionView(
                  user: mUser,
                ),
              ),
              const UserDataView(),
              const SizedBox(
                height: marginMedium2,
              ),
              RoundCornerButtonView(
                text: logOut,
                isGhostButton: true,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserDataView extends StatelessWidget {
  const UserDataView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removeViewPadding(
      context: context,
      removeTop: true,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        children: List.generate(
          6,
          (index) => Container(
            decoration: BoxDecoration(
              border: Border.all(color: colorGrey, width: 0.4),
            ),
            child: Center(
              child: IconAndLabelView(
                icon: Icons.eleven_mp,
                text: "text",
                onTap: () {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UserInfoSectionView extends StatelessWidget {
  final UserVO? user;

  const UserInfoSectionView({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageView(
          imageUrl: dummyNetworkImage,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.225,
        ),
        UserInfoAndForwardIconView(
          user: user,
        ),
        const ProfileImageView(
          imageUrl: dummyNetworkImage,
        ),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.38,
          child: const Align(
            alignment: Alignment.bottomCenter,
            child: RecentActivityTextView(),
          ),
        ),
      ],
    );
  }
}

class RecentActivityTextView extends StatelessWidget {
  const RecentActivityTextView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: marginXXLarge,
        vertical: marginMedium2,
      ),
      child: Text(
        "A long text label about what user is doing in recent days.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: textRegular2x,
        ),
      ),
    );
  }
}

class UserInfoAndForwardIconView extends StatelessWidget {
  final UserVO? user;

  const UserInfoAndForwardIconView({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: marginMedium2,
        horizontal: marginMedium2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: forwardIconSize,
          ),
          const Spacer(),
          UserNameAndIdView(
            userName: user?.userName,
            id: user?.id,
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: forwardIconSize,
          ),
        ],
      ),
    );
  }
}

class UserNameAndIdView extends StatelessWidget {
  final String? userName;
  final int? id;

  const UserNameAndIdView({
    Key? key,
    required this.userName,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          userName ?? "-",
          style: const TextStyle(
            fontSize: textRegular2x,
            color: colorBlack,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: marginSmall,
        ),
        Text(
          "${id ?? "-"}",
          style: const TextStyle(
            fontSize: textRegular,
            fontWeight: FontWeight.w700,
            color: colorGrey2,
          ),
        ),
      ],
    );
  }
}

class ProfileImageView extends StatelessWidget {
  final String imageUrl;

  const ProfileImageView({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (MediaQuery.of(context).size.height * 0.225) -
          ((profileImageSize / 2) + marginMedium2),
      left: (MediaQuery.of(context).size.width - profileImageSize) / 2,
      child: Container(
        width: profileImageSize + marginMedium2,
        height: profileImageSize + marginMedium2,
        padding: const EdgeInsets.all(profileImagePadding),
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.circular(
            (profileImageSize + marginMedium2) / 2,
          ),
        ),
        child: ImageView(
          imageUrl: imageUrl,
          width: profileImageSize,
          radius: profileImageSize / 2,
          height: profileImageSize,
        ),
      ),
    );
  }
}
