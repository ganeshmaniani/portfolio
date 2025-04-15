import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.icon,
  });

  final VoidCallback onTap;
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double tabletBreakpoint = 600.0;
        const double desktopBreakpoint = 1200.0;
        final double screenWidth = constraints.maxWidth;

        double bodyFontSize = screenWidth * 0.012;
        double paddingHorizontal = 16.0;
        double paddingVertical = 8.0;
        double iconSpacing = 16.0;

        if (screenWidth >= desktopBreakpoint) {
          bodyFontSize = screenWidth * 0.010;
          paddingHorizontal = 20.0;
          paddingVertical = 12.0;
          iconSpacing = 20.0;
        } else if (screenWidth >= tabletBreakpoint) {
          bodyFontSize = screenWidth * 0.01;
          paddingHorizontal = 16.0;
          paddingVertical = 8.0;
          iconSpacing = 16.0;
        }

        bodyFontSize = bodyFontSize.clamp(12.0, 18.0);

        return TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal,
              vertical: paddingVertical,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF7462e1),
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                if (screenWidth >= tabletBreakpoint)
                  const BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ), // Add shadow for tablet/desktop
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                    fontSize: bodyFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (icon != null) SizedBox(width: iconSpacing),
                if (icon != null)
                  Icon(
                    icon,
                    color: const Color(0xFFFFFFFF),
                    size: bodyFontSize + 4, // Slightly larger icon size
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
