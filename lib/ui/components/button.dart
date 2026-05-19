import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.fontSize = 16,
    this.containerColor,
    this.enablePrefixIcon = false,
    this.prefixIcon = Icons.arrow_back,
    this.enableSuffixIcon = false,
    this.suffixIcon = Icons.arrow_forward,
    this.iconColor,
    this.iconSize = 18,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback onTap;
  final double fontSize;
  final Color? containerColor;
  final bool enablePrefixIcon;
  final bool enableSuffixIcon;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final Color? iconColor;
  final double iconSize;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: containerColor,
          border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 40,
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (enablePrefixIcon) ...[
                        Icon(
                          prefixIcon,
                          color: iconColor ?? Colors.white,
                          size: iconSize,
                        ),
                      ],
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (enableSuffixIcon) ...[
                        Icon(
                          suffixIcon,
                          color: iconColor ?? Colors.white,
                          size: iconSize,
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
