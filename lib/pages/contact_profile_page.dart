import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/blocs/contact_profile_bloc.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/resources/strings.dart';
import 'package:we_chat/widgets/horizontal_list_view.dart';
import 'package:we_chat/widgets/image_view.dart';
import 'package:we_chat/widgets/leading_view.dart';
import 'package:we_chat/widgets/round_corner_button_view.dart';

class ContactProfilePage extends StatelessWidget {
  final String userId;

  const ContactProfilePage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ContactProfileBloc(userId),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorPrimary,
          leadingWidth: leadingWidth,
          leading: LeadingView(
            text: contacts,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: const Text(profile),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ContactInfoView(),
              const ContactDetailSectionView(),
              const SizedBox(
                height: marginMedium,
              ),
              Consumer(
                builder: (BuildContext context, value, Widget? child) =>
                    RoundCornerButtonView(
                  text: messages,
                  onTap: () {},
                ),
              ),
              const SizedBox(
                height: marginMedium,
              ),
              RoundCornerButtonView(
                text: freeCall,
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

class ContactDetailSectionView extends StatelessWidget {
  const ContactDetailSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ContactDetailView(
          attribute: name,
          value: Text(
            "Contact Name",
          ),
        ),
        const SizedBox(
          height: marginMedium,
        ),
        const ContactDetailView(
          attribute: weChatId,
          value: Text("ID number"),
        ),
        const SizedBox(
          height: marginMedium,
        ),
        ContactDetailView(
          attribute: tags,
          value: Flexible(
            child: Wrap(
                children: List.generate(
              5,
              (index) => TagView(
                text: "tags $index",
              ),
            )),
          ),
        ),
        const ContactDetailView(
          attribute: region,
          value: Text("Country/Region"),
        ),
        const SizedBox(
          height: marginMedium,
        ),
        const AlbumView(),
        const SizedBox(
          height: marginMedium,
        ),
        const ContactDetailView(
          attribute: from,
          value: Text(
            "Where did I add this friend?",
          ),
        ),
      ],
    );
  }
}

class TagView extends StatelessWidget {
  final String? text;

  const TagView({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: marginMedium,
        bottom: marginMedium,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: marginMedium,
        vertical: marginSmall,
      ),
      decoration: BoxDecoration(
        color: colorChatControl,
        borderRadius: BorderRadius.circular(buttonBorderRadius),
      ),
      child: Text(
        text ?? "-",
      ),
    );
  }
}

class AlbumView extends StatelessWidget {
  const AlbumView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: contactProfileImageSize * 1.5,
          child: AttributeTextView(
            attribute: album,
          ),
        ),
        const SizedBox(
          height: marginMedium,
        ),
        HorizontalListView(
          padding: const EdgeInsets.only(
            left: marginMedium,
          ),
          itemCount: 10,
          height: 80,
          itemBuilder: (BuildContext context, int index) => Container(
            margin: const EdgeInsets.only(
              right: marginMedium,
            ),
            child: const ImageView(
              imageUrl: dummyNetworkImage,
              width: 80,
              height: 80,
            ),
          ),
        ),
      ],
    );
  }
}

class ContactDetailView extends StatelessWidget {
  final String? attribute;
  final Widget? value;

  const ContactDetailView({
    Key? key,
    required this.attribute,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: contactProfileImageSize * 1.5,
          child: AttributeTextView(
            attribute: attribute,
          ),
        ),
        const SizedBox(
          width: marginMedium2,
        ),
        Visibility(
          visible: value != null,
          child: value ?? Container(),
        ),
      ],
    );
  }
}

class AttributeTextView extends StatelessWidget {
  const AttributeTextView({
    Key? key,
    required this.attribute,
  }) : super(key: key);

  final String? attribute;

  @override
  Widget build(BuildContext context) {
    return Text(
      attribute ?? "-",
      textAlign: TextAlign.end,
      style: const TextStyle(
        fontSize: textRegular,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class ContactInfoView extends StatelessWidget {
  const ContactInfoView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, ContactProfileBloc bloc, Widget? child) =>
          Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.24,
          ),
          Container(
            color: colorGrey3,
            height: MediaQuery.of(context).size.height * 0.12,
            child: const ImageView(
              height: double.infinity,
              width: double.infinity,
              imageUrl: dummyNetworkImage,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin:
                    const EdgeInsets.only(left: contactProfileImageSize / 2),
                child: ImageView(
                  radius: contactProfileImageSize,
                  width: contactProfileImageSize,
                  imageUrl: bloc.user?.imagePath ?? "-",
                  height: contactProfileImageSize,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(
                  left: contactProfileImageSize * 1.7,
                ),
                padding: const EdgeInsets.only(
                  top: contactProfileImageSize * 1.2,
                  right: marginMedium2,
                ),
                child: NameAndRecentActivityTextView(
                  contactName: bloc.user?.userName,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NameAndRecentActivityTextView extends StatelessWidget {
  final String? contactName;

  const NameAndRecentActivityTextView({
    Key? key,
    required this.contactName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactName ?? "-",
          style: const TextStyle(
            fontSize: textRegular2x,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: marginMedium,
        ),
        const Text(
          "A long text label about what user is doing in recent days.",
          maxLines: 2,
        ),
      ],
    );
  }
}
