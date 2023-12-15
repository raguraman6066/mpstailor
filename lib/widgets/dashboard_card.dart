import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String imageUrl;
  final String name;

  DashboardCard({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              child: Image.asset(
                imageUrl,
                width: 80,
                height: 100,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Text(
                name,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSecondary),
              ),
            )
          ],
        ),
      ),
    );
  }
}
