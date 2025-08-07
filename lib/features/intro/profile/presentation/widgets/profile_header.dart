import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety/components/buttons/camera_icon_button.dart';
import 'package:se7ety/core/function/show_bottom_sheet.dart';
import 'package:se7ety/core/services/firebase_service.dart';
import 'package:se7ety/core/services/upload_image.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/auth/presentation/widgets/profile_image.dart';

class ProfileHeaderSection extends StatefulWidget {
  const ProfileHeaderSection({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.location,
  });
  final String imageUrl;
  final String name;
  final String location;

  @override
  State<ProfileHeaderSection> createState() => _ProfileHeaderSectionState();
}

class _ProfileHeaderSectionState extends State<ProfileHeaderSection> {
  File? localImageFile;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Center(
          child: Stack(
            children: [
              ProfileImage(
                imageNetworkUrl: widget.imageUrl,
                imageFile: localImageFile ?? File(''),
              ),
              Positioned(
                bottom: 0,
                child: CameraIconButton(
                  onTap: () {
                    showPickImageBottomSheet(
                      context,
                      onTapCamera: () async {
                        final file = await updatePatientImage(
                          ImageSource.camera,
                        );
                        if (file != null) {
                          localImageFile = file;
                          context.pop();
                          setState(() {});
                        }
                      },
                      onTapGallery: () async {
                        final file = await updatePatientImage(
                          ImageSource.gallery,
                        );
                        if (file != null) {
                          localImageFile = file;
                          context.pop();
                          setState(() {});
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        Gap(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: TextStyles.getTitle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(16),
            Text(widget.location, style: TextStyles.getBody()),
          ],
        ),
      ],
    );
  }

  Future<File?> updatePatientImage(ImageSource source) async {
    var imageFile = await UploadImageService.pickImage(source: source);
    if (imageFile != null) {
      await UploadImageService.uploadToImageKit(imageFile).then((value) {
        FireBaseService.updatePatientData(
          patientModel: PatientModel(image: value),
        );
      });
      return imageFile;
    }
    return null;
  }
}
