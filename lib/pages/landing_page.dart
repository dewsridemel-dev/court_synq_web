import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../widgets/booking_dialog.dart';
import '../widgets/management_card.dart';
import '../widgets/button.dart';
import '../widgets/app_header.dart';
import '../widgets/stats_widget.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    
    final String first_name = authService.synQUser?.first_name ?? 'User';
    final String last_name = authService.synQUser?.last_name ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppHeader(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 24,
          left: 100,
          right: 100,
          bottom: 48,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF6579E1), Color(0xFF754FA8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
              child: Text(
                'Good Afternoon $first_name $last_name,',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Summary Cards
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
                      backgroundImage: 'assets/images/class_booking_bkg.jpg',
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

// class _SummaryCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final IconData icon;
//   final Color color;
//   final bool isRevenue;

//   const _SummaryCard({
//     required this.title,
//     required this.value,
//     required this.icon,
//     required this.color,
//     this.isRevenue = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: color.withOpacity(0.3)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: color,
//                 ),
//               ),
//               Icon(icon, color: color, size: 24),
//             ],
//           ),
//           const SizedBox(height: 12),
//           if (isRevenue) ...[
//             const Text(
//               'LKR',
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: isRevenue ? 20 : 28,
//               fontWeight: FontWeight.bold,
//               color: color,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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