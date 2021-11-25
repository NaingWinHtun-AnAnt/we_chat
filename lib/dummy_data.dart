import 'dart:math';

import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/network/firebase_constants.dart';
import 'package:we_chat/resources/strings.dart';

/// user
final UserVO dummyUser = UserVO(
  id: myId,
  userName: "User ${Random().nextInt(100)}",
  imagePath: dummyNetworkImage,
  organization: "Blue Mont/Org${Random().nextInt(100)}",
);
