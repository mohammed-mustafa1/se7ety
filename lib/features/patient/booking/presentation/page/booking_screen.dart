import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/components/inputs/main_text_form_field.dart';
import 'package:se7ety/components/dialogs/main_dialog.dart';
import 'package:se7ety/core/extensions/navigation.dart';
import 'package:se7ety/core/routers/app_routers.dart';
import 'package:se7ety/core/services/firebase_service.dart';
import 'package:se7ety/core/services/shared_prefs.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/patient/booking/data/model/appointment_model.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/doctor_card.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key, required this.doctor});
  final DoctorModel doctor;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  TextEditingController dateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<DateTime> times = [];
  DateTime selectedDate = DateTime.now().copyWith(
    hour: 0,
    minute: 0,
    second: 0,
  );
  PatientModel patient = PatientModel();
  @override
  void initState() {
    super.initState();
    FireBaseService.getPatientData().then((value) {
      if (value.exists) {
        patient = PatientModel.fromJson(value.data()! as Map<String, dynamic>);
        nameController.text = patient.name ?? '';
        ageController.text = patient.age.toString();
        phoneController.text = patient.phone ?? '';
      }
    });
    times = getAvailableTimes(
      startTime: widget.doctor.openHour!,
      endTime: widget.doctor.closeHour!,
      selectedDate: selectedDate,
    );
    dateController.text = DateFormat('dd-MM-yyyy', 'en').format(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('احجز مع دكتورك')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: BouncingScrollPhysics(),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DoctorCard(doctor: widget.doctor),
                      Center(
                        child: Text(
                          '--ادخل بيانات الحجز--',
                          style: TextStyles.getTitle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text('اسم المريض', style: TextStyles.getBody()),
                      MainTextFormField(
                        controller: nameController,
                        hintText: 'اسم المريض',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك ادخل الاسم';
                          }
                          return null;
                        },
                      ),
                      Text('عمر المريض', style: TextStyles.getBody()),
                      MainTextFormField(
                        maxLength: 2,
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        hintText: 'عمر المريض',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك ادخل العمر';
                          }
                          return null;
                        },
                      ),
                      Text('رقم الهاتف', style: TextStyles.getBody()),
                      MainTextFormField(
                        controller: phoneController,
                        hintText: 'رقم الهاتف',
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك ادخل رقم الهاتف';
                          } else if (value.length != 11) {
                            return 'من فضلك ادخل رقم هاتف صحيح';
                          }
                          return null;
                        },
                      ),
                      Text('وصف الحالة', style: TextStyles.getBody()),
                      MainTextFormField(
                        controller: descriptionController,
                        hintText: 'وصف الحالة',
                        maxLines: 6,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك ادخل وصف الحالة';
                          }
                          return null;
                        },
                      ),
                      Text('تاريخ الحجز', style: TextStyles.getBody()),
                      MainTextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك اختر تاريخ الحجز';
                          }
                          return null;
                        },
                        controller: dateController,
                        suffixIcon: IconButton.filled(
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            showDatePickerAndGetAvilableTimes(context);
                          },
                          icon: Icon(
                            Icons.calendar_month,
                            color: AppColors.whiteColor,
                            size: 32,
                          ),
                        ),
                        onTap: () {
                          showDatePickerAndGetAvilableTimes(context);
                        },
                        hintText: 'تاريخ الحجز',
                        readOnly: true,
                      ),

                      Text('وقت الحجز', style: TextStyles.getBody()),
                      times.isEmpty
                          ? Text(
                            'لا يوجد وقت متاح',
                            style: TextStyles.getBody(color: Colors.red),
                          )
                          : Wrap(
                            spacing: 16,

                            children:
                                times.map((time) {
                                  return ChoiceChip(
                                    onSelected: (value) {
                                      setState(() {
                                        selectedDate = time;
                                      });
                                    },

                                    selectedColor: AppColors.primaryColor,
                                    backgroundColor: AppColors.accentColor,
                                    side: BorderSide.none,
                                    checkmarkColor: AppColors.whiteColor,
                                    label: Text(
                                      TimeOfDay.fromDateTime(
                                        time,
                                      ).format(context),
                                      style: TextStyles.getBody(
                                        color:
                                            selectedDate.hour == time.hour
                                                ? AppColors.whiteColor
                                                : AppColors.darkColor,
                                      ),
                                    ),
                                    selected: selectedDate.hour == time.hour,
                                  );
                                }).toList(),
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: MainButton(
          onTap: () async {
            if (formKey.currentState!.validate() && selectedDate.hour == 0) {
              showMainSnackBar(
                context,
                text: 'من فضلك اختر وقت الحجز',
                type: DialogType.error,
              );
            } else if (formKey.currentState!.validate() &&
                selectedDate.hour != 0) {
              showLoadingDialog(context);
              await FireBaseService.createAppointment(
                appointmentModel: AppointmentModel(
                  patientId: SharedPrefs.getUserID(),
                  doctorId: widget.doctor.userId,
                  patientName: nameController.text,
                  phone: phoneController.text,
                  description: descriptionController.text,
                  doctorName: widget.doctor.name,
                  location: widget.doctor.address,
                  date: Timestamp.fromDate(selectedDate),
                  isComplete: false,
                  rating: null,
                  patientAge: int.parse(ageController.text),
                ),
              ).then((value) {
                showAlertDialog(
                  context,
                  text: 'تم الحجز بنجاح',
                  type: DialogType.success,
                  onTap: () {
                    context.pushToBase(AppRouter.mainScreen);
                  },
                );
              });
            }
          },
          text: 'تأكيد الحجز',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void showDatePickerAndGetAvilableTimes(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) return;
      dateController.text = DateFormat('dd-MM-yyyy', 'en').format(value);
      times = getAvailableTimes(
        startTime: widget.doctor.openHour!,
        endTime: widget.doctor.closeHour!,
        selectedDate: value,
      );
      setState(() {});
    });
  }
}

List<DateTime> getAvailableTimes({
  required Timestamp startTime,
  required Timestamp endTime,
  required DateTime selectedDate,
}) {
  TimeOfDay start = TimeOfDay.fromDateTime(startTime.toDate());
  TimeOfDay end = TimeOfDay.fromDateTime(endTime.toDate());
  bool isToday =
      DateTime.now().year == selectedDate.year &&
      DateTime.now().month == selectedDate.month &&
      DateTime.now().day == selectedDate.day;
  List<DateTime> avilableTimes = [];

  for (int i = start.hour; i < end.hour; i++) {
    if (isToday) {
      if (i > DateTime.now().hour) {
        avilableTimes.add(selectedDate.copyWith(hour: i, minute: 0));
      }
    } else {
      avilableTimes.add(selectedDate.copyWith(hour: i, minute: 0));
    }
  }
  return avilableTimes;
}
