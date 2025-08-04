import 'package:flutter/material.dart';
import 'package:se7ety/features/intro/welcome/welcome_screen.dart';
import 'package:se7ety/features/patient/home/presentation/pages/patient_home_screen.dart';
import 'package:se7ety/features/patient/search/presentation/page/search_screen.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/main_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  List<Widget> mainscreens = [
    PatientHomeScreen(),
    SearchScreen(),
    PatientHomeScreen(),
    WelcomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainscreens[selectedIndex],
      bottomNavigationBar: MainNavBar(
        selectedIndex: selectedIndex,
        onTabChange: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
      ),
    );
  }
}
