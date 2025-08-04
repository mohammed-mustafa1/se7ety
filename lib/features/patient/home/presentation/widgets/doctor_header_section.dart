import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/app_assets.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/phone_icon.dart';

class DoctorHeaderSection extends StatelessWidget {
  const DoctorHeaderSection({super.key, required this.doctor});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: SizedBox(
            height: 100,
            width: 100,
            child: CachedNetworkImage(
              imageUrl: doctor.image ?? '',
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return Image.asset(AppAssets.doc, fit: BoxFit.cover);
              },
            ),
          ),
        ),
        Gap(16),
        Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doctor.name ?? '',
              style: TextStyles.getTitle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            Text(doctor.specialization ?? '', style: TextStyles.getBody()),
            Row(
              children: [
                Text('${doctor.rating ?? 0}', style: TextStyles.getTitle()),
                Gap(6),
                Icon(Icons.star, color: Colors.orange),
              ],
            ),
            Row(
              spacing: 16,
              children: [PhoneIcon(text: '1'), PhoneIcon(text: '2')],
            ),
          ],
        ),
      ],
    );
  }
}
