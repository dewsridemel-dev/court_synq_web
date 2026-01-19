class Court {
  final String id;
  final String name;
  final String icon; // 'tennis', 'badminton', 'squash', etc.

  const Court({
    required this.id,
    required this.name,
    this.icon = 'tennis',
  });
}

/// Booking status enum.
enum BookingStatus {
  confirmed,
  pending,
}

/// Represents a single booking in a time slot.
class Booking {
  final String id;
  final String courtId;
  final String customerName;
  final BookingStatus status;
  final String location;
  final String activity;
  final String price;
  final int startHour; // 0-23, start of slot
  final int endHour;   // 0-23, end of slot (exclusive)

  const Booking({
    required this.id,
    required this.courtId,
    required this.customerName,
    required this.status,
    required this.location,
    required this.activity,
    required this.price,
    required this.startHour,
    required this.endHour,
  });

  /// Check if this booking occupies a specific hour.
  bool occupiesHour(int hour) {
    return hour >= startHour && hour < endHour;
  }
}
