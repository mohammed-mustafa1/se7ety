import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/extensions/navigation.dart';
import 'package:se7ety/core/extensions/theme.dart';
import 'package:se7ety/core/routers/app_routers.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/doctor/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:se7ety/features/doctor/home/presentation/widgets/header_section.dart';
import 'package:se7ety/features/doctor/home/presentation/widgets/new_patients_section.dart';
import 'package:se7ety/features/doctor/home/presentation/widgets/today_appointments.dart';
import 'package:se7ety/features/doctor/home/presentation/widgets/top_cards.dart';
import 'package:se7ety/features/patient/search/presentation/widgets/search_text_form_field.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight,
        surfaceTintColor: Colors.transparent,
        actionsPadding: EdgeInsets.symmetric(horizontal: 20),
        actions: [Icon(Icons.notifications_active)],
        title: Text('صــحّـتـي'),
        titleTextStyle: TextStyles.getHeadLine2(
          fontWeight: FontWeight.bold,
          color:
              context.brightness == Brightness.light
                  ? AppColors.darkColor
                  : AppColors.whiteColor,
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.darkColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderSection(),
              Gap(16),
              SearchTextFormField(
                hintText: 'ابحث عن مريض',
                onFieldSubmitted: (value) {
                  context.pushTo(
                    AppRouter.patientSearch,
                    extra: context.read<HomeCubit>().searchController.text,
                  );
                },
                controller: context.read<HomeCubit>().searchController,
                onPressed: () {
                  context.pushTo(
                    AppRouter.patientSearch,
                    extra: context.read<HomeCubit>().searchController.text,
                  );
                },
              ),
              Gap(24),
              TopCards(),
              Gap(16),
              Text(
                '📌 لا تنس مراجعة مواعيد اليوم',
                style: TextStyles.getTitle(fontWeight: FontWeight.bold),
              ),
              Gap(16),
              Text(
                'حجوزات اليوم',
                style: TextStyles.getTitle(fontWeight: FontWeight.bold),
              ),
              Gap(16),
              TodayAppointments(),
              Gap(16),
              Text(
                ' المرضى الجدد',
                style: TextStyles.getTitle(fontWeight: FontWeight.bold),
              ),
              Gap(16),
              NewPatientsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
