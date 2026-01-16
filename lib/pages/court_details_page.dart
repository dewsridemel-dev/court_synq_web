import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CourtDetailsPage extends StatefulWidget {
  const CourtDetailsPage({super.key});

  @override
  State<CourtDetailsPage> createState() => _CourtDetailsPageState();
}

class _CourtDetailsPageState extends State<CourtDetailsPage> {
  final List<CourtData> _courts = [
    CourtData(
      name: 'Court A',
      referenceNo: 'ID00001',
      sports: ['Futsal', 'Cricket', 'Netball'],
      ratePerHour: 1500.00,
      maxPlayers: 10,
      minHours: 2,
      isActive: true,
    ),
    CourtData(
      name: 'Court B',
      referenceNo: 'ID00002',
      sports: ['Futsal', 'Cricket', 'Netball'],
      ratePerHour: 1500.00,
      maxPlayers: 10,
      minHours: 1,
      isActive: true,
    ),
    CourtData(
      name: 'Court C',
      referenceNo: 'ID00002',
      sports: ['Futsal', 'Cricket', 'Netball'],
      ratePerHour: 1500.00,
      maxPlayers: 10,
      minHours: 1,
      isActive: true,
    ),
    CourtData(
      name: 'Court D',
      referenceNo: 'ID00002',
      sports: ['Futsal', 'Cricket', 'Netball'],
      ratePerHour: 1500.00,
      maxPlayers: 10,
      minHours: 2,
      isActive: true,
    ),
    CourtData(
      name: 'Court E',
      referenceNo: 'ID00002',
      sports: ['Futsal', 'Cricket', 'Netball'],
      ratePerHour: 1500.00,
      maxPlayers: 10,
      minHours: 1,
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Court Details',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Manage your court details',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Courts Section
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
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Courts',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'View and manage all court details.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle add court
                          _showAddCourtDialog();
                        },
                        icon: const Icon(Icons.add, size: 20),
                        label: const Text('Add Court'),
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
                ),
                // Table
                _buildTable(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;
        
        if (isMobile) {
          return _buildMobileView();
        }
        
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(Colors.grey.shade50),
              columns: const [
                DataColumn(label: Text('Court Name', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Reference No', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Sports', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Rate Per Hour', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Max Players', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Min Hours', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: _courts.map((court) {
                return DataRow(
                  cells: [
                    DataCell(Text(court.name)),
                    DataCell(Text(court.referenceNo)),
                    DataCell(
                      Wrap(
                        spacing: 4,
                        children: court.sports.map((sport) {
                          return Chip(
                            label: Text(sport, style: const TextStyle(fontSize: 11)),
                            padding: EdgeInsets.zero,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          );
                        }).toList(),
                      ),
                    ),
                    DataCell(Text('Rs ${NumberFormat('#,##0.00').format(court.ratePerHour)}')),
                    DataCell(Text(court.maxPlayers.toString())),
                    DataCell(Text('${court.minHours} hour${court.minHours > 1 ? 's' : ''}')),
                    DataCell(
                      Switch(
                        value: court.isActive,
                        onChanged: (value) {
                          setState(() {
                            court.isActive = value;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                    ),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit_outlined, size: 20),
                            onPressed: () => _editCourt(court),
                            color: Colors.blue,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, size: 20),
                            onPressed: () => _deleteCourt(court),
                            color: Colors.red,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _courts.length,
      itemBuilder: (context, index) {
        final court = _courts[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      court.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: court.isActive,
                      onChanged: (value) {
                        setState(() {
                          court.isActive = value;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
                const Divider(),
                _buildMobileRow('Reference No', court.referenceNo),
                _buildMobileRow('Sports', court.sports.join(', ')),
                _buildMobileRow('Rate Per Hour', 'Rs ${NumberFormat('#,##0.00').format(court.ratePerHour)}'),
                _buildMobileRow('Max Players', court.maxPlayers.toString()),
                _buildMobileRow('Min Hours', '${court.minHours} hour${court.minHours > 1 ? 's' : ''}'),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () => _editCourt(court),
                      color: Colors.blue,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _deleteCourt(court),
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _showAddCourtDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Court'),
        content: const Text('Add court form will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editCourt(CourtData court) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Court'),
        content: Text('Edit ${court.name} form will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteCourt(CourtData court) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Court'),
        content: Text('Are you sure you want to delete ${court.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _courts.remove(court);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${court.name} deleted')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class CourtData {
  String name;
  String referenceNo;
  List<String> sports;
  double ratePerHour;
  int maxPlayers;
  int minHours;
  bool isActive;

  CourtData({
    required this.name,
    required this.referenceNo,
    required this.sports,
    required this.ratePerHour,
    required this.maxPlayers,
    required this.minHours,
    required this.isActive,
  });
}