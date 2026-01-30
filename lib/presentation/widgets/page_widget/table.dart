import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TableWidget extends StatelessWidget {
    final List<DataColumn> _columns;
    final List<DataCell> _rows;
    final bool _isHavingsActions;
    final VoidCallback _editFunction;
    final VoidCallback _deleteFunction;

    const TableWidget({
        super.key,
        required List<DataColumn> columns,
        required List<DataCell> rows,
        required bool isHavingsActions,
        required VoidCallback editFunction,
        required VoidCallback deleteFunction,
    }) : _columns = columns,
         _rows = rows,
         _isHavingsActions = isHavingsActions,
         _editFunction = editFunction,
         _deleteFunction = deleteFunction;

    @override
    Widget build(BuildContext context) {
        return LayoutBuilder(
            builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 768;
                
                // if (isMobile) {
                //     return _buildMobileView();
                // }
                
                return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: DataTable(
                    headingRowColor: MaterialStateProperty.all(Colors.grey.shade50),
                    columns: _columns,
                    rows: _rows.map((row) {
                        return DataRow(
                            cells: [
                                row,
                            ],
                        );
                    }).toList(),
                    ),
                ),
                );
            },
        );
    }

    // Widget _buildMobileView() {
    //     return ListView.builder(
    //         shrinkWrap: true,
    //         physics: const NeverScrollableScrollPhysics(),
    //         itemCount: _courts.length,
    //         itemBuilder: (context, index) {
    //         final court = _courts[index];
    //         return Card(
    //             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //             child: Padding(
    //             padding: const EdgeInsets.all(16),
    //             child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                     Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                         Text(
    //                             court.name,
    //                             style: const TextStyle(
    //                             fontSize: 18,
    //                             fontWeight: FontWeight.bold,
    //                             ),
    //                         ),
    //                         // Switch(
    //                         //   value: court.isActive,
    //                         //   onChanged: (value) {
    //                         //     setState(() {
    //                         //       court.isActive = value;
    //                         //     });
    //                         //   },
    //                         //   activeColor: Colors.blue,
    //                         // ),
    //                         ],
    //                     ),
    //                     const Divider(),
    //                     _buildMobileRow('Reference No', court.referenceNumber),
    //                     _buildMobileRow('Sports', court.sports.join(', ')),
    //                     _buildMobileRow('Rate Per Hour', 'Rs ${NumberFormat('#,##0.00').format(court.ratePerHour)}'),
    //                     _buildMobileRow('Max Players', court.maxPlayers.toString()),
    //                     _buildMobileRow('Min Hours', '${court.minHours} hour${court.minHours > 1 ? 's' : ''}'),
    //                     const SizedBox(height: 12),
    //                     Row(
    //                         mainAxisAlignment: MainAxisAlignment.end,
    //                         children: [
    //                         IconButton(
    //                             icon: const Icon(Icons.edit_outlined),
    //                             onPressed: () => _editCourt(court),
    //                             color: Colors.blue,
    //                         ),
    //                         IconButton(
    //                             icon: const Icon(Icons.delete_outline),
    //                             onPressed: () => _deleteCourt(court),
    //                             color: Colors.red,
    //                         ),
    //                         ],
    //                     ),
    //                 ],
    //             ),),
    //         );},
    //     );
    // }

    // Widget _buildMobileRow(String label, String value) {
    //     return Padding(
    //         padding: const EdgeInsets.symmetric(vertical: 4),
    //         child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //                 SizedBox(
    //                 width: 120,
    //                 child: Text(
    //                     label,
    //                     style: TextStyle(
    //                     fontWeight: FontWeight.w600,
    //                     color: Colors.grey.shade700,
    //                     ),
    //                 ),
    //                 ),
    //                 Expanded(
    //                     child: Text(value),
    //                 ),
    //             ],
    //         ),
    //     );
    // }
}