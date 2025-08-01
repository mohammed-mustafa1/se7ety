import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/app_assets.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key, required this.doctor});
  final DoctorModel doctor;
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
              imageUrl: doctor.image ?? '',
              height: 80,
              width: 70,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return Image.asset(AppAssets.welcomeBg, fit: BoxFit.cover);
              },
            ),
          ),
          Gap(24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    doctor.name ?? '',
                    style: TextStyles.getBody(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(doctor.specialization ?? '', style: TextStyles.getBody()),
              ],
            ),
          ),
          Gap(8),
          Row(
            children: [
              Text('${doctor.rating ?? ''}', style: TextStyles.getSmall()),
              Gap(6),
              Icon(Icons.star, color: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
}
