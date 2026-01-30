import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TableHeader extends StatelessWidget {
    final String _title;
    final String _subtitle;
    
    final String _addButtonText;
    final VoidCallback _addFunction;

    const TableHeader({
        super.key,
        required String title,
        required String subtitle,
        required String addButtonText,
        required VoidCallback addFunction,
    }) : _title = title,
         _subtitle = subtitle,
         _addButtonText = addButtonText,
         _addFunction = addFunction;

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                            _title,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                            ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                            _subtitle,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                            ),
                        ),
                    ],
                ),
                ElevatedButton.icon(
                    onPressed: () {
                        _addFunction();
                    },
                    icon: const Icon(Icons.add, size: 20),
                    label: Text(_addButtonText),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                        ),
                    ),
                ),
            ],
            ),
        );
    }
}