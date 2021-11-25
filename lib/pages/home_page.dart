import 'package:flutter/material.dart';
import 'package:we_chat/pages/contact_page.dart';
import 'package:we_chat/pages/discover_page.dart';
import 'package:we_chat/pages/my_profile_page.dart';
import 'package:we_chat/pages/we_chat_page.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const WeChatPage(),
    const ContactPage(),
    const DiscoverPage(),
    const MyProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _onTapNavigationBarItem(index),
        selectedItemColor: colorPrimary,
        unselectedItemColor: colorUnselectNavigationItem,
        unselectedLabelStyle: const TextStyle(
          color: colorUnselectNavigationItem,
        ),
        backgroundColor: colorWhite,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_rounded,
            ),
            label: weChat,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.contacts,
            ),
            label: contacts,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group_work,
            ),
            label: discover,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: me,
          ),
        ],
      ),
    );
  }

  void _onTapNavigationBarItem(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
