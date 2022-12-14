import 'package:financial_app/design_sys/sizes.dart';
import 'package:flutter/material.dart';

class PendingCard extends StatelessWidget {
  const PendingCard({
    Key? key,
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.mediumSpace),
        child: Column(
          children: [
            Icon(
              icon,
              size: Sizes.largeIconSize,
              color: color,
            ),
            Text(label),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
