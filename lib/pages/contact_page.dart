import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/blocs/contact_bloc.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/pages/contact_profile_page.dart';
import 'package:we_chat/pages/qr_page.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/resources/strings.dart';
import 'package:we_chat/viewitems/contact_view.dart';
import 'package:we_chat/widgets/icon_and_label_view.dart';
import 'package:we_chat/widgets/vertical_list_view.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ContactBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorPrimary,
          centerTitle: true,
          title: const Text(contacts),
          actions: const [
            Icon(Icons.add),
            SizedBox(
              width: marginMedium2,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: marginMedium2,
              ),
              const SearchView(),
              const Divider(
                color: colorGrey,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: marginMedium2,
                ),
                child: HorizontalContactSuggestionView(),
              ),
              const Divider(
                color: colorGrey,
              ),
              const LabelSectionView(),
              const Divider(
                color: colorGrey,
              ),
              Selector(
                selector: (
                  BuildContext context,
                  ContactBloc bloc,
                ) =>
                    bloc.contacts,
                builder: (
                  BuildContext context,
                  List<UserVO>? contactList,
                  Widget? child,
                ) =>
                    VerticalListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: contactList?.length ?? 0,
                  padding: const EdgeInsets.only(
                    top: marginMedium2,
                  ),
                  itemBuilder: (BuildContext context, int index) => ContactView(
                    contact: contactList?[index],
                    onTap: (userId) => _navigateToContactProfilePage(
                      context,
                      userId,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToContactProfilePage(BuildContext context, String userId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ContactProfilePage(
          userId: userId,
        ),
      ),
    );
  }
}

class LabelSectionView extends StatelessWidget {
  const LabelSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: marginMedium,
      ),
      child: Row(
        children: const [
          SizedBox(
            width: contactImageSize + marginXLarge,
          ),
          Text(
            "A",
            style: TextStyle(
              fontSize: textRegular3x,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          Text(
            "LABEL",
            style: TextStyle(
              fontSize: textRegular,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            width: marginMedium2,
          ),
        ],
      ),
    );
  }
}

class HorizontalContactSuggestionView extends StatelessWidget {
  const HorizontalContactSuggestionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconAndLabelView(
          icon: Icons.add,
          text: newFriends,
          onTap: () => _navigateToQrPage(context),
        ),
        const VerticalDividerView(),
        IconAndLabelView(
          icon: Icons.group,
          text: groupChat,
          onTap: () {},
        ),
        const VerticalDividerView(),
        IconAndLabelView(
          icon: Icons.tag,
          text: tags,
          onTap: () {},
        ),
        const VerticalDividerView(),
        IconAndLabelView(
          icon: Icons.account_box_rounded,
          text: officialAccount,
          onTap: () {},
        ),
      ],
    );
  }

  void _navigateToQrPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const QrPage(),
      ),
    );
  }
}

class VerticalDividerView extends StatelessWidget {
  const VerticalDividerView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: contactVerticalDividerHeight,
      child: VerticalDivider(
        width: 2,
        color: colorGrey2,
      ),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: marginMedium2,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: marginCardMedium2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(searchViewBorderRadius),
        color: colorWhite,
      ),
      child: const Center(
        child: Text(
          search,
          style: TextStyle(
            fontSize: textRegular2x,
            fontWeight: FontWeight.w600,
            color: colorGrey2,
          ),
        ),
      ),
    );
  }
}
