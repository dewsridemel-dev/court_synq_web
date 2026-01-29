import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelectorWidget extends StatefulWidget {
  const DateSelectorWidget({Key? key}) : super(key: key);

  @override
  State<DateSelectorWidget> createState() => _DateSelectorWidgetState();
}

class _DateSelectorWidgetState extends State<DateSelectorWidget> {
  DateTime selectedDate = DateTime.now();

  void _selectToday() {
    setState(() {
      selectedDate = DateTime.now();
    });
  }

  void _previousDay() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
    });
  }

  void _nextDay() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
    });
  }

  Future<void> _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('EEEE, MMMM dd, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Today button
          TextButton(
            onPressed: _selectToday,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Today',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
          
          const SizedBox(width: 8),
          
          // Previous button
          IconButton(
            onPressed: _previousDay,
            icon: const Icon(Icons.chevron_left),
            iconSize: 20,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: 20,
          ),
          
          const SizedBox(width: 8),
          
          // Calendar button with date
          InkWell(
            onTap: _showDatePicker,
            borderRadius: BorderRadius.circular(4),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.black87,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatDate(selectedDate),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(width: 8),
          
          // Next button
          IconButton(
            onPressed: _nextDay,
            icon: const Icon(Icons.chevron_right),
            iconSize: 20,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: 20,
          ),
        ],
      ),
    );
  }
}

// Example usage
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        body: const Center(
          child: DateSelectorWidget(),
        ),
      ),
    );
  }
}