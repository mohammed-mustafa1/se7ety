import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/specialization.dart';
import 'package:se7ety/core/extensions/navigation.dart';
import 'package:se7ety/core/extensions/theme.dart';
import 'package:se7ety/core/routers/app_routers.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/patient/search/presentation/page/search_screen.dart';
import 'package:se7ety/features/patient/search/presentation/widgets/search_text_form_field.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/specialization_list_view.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/top_rated_doctor_list_view.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  User? user;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              Row(
                children: [
                  Text('مرحبا, ', style: TextStyles.getTitle()),
                  Text(
                    user?.displayName ?? '',
                    style: TextStyles.getTitle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Gap(16),
              Text(
                'احجز الان وكن جزءا من رحلتك الصحية.',
                style: TextStyles.getHeadLine1(),
              ),
              Gap(16),
              SearchTextFormField(
                hintText: 'ابحث عن دكتور',
                onFieldSubmitted: (value) {
                  context.pushTo(
                    AppRouter.search,
                    extra: [searchController.text, SearchType.name],
                  );
                },
                controller: searchController,
                onPressed: () {
                  context.pushTo(
                    AppRouter.search,
                    extra: [searchController.text, SearchType.name],
                  );
                },
              ),
              Gap(16),
              Text(
                'التخصصات',
                style: TextStyles.getBody(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              Gap(16),
              SizedBox(
                height: 220,
                child: SpecializationListView(items: specializations),
              ),
              Gap(16),
              Text(
                'الاعلي تقيما',
                style: TextStyles.getBody(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              Gap(16),
              TopRatedDoctorListView(),
            ],
          ),
        ),
      ),
    );
  }
}
