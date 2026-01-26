import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor1;
  final Color? backgroundColor2;
  final Color? textColor;
  final Color? borderColor;
  final double? height;
  final double? width;
  final IconData? icon;
  final bool? isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.backgroundColor1,
    this.backgroundColor2,
    this.textColor,
    this.borderColor,
    this.height,
    this.width,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height ?? 50,
        width: width ?? double.infinity,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                    colors: [
                        backgroundColor1 ?? Color(0xFF6972D8),
                        backgroundColor2 ?? Color(0xFF705CB8),
                    ],
                ),
                border: Border.all(
                    color: borderColor ?? Colors.transparent,
                    width: .5,
                ),
            ),
            child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 3,
                ),
                child: isLoading == true
                ? SizedBox(
                    height: height ?? 30,
                    width: width ?? 30,
                    child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    )
                : Text(
                    text,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: textColor ?? Colors.white
                    ),
                ),
            ),
        ),
    );
  }
}