import 'package:flutter/material.dart';
import 'card_button.dart';

class ManagementCard extends StatelessWidget {
  final String title;
  final String description;
  final String badgeText;
  final Color badgeColor;
  final List<CardButton> buttons;
  final Widget? backgroundImage;
  final IconData? topLeftIcon;
  final Color? gradientStartColor;
  final Color? gradientEndColor;

  const ManagementCard({
    super.key,
    required this.title,
    required this.description,
    required this.badgeText,
    required this.badgeColor,
    required this.buttons,
    this.backgroundImage,
    this.topLeftIcon,
    this.gradientStartColor,
    this.gradientEndColor,
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
          // Background with gradient or image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    gradientStartColor ?? Colors.amber.shade700,
                    gradientEndColor ?? Colors.amber.shade400,
                  ],
                ),
              ),
              child: backgroundImage ??
                  Center(
                    child: Opacity(
                      opacity: 0.3,
                      child: Icon(
                        Icons.sports_tennis,
                        size: 150,
                        color: Colors.white,
                      ),
                    ),
                  ),
            ),
          ),
          // Top left icon (shuttlecock)
          if (topLeftIcon != null)
            Positioned(
              top: 16,
              left: 16,
              child: Icon(
                topLeftIcon,
                size: 32,
                color: Colors.white.withOpacity(0.9),
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
                borderRadius: BorderRadius.circular(8),
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
            top: 60,
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
    );
  }
}