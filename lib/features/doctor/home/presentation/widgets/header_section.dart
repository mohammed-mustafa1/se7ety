import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/doctor/home/presentation/cubit/home_cubit/home_cubit.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('مرحبا دكتور, ', style: TextStyles.getTitle()),
            Text(
              context.read<HomeCubit>().user.displayName ?? '',
              style: TextStyles.getTitle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Gap(16),
        Text(
          DateFormat.MMMEd().format(DateTime.now()).toString(),
          style: TextStyles.getTitle(color: Colors.orangeAccent),
        ),
      ],
    );
  }
}
