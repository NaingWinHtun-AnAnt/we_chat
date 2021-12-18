import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/data/models/auth_model.dart';
import 'package:we_chat/data/models/auth_model_impl.dart';
import 'package:we_chat/fcm/fcm_service.dart';
import 'package:we_chat/pages/home_page.dart';
import 'package:we_chat/pages/start_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// if not firebase services will not work
  await Firebase.initializeApp();
  FCMService().listenForMessages();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthModel _mAuthModel = AuthModelImpl();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _mAuthModel.isLogin() ? const HomePage() : const StartPage(),
    );
  }
}
