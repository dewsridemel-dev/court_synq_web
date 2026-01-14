import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../widgets/booking_dialog.dart';

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
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Select category to get started',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            // Management Cards
            Row(
              children: [
                Expanded(
                  child: _ManagementCard(
                    title: 'Court Reservation Management',
                    description: 'Book courts, manage availability, and handle customer reservations',
                    imageAsset: 'assets/badminton.jpg', // You'll need to add this
                    badgeText: '3 Pending Approvals',
                    badgeColor: Colors.yellow,
                    buttons: [
                      _CardButton(
                        text: '+ New Booking',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const BookingDialog(),
                          );
                        },
                      ),
                      _CardButton(
                        text: 'View Calendar',
                        icon: Icons.calendar_today,
                        onPressed: () {},
                      ),
                      _CardButton(
                        text: 'Check Availability',
                        icon: Icons.access_time,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _ManagementCard(
                    title: 'Classes & Sessions Management',
                    description: 'Create and manage sports classes and training sessions',
                    imageAsset: 'assets/yoga.jpg', // You'll need to add this
                    badgeText: '2 Classes Starting Soon',
                    badgeColor: Colors.blue,
                    buttons: [
                      _CardButton(
                        text: '+ Create Class',
                        onPressed: () {},
                      ),
                      _CardButton(
                        text: 'Manage Schedule',
                        icon: Icons.calendar_today,
                        onPressed: () {},
                      ),
                      _CardButton(
                        text: 'View Enrollments',
                        icon: Icons.people,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
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

class _ManagementCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageAsset;
  final String badgeText;
  final Color badgeColor;
  final List<_CardButton> buttons;

  const _ManagementCard({
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.badgeText,
    required this.badgeColor,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.purple.shade300,
                    Colors.purple.shade100,
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.sports_tennis,
                  size: 150,
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
          ),
          // Content
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      badgeText,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: buttons,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;

  const _CardButton({
    required this.text,
    this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16),
            const SizedBox(width: 4),
          ],
          Text(text),
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