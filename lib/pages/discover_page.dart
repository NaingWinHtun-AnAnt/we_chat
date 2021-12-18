import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/blocs/discover_bloc.dart';
import 'package:we_chat/pages/moment_page.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/resources/strings.dart';
import 'package:we_chat/widgets/horizontal_list_view.dart';
import 'package:we_chat/widgets/image_view.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => DiscoverBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorPrimary,
          centerTitle: true,
          title: const Text(discover),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              DiscoverMomentSectionView(
                onTap: () => _navigateToMomentPage(context),
              ),
              const SizedBox(
                height: marginMedium,
              ),
              const DiscoverFilterGridView(),
              const SizedBox(
                height: marginMedium,
              ),
              const GameSectionView(),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToMomentPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const MomentPage(),
      ),
    );
  }
}

class GameSectionView extends StatelessWidget {
  const GameSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: marginMedium2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: marginMedium2,
            ),
            child: DiscoverLabelTextView(
              text: games,
            ),
          ),
          const SizedBox(
            height: marginMedium2,
          ),
          HorizontalListView(
            padding: const EdgeInsets.only(
              left: marginMedium2,
            ),
            itemCount: 6,
            height: gameListHeight,
            itemBuilder: (BuildContext context, int index) =>
                const SuggestGameView(),
          ),
        ],
      ),
    );
  }
}

class DiscoverFilterGridView extends StatelessWidget {
  const DiscoverFilterGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            IconAndTextView(
              icon: Icons.qr_code,
              text: "Scan QrCode",
            ),
            SizedBox(
              height: marginMedium3,
            ),
            IconAndTextView(
              icon: Icons.local_drink_rounded,
              text: "Drift Bottles",
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            IconAndTextView(
              icon: Icons.aod_rounded,
              text: "Shake",
            ),
            SizedBox(
              height: marginMedium3,
            ),
            IconAndTextView(
              icon: Icons.near_me_rounded,
              text: "People Near Me",
            ),
          ],
        ),
      ],
    );
  }
}

class IconAndTextView extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconAndTextView({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: colorGrey3,
        ),
        const SizedBox(
          width: marginMedium,
        ),
        Text(
          text,
          style: const TextStyle(color: colorGrey3),
        ),
      ],
    );
  }
}

class DiscoverMomentSectionView extends StatelessWidget {
  final Function onTap;

  const DiscoverMomentSectionView({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Padding(
            padding: EdgeInsets.all(
              marginMedium2,
            ),
            child: LabelAndIconHorizontalView(),
          ),
          DiscoverMomentView(),
          SizedBox(
            height: marginMedium2,
          ),
        ],
      ),
    );
  }
}

class DiscoverMomentView extends StatelessWidget {
  const DiscoverMomentView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: marginMedium2,
      ),
      child: Row(
        children: [
          const ImageView(
            imageUrl: dummyNetworkImage,
            radius: discoverMomentImageSize / 2,
            width: discoverMomentImageSize,
            height: discoverMomentImageSize,
          ),
          const SizedBox(
            width: marginMedium2,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Contact Name",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: textRegular2x,
                        color: colorGrey,
                      ),
                    ),
                    Text(
                      "12 mins",
                      style: TextStyle(
                        color: colorGrey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: marginMedium,
                ),
                const Text(
                  "This word has two main meanings. The first has to do with being pleased and satisfied (feeling content) or making someone else feel happy and at peace with",
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: textRegular,
                    color: colorGrey2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LabelAndIconHorizontalView extends StatelessWidget {
  const LabelAndIconHorizontalView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        DiscoverLabelTextView(
          text: moments,
        ),
        Icon(
          Icons.arrow_forward_ios_outlined,
          size: forwardIconSize,
        ),
      ],
    );
  }
}

class DiscoverLabelTextView extends StatelessWidget {
  final String? text;

  const DiscoverLabelTextView({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "-",
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: textRegular2x,
        color: colorGrey,
      ),
    );
  }
}

class SuggestGameView extends StatelessWidget {
  const SuggestGameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: marginMedium2,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          ImageView(
            imageUrl: dummyNetworkImage,
            width: gameImageSize,
            height: gameImageSize,
            radius: gameImageSize / 2,
          ),
          SizedBox(
            height: marginMedium,
          ),
          Text(
            "Game One",
            style: TextStyle(
              color: colorGrey2,
              fontSize: textRegular,
            ),
          ),
        ],
      ),
    );
  }
}
