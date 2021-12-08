import 'package:flutter/material.dart';
import 'package:we_chat/data/dummy_data.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/resources/strings.dart';
import 'package:we_chat/viewitems/region_view.dart';
import 'package:we_chat/widgets/vertical_list_view.dart';

class RegionPage extends StatelessWidget {
  const RegionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      appBar: AppBar(
        elevation: 0.8,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
        ),
        backgroundColor: colorBlack,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(region),
      ),
      body: VerticalListView(
        itemCount: dummyRegionList.length,
        padding: const EdgeInsets.only(top: marginMedium),
        itemBuilder: (BuildContext context, int index) => RegionView(
          region: dummyRegionList[index],
          onTap: (region) => Navigator.of(context).pop(region),
        ),
      ),
    );
  }
}
