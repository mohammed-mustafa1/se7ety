import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/app_assets.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({super.key, required this.patient});
  final PatientModel patient;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.grayColor.withValues(alpha: 0.3),
            blurRadius: 3,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        color: AppColors.accentColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: patient.image ?? '',
              height: 80,
              width: 70,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return Image.asset(AppAssets.doc, fit: BoxFit.cover);
              },
            ),
          ),
          Gap(24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        patient.name ?? '',
                        style: TextStyles.getBody(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '${patient.age}${(patient.age ?? 0) <= 10 ? ' اعوام' : ' عام'}',
                      style: TextStyles.getBody(color: AppColors.primaryColor),
                    ),
                  ],
                ),
                Gap(8),
                Text(patient.phone ?? '', style: TextStyles.getBody()),
              ],
            ),
          ),
          Gap(8),
        ],
      ),
    );
  }
}
