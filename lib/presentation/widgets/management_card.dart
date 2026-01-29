import 'package:flutter/material.dart';
import 'button/button.dart';
import 'navigation_layout.dart';
import '../pages/court_details_page.dart';

class ManagementCard extends StatelessWidget {
  final String title;
  final String description;
  final String badgeText;
  final Color badgeColor;
  final List<Button> buttons;
  final String backgroundImage;
  final String? url;

  const ManagementCard({
    super.key,
    required this.title,
    required this.description,
    required this.badgeText,
    required this.badgeColor,
    required this.buttons,
    required this.backgroundImage,
    this.url
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(10.0),
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
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const NavigationLayout(child: CourtDetailsPage())),
          );
        },
        child: Stack(
          children: [
            // Background with gradient or image
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    backgroundImage,
                    fit: BoxFit.fill,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(1.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Top right badge
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  badgeText,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            // Title and description overlay on background
            Positioned(
              top: 100,
              left: 24,
              right: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.95),
                      shadows: const [
                        Shadow(
                          color: Colors.black45,
                          blurRadius: 6,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Bottom section with buttons
            Positioned(
              top: 170,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: buttons.asMap().entries.map((entry) {
                    final index = entry.key;
                    final button = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index < buttons.length - 1 ? 12 : 0,
                      ),
                      child: button,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}