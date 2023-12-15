import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              children: [
                Text(
                  'MPS Tailor',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  height: 100,
                )
              ],
            ),
          ),
          DrawerListItem(
              icon: FontAwesomeIcons.home,
              title: 'Dashboard',
              onTap: () {
                // Handle home tap
                Navigator.pop(context); // Close the drawer
              }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(),
          ),
          DrawerListItem(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {
                // Handle settings tap
                Navigator.pop(context); // Close the drawer
              }),
          // Add more list items as needed
        ],
      ),
    );
  }
}

class DrawerListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerListItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
