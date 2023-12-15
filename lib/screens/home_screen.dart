import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mpstailor/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/dashboard_card.dart';
import '../widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Dashboard',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        actions: [
          Consumer<ThemeProvider>(builder: (context, data, child) {
            return IconButton(
              onPressed: () {
                data.changeTheme();
              },
              icon: FaIcon(
                data.darkTheme
                    ? FontAwesomeIcons.solidMoon
                    : FontAwesomeIcons.moon,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            );
          })
        ],
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: DashboardCard(
                    imageUrl: 'assets/images/bookorder.png',
                    name: 'Book Order',
                  )),
                  Expanded(
                      child: DashboardCard(
                    imageUrl: 'assets/images/ordertracker.png',
                    name: 'Order Tracker',
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: DashboardCard(
                    imageUrl: 'assets/images/customers.png',
                    name: 'Customers',
                  )),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
