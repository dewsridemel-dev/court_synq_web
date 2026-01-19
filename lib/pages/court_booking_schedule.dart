import 'package:flutter/material.dart';
import '../models/court_booking.dart';
import '../widgets/booking_slot.dart';
import '../widgets/booking_dialog.dart';

/// Displays an hourly court booking schedule. Columns = courts, rows = hours.
class CourtBookingSchedule extends StatelessWidget {
  final List<Court> courts;
  final List<Booking> bookings;

  final int startHour;
  final int endHour;
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

  bool _bookingStartsAt(Booking b, int hour) => b.startHour == hour;

  @override
  Widget build(BuildContext context) {
    // Wrap in LayoutBuilder to calculate dynamic width per column
    return LayoutBuilder(
      builder: (context, constraints) {
        final timeSlotWidth = ((constraints.maxWidth - 48) / (courts.length + 1)) - 100;
        final columnWidth = (constraints.maxWidth - 48) / (courts.length + 1);print(columnWidth);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFF6579E1), Color(0xFF754FA8)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                        child: const Text(
                          'Athletic Performance Center',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Professional sports facility management and booking system',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF63748B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 24.0),
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    border: TableBorder.symmetric(
                      inside: BorderSide(color: Colors.grey.shade200),
                    ),
                    columnWidths: {
                      for (int i = 0; i <= courts.length; i++)
                        i: i == 0 ? FixedColumnWidth(timeSlotWidth) : FixedColumnWidth(columnWidth),
                    },
                    children: [
                      // Header row
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
                                    verticalAlignment:
                                        TableCellVerticalAlignment.top,
                                    child: BookingDetailsCard(
                                      booking: booking,
                                      spanHours: booking.endHour -
                                          booking.startHour,
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
              )
            ],
          ),
        );
      },
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
    final str = '${hour.toString().padLeft(2, '0')}:00';
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
