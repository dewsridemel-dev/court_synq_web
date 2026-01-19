import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../widgets/booking_dialog.dart';
import '../widgets/management_card.dart';
import '../widgets/button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Court SynQ',
            style: TextStyle(
              color: Colors.purple.shade700,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
            color: Colors.grey.shade700,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  child: Icon(Icons.person),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authService.user?.email?.split('@')[0] ?? 'User',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const Text(
                      'Admin',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Afternoon ${authService.user?.email?.split('@')[0] ?? 'User'},',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    title: "TODAY'S BOOKINGS",
                    value: "12",
                    icon: Icons.calendar_today,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _SummaryCard(
                    title: "CONFIRMED BOOKINGS",
                    value: "12",
                    icon: Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _SummaryCard(
                    title: "PENDING PAYMENTS",
                    value: "12",
                    icon: Icons.access_time,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _SummaryCard(
                    title: "TODAY'S REVENUE",
                    value: "RS 15,000",
                    icon: Icons.attach_money,
                    color: Colors.purple,
                    isRevenue: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              'Manage your business',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Select category to get started',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            // Management Cards
            LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 768;
              
              if (isMobile) {
                return Column(
                  children: [
                    ManagementCard(
                      title: 'Court Reservation Management',
                      description: 'Book courts, manage availability, and handle customer reservations',
                      badgeText: '3 Pending Approvals',
                      badgeColor: Colors.yellow,
                      backgroundImage: 'assets/images/court_booking_bkg.jpg',
                      buttons: [
                        Button(
                          text: 'New Booking',
                          icon: Icons.add,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => const BookingDialog(),
                            );
                          },
                          height: 20,
                        ),
                        Button(
                          text: 'View Calendar',
                          icon: Icons.calendar_today,
                          onPressed: () {},
                          height: 20,
                        ),
                        Button(
                          text: 'Check Availability',
                          icon: Icons.access_time,
                          onPressed: () {},
                          height: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ManagementCard(
                      title: 'Classes & Sessions Management',
                      description: 'Create and manage sports classes and training sessions',
                      badgeText: '2 Classes Starting Soon',
                      badgeColor: Colors.blue,
                      backgroundImage: 'assets/images/court_booking_bkg.jpg',
                      buttons: [
                        Button(
                          text: 'Create Class',
                          icon: Icons.add,
                          onPressed: () {},
                          height: 20,
                        ),
                        Button(
                          text: 'Manage Schedule',
                          icon: Icons.calendar_today,
                          onPressed: () {},
                          height: 20,
                        ),
                        Button(
                          text: 'View Enrollments',
                          icon: Icons.people,
                          onPressed: () {},
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                );
              }
              
              return Row(
                children: [
                  Expanded(
                    child: ManagementCard(
                      title: 'Court Reservation Management',
                      description: 'Book courts, manage availability, and handle customer reservations',
                      badgeText: '3 Pending Approvals',
                      badgeColor: Color(0xD6FFCC00),
                      backgroundImage: 'assets/images/court_booking_bkg.jpg',
                      buttons: [
                        Button(
                          text: 'New Booking',
                          icon: Icons.add,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => const BookingDialog(),
                            );
                          },
                          height: 40,
                        ),
                        Button(
                          text: 'View Calendar',
                          icon: Icons.calendar_today,
                          onPressed: () {},
                          height: 40,
                        ),
                        Button(
                          text: 'Check Availability',
                          icon: Icons.access_time,
                          onPressed: () {},
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ManagementCard(
                      title: 'Classes & Sessions Management',
                      description: 'Create and manage sports classes and training sessions',
                      badgeText: '2 Classes Starting Soon',
                      badgeColor: Colors.blue,
                      backgroundImage: 'assets/images/court_booking_bkg.jpg',
                      buttons: [
                        Button(
                          text: 'Create Class',
                          icon: Icons.add,
                          onPressed: () {},
                          height: 40,
                        ),
                        Button(
                          text: 'Manage Schedule',
                          icon: Icons.calendar_today,
                          onPressed: () {},
                          height: 40,
                        ),
                        Button(
                          text: 'View Enrollments',
                          icon: Icons.people,
                          onPressed: () {},
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            ),

            const SizedBox(height: 40),
            const Text(
              "Today's Schedule",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Schedule Cards
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                final isPending = index >= 2;
                return _ScheduleCard(
                  name: 'John Doe',
                  time: '09:00 - 10:00',
                  location: 'North Wing',
                  activity: 'Tennis',
                  status: isPending ? 'Pending' : 'Confirmed',
                  price: 'Rs 4,500.00',
                  isPending: isPending,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final bool isRevenue;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.isRevenue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Icon(icon, color: color, size: 24),
            ],
          ),
          const SizedBox(height: 12),
          if (isRevenue) ...[
            const Text(
              'LKR',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
          Text(
            value,
            style: TextStyle(
              fontSize: isRevenue ? 20 : 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  final String name;
  final String time;
  final String location;
  final String activity;
  final String status;
  final String price;
  final bool isPending;

  const _ScheduleCard({
    required this.name,
    required this.time,
    required this.location,
    required this.activity,
    required this.status,
    required this.price,
    required this.isPending,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isPending ? Colors.purple.shade50 : Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPending
              ? Colors.purple.shade200
              : Colors.teal.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isPending ? Colors.orange : Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            time,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            location,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            activity,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          const Spacer(),
          Text(
            price,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isPending
                  ? Colors.purple.shade700
                  : Colors.teal.shade700,
            ),
          ),
        ],
      ),
    );
  }
}