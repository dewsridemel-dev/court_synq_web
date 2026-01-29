import 'package:flutter/material.dart';

class StatsWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color iconBoxColor1;
  final Color iconBoxColor2;
  final IconData icon;
  final Color iconColor;
  final String title;
  final Color titleColor;
  final String count;
  final Color countColor;
  final double borderRadius;
  final EdgeInsets padding;

  const StatsWidget({
    Key? key,
    this.backgroundColor = const Color(0xFFE3F2FD),
    this.iconBoxColor1 = const Color(0xFF2196F3),
    this.iconBoxColor2 = const Color(0xFF2196F3),
    this.icon = Icons.calendar_today,
    this.iconColor = Colors.white,
    required this.title,
    this.titleColor = const Color(0xFF1976D2),
    required this.count,
    this.countColor = const Color(0xFF0D47A1),
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(10.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        children: [
          // Icon box
          Container(
            width: 63,
            height: 63,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  iconBoxColor1,
                  iconBoxColor2,
                ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 10),
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  count,
                  style: TextStyle(
                    color: countColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}