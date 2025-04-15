import 'package:flutter/material.dart';
import 'package:my_portfolio/screens/home/responsive_widgets/desktop_view.dart';
import 'package:my_portfolio/screens/home/responsive_widgets/mobile_view.dart';
import 'package:my_portfolio/screens/home/responsive_widgets/responsive_layout.dart';
import 'package:my_portfolio/screens/home/responsive_widgets/tablet_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveLayout(
        mobileView: MobileView(),
        tabletView: TabletView(),
        desktopView: DesktopView(),
      ),
    );
  }
}
