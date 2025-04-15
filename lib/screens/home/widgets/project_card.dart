import 'package:flutter/material.dart';
import 'package:my_portfolio/screens/home/widgets/custom_button.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final String iconText;
  final bool isPlayStore;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.iconText,
    required this.isPlayStore,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Define breakpoints for responsiveness
        const double tabletBreakpoint = 600.0;
        const double desktopBreakpoint = 1200.0;
        final double screenWidth = constraints.maxWidth;
        final double screenHeight = constraints.maxHeight;

        // Adjust font sizes and padding based on screen size
        double bodyFontSize = screenWidth * 0.018;
        double smallFontSize = screenWidth * 0.012;
        double paddingFactor = screenWidth * 0.05;
        double iconFontSize = screenWidth * 0.024;

        // Adjust for desktop
        if (screenWidth >= desktopBreakpoint) {
          bodyFontSize = screenWidth * 0.015; // Slightly smaller relative size
          smallFontSize = screenWidth * 0.010;
          iconFontSize = screenWidth * 0.020;
          paddingFactor =
              screenWidth * 0.03; // Reduced padding for larger screens
        }
        // Adjust for tablet
        else if (screenWidth >= tabletBreakpoint) {
          bodyFontSize = screenWidth * 0.016;
          smallFontSize = screenWidth * 0.011;
          iconFontSize = screenWidth * 0.022;
          paddingFactor = screenWidth * 0.04; // Moderate padding
        }

        // Limit maximum font sizes for readability
        bodyFontSize = bodyFontSize.clamp(14.0, 20.0);
        smallFontSize = smallFontSize.clamp(10.0, 16.0);
        iconFontSize = iconFontSize.clamp(18.0, 28.0);

        return Container(
          width: screenWidth > desktopBreakpoint
              ? screenWidth * 0.3 // Approx 30% width on desktop
              : screenWidth > tabletBreakpoint
                  ? screenWidth * 0.5 // Approx 50% width on tablet
                  : screenWidth * 0.9, // Full width on mobile
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A3F),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ], // Add shadow for desktop/tablet
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(paddingFactor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(paddingFactor * 0.5),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Color(0xFF0F0F4D),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            iconText,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: iconFontSize,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        title,
                        style: TextStyle(
                          color: const Color(0xFF6859c7),
                          fontSize: bodyFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        description,
                        maxLines: screenWidth > desktopBreakpoint ? 4 : 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color(0xFFFFFFFF),
                          fontSize: smallFontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: screenHeight * 0.01,
                thickness: 1,
                color: Colors.black26,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: paddingFactor, vertical: screenHeight * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (isPlayStore)
                      Expanded(
                        child: CustomButton(
                          onTap: () {},
                          text: 'Play Store',
                          icon: null,
                        ),
                      ),
                    if (isPlayStore) SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: CustomButton(
                        onTap: () {},
                        text: 'Github',
                        icon: null,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.016),
            ],
          ),
        );
      },
    );
  }
}
