import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/pages/home_page.dart';
import 'package:we_chat/persistence/hive_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// if not firebase services will not work
  await Firebase.initializeApp();

  await Hive.initFlutter();

  Hive.registerAdapter(UserVOAdapter());

  await Hive.openBox<UserVO>(boxNameUserVO);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
