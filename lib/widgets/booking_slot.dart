import 'package:flutter/material.dart';
import '../models/court_booking.dart';
import '../widgets/booking_dialog.dart';

const double _rowHeight = 80;

/// Empty slot with "Add Booking" button. Tapping opens the booking popup.
class AddBookingSlot extends StatelessWidget {
  final Court court;
  final int hour;
  final OnBookingSubmit onAddBooking;

  const AddBookingSlot({
    super.key,
    required this.court,
    required this.hour,
    required this.onAddBooking,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _rowHeight,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => const BookingDialog(),
            );
          },

          child: CustomPaint(
            painter: _DashedRectPainter(),
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, size: 28, color: Colors.grey.shade500),
                  const SizedBox(height: 4),
                  Text(
                    'Add Booking',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}

/// Placeholder for the continuation of a multi-hour booking (no Add, no card).
class ContinuationPlaceholder extends StatelessWidget {
  const ContinuationPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: _rowHeight);
  }
}

/// Booked slot card showing booking details.
class BookingDetailsCard extends StatelessWidget {
  final Booking booking;
  final int spanHours;

  const BookingDetailsCard({
    super.key,
    required this.booking,
    required this.spanHours,
  });

  Color _statusColor() {
    switch (booking.status) {
      case BookingStatus.confirmed:
        return Colors.green.shade100;
      case BookingStatus.pending:
        return Colors.amber.shade100;
    }
  }

  Color _statusTagColor() {
    switch (booking.status) {
      case BookingStatus.confirmed:
        return Colors.green;
      case BookingStatus.pending:
        return Colors.amber.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardHeight = (spanHours * _rowHeight) - 8;

    return Container(
      height: cardHeight,
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _statusColor(),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${_formatHour(booking.startHour)} - ${_formatHour(booking.endHour)}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _statusTagColor().withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  booking.status == BookingStatus.confirmed ? 'Confirmed' : 'Pending',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _statusTagColor(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            booking.customerName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          _detailRow(Icons.location_on_outlined, booking.location),
          _detailRow(Icons.sports, booking.activity),
          _detailRow(Icons.attach_money, booking.price),
        ],
      ),
    );
  }

  Widget _detailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey.shade700),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
            ),
          ),
        ],
      ),
    );
  }

  String _formatHour(int h) {
    final h24 = h % 24;
    return '${h24.toString().padLeft(2, '0')}:00';
  }
}

/// Expose row height for the schedule grid.
double get slotRowHeight => _rowHeight;

class _DashedRectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashLen = 4.0;
    const gap = 4.0;
    const r = 4.0;
    final rect = Rect.fromLTWH(r, r, size.width - 2 * r, size.height - 2 * r);
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    void drawDashedLine(Offset a, Offset b) {
      final len = (b - a).distance;
      final dir = (b - a) / len;
      double t = 0;
      while (t < len) {
        final end = a + dir * (t + dashLen).clamp(0, len);
        canvas.drawLine(a + dir * t, end, paint);
        t += dashLen + gap;
      }
    }

    drawDashedLine(rect.topLeft, rect.topRight);
    drawDashedLine(rect.topRight, rect.bottomRight);
    drawDashedLine(rect.bottomRight, rect.bottomLeft);
    drawDashedLine(rect.bottomLeft, rect.topLeft);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
