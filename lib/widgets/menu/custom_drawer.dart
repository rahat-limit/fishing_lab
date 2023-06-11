import 'package:fishing_lab/constants/colors.dart';
import 'package:fishing_lab/screens/account_screen.dart';
import 'package:fishing_lab/screens/chat_screen.dart';
import 'package:fishing_lab/screens/home_screen.dart';
import 'package:fishing_lab/screens/log_screen.dart';
import 'package:fishing_lab/screens/points_screen.dart';
import 'package:fishing_lab/screens/tips_screen.dart';
import 'package:fishing_lab/widgets/menu/drawer_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 150,
              color: scaffoldColor,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only(left: 25, bottom: 20),
              child: const Text(
                'fishing lab',
                style: TextStyle(
                    fontSize: 34, fontFamily: 'BNR', color: mainColor),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const DrawerItem(
              title: 'Home',
              icon: CupertinoIcons.home,
              page: HomeScreen.route,
            ),
            const DrawerItem(
              title: 'Chat',
              icon: CupertinoIcons.chat_bubble_2,
              page: ChatScreen.route,
            ),
            const DrawerItem(
              title: 'Account',
              icon: CupertinoIcons.person,
              page: AccountScreen.route,
            ),
            const DrawerItem(
              title: 'Points',
              icon: CupertinoIcons.location_solid,
              page: PointsScreen.route,
            ),
            const DrawerItem(
              title: 'Catch Log',
              icon: CupertinoIcons.bookmark,
              page: LogScreen.route,
            ),
            const DrawerItem(
              title: 'Tips',
              icon: CupertinoIcons.exclamationmark_circle,
              page: TipsScreen.route,
            ),
          ],
        )),
      ),
    );
  }
}
