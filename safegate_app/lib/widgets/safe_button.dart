import 'package:flutter/material.dart';

class SafeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isFullWidth;
  final IconData? icon;
  final bool isLoading;

  const SafeButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.isFullWidth = true,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    Widget buttonChild = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: isPrimary ? Colors.black87 : primaryColor,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          );

    final style = isPrimary
        ? ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.black87,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          )
        : OutlinedButton.styleFrom(
            foregroundColor: primaryColor,
            side: BorderSide(color: primaryColor),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          );

    Widget button = isPrimary
        ? ElevatedButton(onPressed: isLoading ? null : onPressed, style: style, child: buttonChild)
        : OutlinedButton(onPressed: isLoading ? null : onPressed, style: style, child: buttonChild);

    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        height: 50,
        child: button,
      );
    }

    return SizedBox(
      height: 50,
      child: button,
    );
  }
}
