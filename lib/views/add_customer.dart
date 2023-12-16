import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/customer.dart';

class AddCustomer extends StatefulWidget {
  final String? customerId;
  const AddCustomer({Key? key, this.customerId}) : super(key: key);

  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final _formKey = GlobalKey<FormState>();
  String _name = '', _mobile = '', _address = '';
  Box box = Hive.box<Customer>('customers');
  getCustomer() {
    if (widget.customerId != null) {
      Customer customer = box.get(int.parse(widget.customerId!));
      setState(() {
        _name = customer.name;
        _mobile = customer.mobile;
        _address = customer.address;
      });
    }
  }

  @override
  void initState() {
    getCustomer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Add Customer',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: _name,
                maxLength: 25,
                decoration: InputDecoration(
                    labelText: 'Name', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue: _mobile,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Mobile', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a mobile number';
                  }
                  return null;
                },
                onSaved: (value) => _mobile = value!,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue: _address,
                maxLength: 25,
                decoration: InputDecoration(
                    labelText: 'City', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
                onSaved: (value) => _address = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _submitForm();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Generate a random 6-digit order ID
      if (widget.customerId == null) {
        final random = Random();
        final customerId = random.nextInt(900000) +
            100000; // Random number between 100000 and 999999

        // Create a new Customer object with the entered data
        Customer customer = Customer(
            name: _name,
            mobile: _mobile,
            address: _address,
            id: customerId.toString());

        // Save the customer to Hive
        _saveCustomerToHive(customerId, customer);
      } else {
        Customer customer = Customer(
            name: _name,
            mobile: _mobile,
            address: _address,
            id: widget.customerId!);

        // Save the customer to Hive
        _saveCustomerToHive(int.parse(widget.customerId!), customer);
      }

      // Clear the form
      _formKey.currentState!.reset();
      Navigator.pop(context);
    }
  }

  void _saveCustomerToHive(int id, Customer customer) async {
    // Open the Hive box for customers
    Box<Customer> customerBox = await Hive.box<Customer>('customers');

    // Save the modified customer to Hive
    await customerBox.put(id, customer);
  }
}
