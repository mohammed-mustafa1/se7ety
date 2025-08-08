import 'package:flutter/material.dart';
import 'package:se7ety/core/services/shared_prefs.dart';
import 'package:se7ety/features/auth/data/models/user_enum.dart';
import 'package:se7ety/features/auth/presentation/page/doctor_register_screen.dart';
import 'package:se7ety/features/doctor/appointments/presentation/pages/doctor_appointments_screen.dart';
import 'package:se7ety/features/doctor/search/presentation/page/search_screen.dart';
import 'package:se7ety/features/profile/presentation/pages/user_profile_screen.dart';
import 'package:se7ety/features/patient/appointments/pages/appointments_screen.dart';
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

  List<Widget> doctorScreens = [
    PatientHomeScreen(),
    DoctorSearchScreen(),
    DoctorAppointmentsScreen(),
    UserProfileScreen(userType: UserType.doctor),
    DoctorRegisterScreen(),
  ];
  List<Widget> patientscreens = [
    PatientHomeScreen(),
    SearchScreen(),
    AppointmentsScreen(),
    UserProfileScreen(userType: UserType.patient),
    DoctorRegisterScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          SharedPrefs.getUserType() == UserType.doctor.name
              ? doctorScreens[selectedIndex]
              : patientscreens[selectedIndex],
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
