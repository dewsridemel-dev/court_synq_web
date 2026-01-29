import 'package:flutter/material.dart';
import '../../data/models/court_booking.dart';
import '../widgets/booking_slot.dart';
import '../widgets/dialog/booking_dialog.dart';
import '../../data/models/court.dart';
import '../widgets/date_selector.dart';
import '../widgets/stats_widget.dart';

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
        final timeSlotWidth = 100.0;
        final columnWidth = (constraints.maxWidth / courts.length) - ((timeSlotWidth + 50) / courts.length);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
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
                  const SizedBox(height: 8),
                  // Calender Controll Buttons
                  Row(
                    children: [
                      const DateSelectorWidget(),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: StatsWidget(
                      title: "TODAY'S BOOKINGS",
                      count: "0",
                      icon: Icons.calendar_today,
                      backgroundColor: const Color(0xFFE4F0FF),
                      iconBoxColor1: const Color(0xFF0974FE),
                      iconBoxColor2: const Color(0xFF0051EA),
                      titleColor: Colors.blue,
                      countColor: const Color(0xFF16398E),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: StatsWidget(
                      title: "CONFIRMED BOOKINGS",
                      count: "12",
                      icon: Icons.check_circle,
                      backgroundColor: Colors.green.shade100,
                      iconBoxColor1: Colors.green.shade700,
                      iconBoxColor2: Colors.green.shade900,
                      titleColor: Colors.green.shade800,
                      countColor: Colors.green.shade900,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: StatsWidget(
                      title: "PENDING PAYMENTS",
                      count: "12",
                      icon: Icons.timeline,
                      backgroundColor: const Color(0xFFFFF0DA),
                      iconBoxColor1: const Color(0xFFFF8F01),
                      iconBoxColor2: const Color(0xFFFC5E01),
                      titleColor: const Color(0xFFE57200),
                      countColor: const Color(0xFF7D3309),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: StatsWidget(
                      title: "TODAY'S REVENUE",
                      count: "RS 15,000",
                      icon: Icons.payments,
                      backgroundColor: const Color(0xFFF2EDFF),
                      iconBoxColor1: const Color(0xFFA641FF),
                      iconBoxColor2: const Color(0xFF7B1AEC),
                      titleColor: const Color(0xFF9A0EF9),
                      countColor: const Color(0xFF5A168B),
                    ),
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

  // Court Header Cell
  Widget _courtHeaderCell(Court court) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
          child: ClipRRect(
            child: Stack(
              children: [
                // Background image
                Positioned.fill(
                  child: Image.network(
                    court.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                // White overlay
                Positioned.fill(
                  child: Container(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                // Content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Circle image
                      Container(
                        width: 47,
                        height: 47,
                        // decoration: BoxDecoration(
                        //   shape: BoxShape.circle,
                        //   border: Border.all(
                        //     color: Colors.white,
                        //     width: 4,
                        //   ),
                        //   boxShadow: [
                        //     BoxShadow(
                        //       color: Colors.black.withOpacity(0.15),
                        //       blurRadius: 8,
                        //       offset: const Offset(0, 2),
                        //     ),
                        //   ],
                        // ),
                        child: ClipOval(
                          child: Image.network(
                            court.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Title
                      Text(
                        court.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Subtitle
                      Text(
                        court.description,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF63748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xFF5A5A5A),
          ),
        ),
      ),
    );
  }
}
