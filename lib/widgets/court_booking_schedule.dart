import 'package:flutter/material.dart';
import '../models/court_booking.dart';
import 'booking_slot.dart';
import 'dialog/booking_dialog.dart';

/// Displays an hourly court booking schedule. Columns = courts, rows = hours.
/// Data is driven by [courts] and [bookings] arrays.
class CourtBookingSchedule extends StatelessWidget {
  final List<Court> courts;
  final List<Booking> bookings;

  /// Start hour (0-23).
  final int startHour;

  /// End hour (0-23, inclusive).
  final int endHour;

  /// Callback when a new booking is added from the "Add Booking" popup.
  final OnBookingSubmit? onBookingAdded;

  const CourtBookingSchedule({
    super.key,
    required this.courts,
    required this.bookings,
    this.startHour = 6,
    this.endHour = 23,
    this.onBookingAdded,
  });

  Booking? _bookingFor(Court court, int hour) {
    for (final b in bookings) {
      if (b.courtId == court.id && b.occupiesHour(hour)) return b;
    }
    return null;
  }

  /// Whether a booking starts at this hour for this court (so we draw the card here).
  bool _bookingStartsAt(Booking b, int hour) => b.startHour == hour;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          border: TableBorder.symmetric(
            inside: BorderSide(color: Colors.grey.shade200),
          ),
          columnWidths: {
            for (int i = 0; i <= courts.length; i++)
              i: i == 0 ? const FixedColumnWidth(72) : const FlexColumnWidth(1),
          },
          children: [
            // Header row: Time | Court headers
            TableRow(
              decoration: BoxDecoration(color: Colors.grey.shade50),
              children: [
                _headerCell('Time'),
                ...courts.map((c) => _courtHeaderCell(c)),
              ],
            ),
            // Hour rows
            for (int h = startHour; h <= endHour; h++)
              TableRow(
                children: [
                  _timeCell(h),
                  ...courts.map((court) {
                    final booking = _bookingFor(court, h);
                    if (booking != null) {
                      if (_bookingStartsAt(booking, h)) {
                        return TableCell(
                          verticalAlignment: TableCellVerticalAlignment.top,
                          child: BookingDetailsCard(
                            booking: booking,
                            spanHours: booking.endHour - booking.startHour,
                          ),
                        );
                      } else {
                        return const TableCell(
                          child: ContinuationPlaceholder(),
                        );
                      }
                    }
                    return TableCell(
                      child: AddBookingSlot(
                        court: court,
                        hour: h,
                        onAddBooking: onBookingAdded ??
                            ({
                              required String courtId,
                              required String customerName,
                              required BookingStatus status,
                              required String location,
                              required String activity,
                              required String price,
                              required int startHour,
                              required int endHour,
                            }) {},
                      ),
                    );
                  }),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _headerCell(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _courtHeaderCell(Court court) {
    IconData icon;
    switch (court.icon) {
      case 'badminton':
        icon = Icons.sports;
        break;
      case 'squash':
        icon = Icons.sports_martial_arts;
        break;
      default:
        icon = Icons.sports_tennis;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade700),
          const SizedBox(width: 8),
          Text(
            court.name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeCell(int hour) {
    final h = hour % 24;
    final str = '${h.toString().padLeft(2, '0')}:00';
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          str,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
