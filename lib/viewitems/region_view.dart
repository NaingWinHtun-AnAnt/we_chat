import 'package:flutter/material.dart';
import 'package:we_chat/data/vos/region_vo.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';

class RegionView extends StatelessWidget {
  final RegionVO? region;
  final Function(RegionVO?) onTap;

  const RegionView({
    Key? key,
    required this.region,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(region),
      child: Container(
        color: colorBlack,
        padding: const EdgeInsets.symmetric(
          horizontal: marginMedium3,
          vertical: marginMedium2,
        ),
        margin: const EdgeInsets.only(
          bottom: marginMedium,
        ),
        child: Row(
          children: [
            Text(
              region?.name ?? "-",
              style: const TextStyle(
                fontSize: textRegular3x,
                fontWeight: FontWeight.bold,
                color: colorWhite,
              ),
            ),
            const Spacer(),
            Text(
              region?.code ?? "-",
              style: const TextStyle(
                fontSize: textRegular,
                color: colorWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
