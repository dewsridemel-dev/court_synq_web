import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PageHeader extends StatelessWidget {
    final String title;
    final String subtitle;

    const PageHeader({
        super.key,
        required this.title,
        required this.subtitle,
    });

    @override
    Widget build(BuildContext context) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                        title,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                        ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                        subtitle,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                        ),
                    ),
                ],
                ),
            ],
        );
    }
}