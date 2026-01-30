import 'package:court_synq_web/data/models/court_booking.dart';
import 'package:court_synq_web/presentation/widgets/dialog/booking_dialog.dart';
import 'package:flutter/material.dart';
import '../pages/court_details_page.dart';
import '../pages/dashboard_page.dart';
import '../../data/models/court.dart';
import '../pages/business_detail_page.dart';

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
      const Court(id: "1", name: "Court A", imageUrl: "assets/images/default/default_court.jpeg", description: "Test Desc.", maxPlayers: 4, minHours: 1, isActive: true, referenceNumber: "REF001", sports: ['Futsal', 'Cricket', 'Netball'], ratePerHour: 1500.0),
      const Court(id: "2", name: "Cricket Court", imageUrl: "assets/images/default/default_court.jpeg", description: "This is our cricket court", maxPlayers: 4, minHours: 1, isActive: true, referenceNumber: "REF002", sports: ['Futsal', 'Cricket', 'Netball'], ratePerHour: 1500.0),
      const Court(id: "3", name: "Tennis Court", imageUrl: "assets/images/default/default_court.jpeg", description: "", maxPlayers: 4, minHours: 1, isActive: true, referenceNumber: "REF003", sports: ['Futsal', 'Cricket', 'Netball'], ratePerHour: 1500.0),
      const Court(id: "4", name: "Swimming Pool", imageUrl: "assets/images/default/default_court.jpeg", description: "", maxPlayers: 4, minHours: 1, isActive: true, referenceNumber: "REF004", sports: ['Futsal', 'Cricket', 'Netball'], ratePerHour: 1500.0),
      const Court(id: "5", name: "Court C", imageUrl: "assets/images/default/default_court.jpeg", description: "", maxPlayers: 4, minHours: 1, isActive: true, referenceNumber: "REF005", sports: ['Futsal', 'Cricket', 'Netball'], ratePerHour: 1500.0)
    ];

    final List<Booking> bookingList = [
      const Booking(id: "1", courtId: "2", customerName: "John Doe", status: BookingStatus.confirmed, location: "Test Location", activity: "Tennis", price: "1500", startHour: 14, endHour: 15),
      const Booking(id: "2", courtId: "3", customerName: "Ashraf Deen", status: BookingStatus.pending, location: "Street Road", activity: "Cricket", price: "1000", startHour: 7, endHour: 9),
      const Booking(id: "3", courtId: "1", customerName: "Dewsri De Mel", status: BookingStatus.confirmed, location: "Street Road", activity: "Cricket", price: "1000", startHour: 8, endHour: 9)
    ];

    switch (currentRoute) {
      case '/dashboard':
        pageContent = Dashboard(courts: courtList, bookings: bookingList);
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
        pageContent = const BusinessDetailPage();
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
      backgroundColor: Color(0xFFFFFFFF),
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