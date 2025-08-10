import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/core/utils/text_styles.dart';

showPickImageBottomSheet(
  context, {
  required void Function() onTapGallery,
  required void Function() onTapCamera,
}) => showModalBottomSheet(
  context: context,
  builder:
      (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('اختر صورة', style: TextStyles.getBody()),
            Gap(20),
            Flexible(child: MainButton(text: 'المعرض', onTap: onTapGallery)),
            Gap(20),
            Flexible(child: MainButton(text: 'الكاميرا', onTap: onTapCamera)),
          ],
        ),
      ),
);
