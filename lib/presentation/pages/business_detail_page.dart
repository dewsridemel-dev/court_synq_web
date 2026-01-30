import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/court.dart';
import '../../data/models/business.dart';
import '../widgets/page_widget/page_header.dart';
import '../widgets/page_widget/table_header.dart';
import '../widgets/page_widget/table.dart';
import '../widgets/dialog/business_dialog.dart';

class BusinessDetailPage extends StatefulWidget {
  const BusinessDetailPage({super.key});

  @override
  State<BusinessDetailPage> createState() => _BusinessDetailPageState();
}

class _BusinessDetailPageState extends State<BusinessDetailPage> {
  final List<Business> _business = [];

  final List<DataColumn> _columns = [
    DataColumn(label: Text('Court Name', style: TextStyle(fontWeight: FontWeight.bold))),
    DataColumn(label: Text('Reference No', style: TextStyle(fontWeight: FontWeight.bold))),
    DataColumn(label: Text('Sports', style: TextStyle(fontWeight: FontWeight.bold))),
    DataColumn(label: Text('Rate Per Hour', style: TextStyle(fontWeight: FontWeight.bold))),
    DataColumn(label: Text('Max Players', style: TextStyle(fontWeight: FontWeight.bold))),
    DataColumn(label: Text('Min Hours', style: TextStyle(fontWeight: FontWeight.bold))),
    DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
    DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
  ];
  final List<DataCell> _rows = [
    // DataCell(Text(court.name)),
    // DataCell(Text(court.referenceNumber)),
    // DataCell(
    // Wrap(
    //     spacing: 4,
    //     children: court.sports.map((sport) {
    //     return Chip(
    //         label: Text(sport, style: const TextStyle(fontSize: 11)),
    //         padding: EdgeInsets.zero,
    //         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //         visualDensity: VisualDensity.compact,
    //     );
    //     }).toList(),
    // ),
    // ),
    // DataCell(Text('Rs ${NumberFormat('#,##0.00').format(court.ratePerHour)}')),
    // DataCell(Text(court.maxPlayers.toString())),
    // DataCell(Text('${court.minHours} hour${court.minHours > 1 ? 's' : ''}')),
    // DataCell(
    //   Text(court.isActive ? 'Active' : 'Inactive'),
    //   // Switch(
    //   //   value: court.isActive,
    //   //   onChanged: (value) {
    //   //     setState(() {
    //   //       court.isActive = value;
    //   //     });
    //   //   },
    //   //   activeColor: Colors.blue,
    //   // ),
    // ),
    // DataCell(
    //   Row(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //       IconButton(
    //           icon: const Icon(Icons.edit_outlined, size: 20),
    //           onPressed: () => _editCourt(court),
    //           color: Colors.blue,
    //           padding: EdgeInsets.zero,
    //           constraints: const BoxConstraints(),
    //       ),
    //       const SizedBox(width: 8),
    //       IconButton(
    //           icon: const Icon(Icons.delete_outline, size: 20),
    //           onPressed: () => _deleteCourt(court),
    //           color: Colors.red,
    //           padding: EdgeInsets.zero,
    //           constraints: const BoxConstraints(),
    //       ),
    //       ],
    //   ),
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Header
          const PageHeader(title: 'Business Details', subtitle: 'Manage your business details and courts.'),
          const SizedBox(height: 32),
          
          // Section
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Header
                TableHeader(
                  title: 'Courts',
                  subtitle: 'Manage the courts associated with your business.',
                  addButtonText: 'Add Court',
                  addFunction: () {
                    _showBusinessDialog();
                  },
                ),
                // Table
                TableWidget(
                  columns: _columns,
                  rows: _rows,
                  isHavingsActions: true,
                  editFunction: () {},
                  deleteFunction: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showBusinessDialog() {
    BusinessDialog(
      title: 'Add Court',
      message: 'Court addition form will be implemented here.',
      confirmText: 'Add',
      cancelText: 'Cancel',
    );
  }

  // void _editCourt(Court court) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Edit Court'),
  //       content: Text('Edit ${court.name} form will be implemented here.'),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Cancel'),
  //         ),
  //         ElevatedButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Save'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void _deleteCourt(Court court) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Delete Court'),
  //       content: Text('Are you sure you want to delete ${court.name}?'),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Cancel'),
  //         ),
  //         ElevatedButton(
  //           onPressed: () {
  //             setState(() {
  //               _courts.remove(court);
  //             });
  //             Navigator.pop(context);
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(content: Text('${court.name} deleted')),
  //             );
  //           },
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: Colors.red,
  //             foregroundColor: Colors.white,
  //           ),
  //           child: const Text('Delete'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}