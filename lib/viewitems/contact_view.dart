import 'package:flutter/material.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/widgets/image_view.dart';

class ContactView extends StatelessWidget {
  final UserVO? contact;
  final Function(String) onTap;

  const ContactView({
    Key? key,
    required this.onTap,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap("${contact?.id ?? ""}"),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: marginMedium2,
        ),
        padding: const EdgeInsets.only(
          bottom: marginMedium2,
        ),
        child: Row(
          children: [
            ImageView(
              radius: contactImageSize / 2,
              height: contactImageSize,
              width: contactImageSize,
              imageUrl: contact?.imagePath ?? "-",
            ),
            const SizedBox(
              width: marginMedium2,
            ),
            ContactInfoView(
              name: contact?.userName,
              companyOrganization: contact?.organization,
            ),
          ],
        ),
      ),
    );
  }
}

class ContactInfoView extends StatelessWidget {
  final String? name;
  final String? companyOrganization;

  const ContactInfoView({
    Key? key,
    required this.name,
    required this.companyOrganization,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name ?? "-",
          style: const TextStyle(
            fontSize: textRegular2x,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: marginSmall,
        ),
        Text(
          companyOrganization ?? "-",
        ),
      ],
    );
  }
}
