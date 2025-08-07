import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety/components/buttons/camera_icon_button.dart';
import 'package:se7ety/core/function/show_bottom_sheet.dart';
import 'package:se7ety/core/services/firebase_service.dart';
import 'package:se7ety/core/services/shared_prefs.dart';
import 'package:se7ety/core/services/upload_image.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/auth/data/models/user_enum.dart';
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
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Center(
          child: Stack(
            children: [
              isLoading
                  ? SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(),
                  )
                  : ProfileImage(
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
                        final file = await updateUserImage(ImageSource.camera);
                        if (file != null) {
                          localImageFile = file;
                        }
                      },
                      onTapGallery: () async {
                        final file = await updateUserImage(ImageSource.gallery);
                        if (file != null) {
                          localImageFile = file;
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

  Future<File?> updateUserImage(ImageSource source) async {
    var imageFile = await UploadImageService.pickImage(source: source);
    if (imageFile != null) {
      setState(() {
        isLoading = true;
      });
      context.pop();
      await UploadImageService.uploadToImageKit(imageFile).then((value) {
        SharedPrefs.getUserType() == UserType.patient.name
            ? FireBaseService.updatePatientData(
              patientModel: PatientModel(image: value),
            )
            : FireBaseService.updateDoctorData(
              doctorModel: DoctorModel(image: value),
            );
        setState(() {
          isLoading = false;
        });
      });
      return imageFile;
    }
    return null;
  }
}
