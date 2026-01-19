import 'package:flutter/material.dart';
import '../models/court_booking.dart';
import '../widgets/booking_dialog.dart';
import '../models/court.dart';

const double _rowHeight = 80;

/// Empty slot with "Add Booking" button.
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
                  Icon(Icons.add, size: 24, color: Color(0xFFAFB8C4)),
                  const SizedBox(height: 4),
                  Text(
                    'Add Booking',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF63748B),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFCAFBF1),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border(
          left: BorderSide(
            color: Color(0xFF00BBA7),
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  booking.customerName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: booking.status == BookingStatus.confirmed ? Color(0xFFDAFCE7) : Color(0xFFFFF2E2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  booking.status == BookingStatus.confirmed ? 'Confirmed' : 'Pending',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: booking.status == BookingStatus.confirmed ? Color(0xFF008000) : Color(0xFFFF5D00), // To be changed by manual or auto
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                '${_formatHour(booking.startHour)} - ${_formatHour(booking.endHour)}',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF63748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF63748B)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  booking.location,
                  style: TextStyle(fontSize: 10, color: Color(0xFF63748B), fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Text(
                  booking.activity,
                  style: TextStyle(fontSize: 10, color: Color(0xFF63748B), fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                booking.price,
                style: TextStyle(fontSize: 10, color: Colors.black87, fontWeight: FontWeight.w600),
              ),
            ]
          ),
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
              style: TextStyle(fontSize: 12, color: Color(0xFF63748B)),
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
