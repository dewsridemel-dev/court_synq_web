import 'package:court_synq_web/models/court_booking.dart';
import 'package:court_synq_web/widgets/booking_dialog.dart';
import 'package:flutter/material.dart';
import '../pages/court_details_page.dart';
import '../pages/court_booking_schedule.dart';

class NavigationPageView extends StatelessWidget {
  final String currentRoute;
  final Widget child;

  const NavigationPageView({
    super.key,
    required this.currentRoute,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Widget pageContent;

    // Test
    final List<Court> courtList = [
      const Court(id: "1", name: "Test Court 1"),
      const Court(id: "2", name: "Test Court 2"),
      const Court(id: "3", name: "Test Court 3"),
      const Court(id: "4", name: "Test Court 4"),
      const Court(id: "5", name: "Test Court 5")
    ];

    final List<Booking> bookingList = [
      const Booking(id: "1", courtId: "2", customerName: "Ashraf Deen", status: BookingStatus.confirmed, location: "", activity: "", price: "1500", startHour: 14, endHour: 15)
    ];

    switch (currentRoute) {
      case '/dashboard':
        pageContent = CourtBookingSchedule(courts: courtList, bookings: bookingList);
        break;
      case '/court-details':
        pageContent = const CourtDetailsPage();
        break;
      case '/pricing':
        pageContent = _buildPlaceholderPage('Pricing', 'Manage court pricing');
        break;
      case '/booking-history':
        pageContent = _buildPlaceholderPage('Booking History', 'View all bookings');
        break;
      case '/facilities':
        pageContent = _buildPlaceholderPage('Facilities', 'Manage facilities');
        break;
      case '/equipment':
        pageContent = _buildPlaceholderPage('Equipment', 'Manage equipment');
        break;
      case '/profile-settings':
        pageContent = _buildPlaceholderPage('Profile Settings', 'Configure profile');
        break;
      case '/business-info':
        pageContent = _buildPlaceholderPage('Business Info', 'Business information');
        break;
      case '/staff-management':
        pageContent = _buildPlaceholderPage('Staff Management', 'Manage staff');
        break;
      case '/promotion':
        pageContent = _buildPlaceholderPage('Promotion', 'Manage promotions');
        break;
      case '/insights':
        pageContent = _buildPlaceholderPage('Insights', 'View analytics');
        break;
      case '/help-center':
        pageContent = _buildPlaceholderPage('Help Center', 'Get help');
        break;
      default:
        pageContent = child;
    }

    return Container(
      color: Colors.grey.shade50,
      child: pageContent,
    );
  }

  Widget _buildPlaceholderPage(String title, String subtitle) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}