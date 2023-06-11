import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String page;
  const DrawerItem({
    super.key,
    required this.title,
    required this.icon,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        children: [
          ListTile(
              minLeadingWidth: 30,
              title: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'MM',
                  color: Colors.black87,
                ),
              ),
              leading: Icon(
                icon,
                size: 24,
                color: Colors.black54,
              ),
              trailing: const Icon(
                CupertinoIcons.right_chevron,
                size: 20,
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, page);
              }),
          const Divider()
        ],
      ),
    );
  }
}
