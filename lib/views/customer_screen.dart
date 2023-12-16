import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:mpstailor/models/customer.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';
import 'add_customer.dart';

class CustomerPage extends StatelessWidget {
  CustomerPage({Key? key}) : super(key: key);
  Box customer = Hive.box<Customer>('customers');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Customers',
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ValueListenableBuilder(
          valueListenable: customer.listenable(),
          //important Box box
          builder: (context, Box box, widget) {
            if (box.isEmpty) {
              return Center(child: Text('No customers'));
            } else {
              return ListView.builder(
                shrinkWrap: true,
                reverse: true,
                itemCount: box.length,
                itemBuilder: (context, index) {
                  Customer customer = box.getAt(index);

                  if (customer != null) {
                    return Card(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/customer.png',
                          width: 40,
                          height: 40,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            customer.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        subtitle: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Row(
                                children: [
                                  Icon(Icons.phone_android),
                                  Text(
                                    customer.mobile,
                                    style: TextStyle(fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Row(
                                children: [
                                  Icon(Icons.location_pin),
                                  Text(
                                    customer.address,
                                    style: TextStyle(fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddCustomer(
                                customerId: customer.id,
                              ),
                            ));
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox
                        .shrink(); // Return an empty widget if the customer is null
                  }
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddCustomer(),
            ));
          },
          child: Icon(Icons.add)),
    );
  }
}
