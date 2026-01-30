
import 'package:flutter/material.dart';

class BusinessDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final Color? confirmColor;
  final Color? cancelColor;
  final IconData? icon;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final bool showIcon;
  final Widget? customContent;

  const BusinessDialog({
    Key? key,
    required this.title,
    required this.message,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.confirmColor,
    this.cancelColor,
    this.icon,
    this.iconColor,
    this.iconBackgroundColor,
    this.showIcon = true,
    this.customContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon (if enabled)
          if (showIcon) ...[
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: iconBackgroundColor ?? Colors.blue.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon ?? Icons.info_outline,
                color: iconColor ?? Colors.blue,
                size: 32,
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),

          // Message or Custom Content
          if (customContent != null)
            customContent!
          else
            Text(
              message,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 24),

          // Buttons
          Row(
            children: [
              // Cancel button (if provided)
              if (cancelText != null) ...[
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onCancel?.call();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(
                        color: cancelColor ?? Colors.grey.shade300,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      cancelText!,
                      style: TextStyle(
                        color: cancelColor ?? Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],

              // Confirm button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onConfirm?.call();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: confirmColor ?? Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    confirmText ?? 'OK',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Static method to show dialog easily
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Color? confirmColor,
    Color? cancelColor,
    IconData? icon,
    Color? iconColor,
    Color? iconBackgroundColor,
    bool showIcon = true,
    Widget? customContent,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => BusinessDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        confirmColor: confirmColor,
        cancelColor: cancelColor,
        icon: icon,
        iconColor: iconColor,
        iconBackgroundColor: iconBackgroundColor,
        showIcon: showIcon,
        customContent: customContent,
      ),
    );
  }
}

// Pre-built Dialog Types
class DialogHelper {
  // Success Dialog
  static Future<void> showSuccess(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'OK',
    VoidCallback? onConfirm,
  }) {
    return BusinessDialog.show(
      context,
      title: title,
      message: message,
      confirmText: confirmText,
      onConfirm: onConfirm,
      icon: Icons.check_circle_outline,
      iconColor: Colors.green,
      iconBackgroundColor: Colors.green.shade50,
      confirmColor: Colors.green,
    );
  }

  // Error Dialog
  static Future<void> showError(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'OK',
    VoidCallback? onConfirm,
  }) {
    return BusinessDialog.show(
      context,
      title: title,
      message: message,
      confirmText: confirmText,
      onConfirm: onConfirm,
      icon: Icons.error_outline,
      iconColor: Colors.red,
      iconBackgroundColor: Colors.red.shade50,
      confirmColor: Colors.red,
    );
  }

  // Warning Dialog
  static Future<void> showWarning(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'OK',
    VoidCallback? onConfirm,
  }) {
    return BusinessDialog.show(
      context,
      title: title,
      message: message,
      confirmText: confirmText,
      onConfirm: onConfirm,
      icon: Icons.warning_amber_outlined,
      iconColor: Colors.orange,
      iconBackgroundColor: Colors.orange.shade50,
      confirmColor: Colors.orange,
    );
  }

  // Confirmation Dialog
  static Future<void> showConfirmation(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return BusinessDialog.show(
      context,
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      icon: Icons.help_outline,
      iconColor: Colors.blue,
      iconBackgroundColor: Colors.blue.shade50,
      confirmColor: Colors.blue,
    );
  }

  // Delete Confirmation Dialog
  static Future<void> showDeleteConfirmation(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Delete',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return BusinessDialog.show(
      context,
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      icon: Icons.delete_outline,
      iconColor: Colors.red,
      iconBackgroundColor: Colors.red.shade50,
      confirmColor: Colors.red,
      cancelColor: Colors.grey,
    );
  }
}