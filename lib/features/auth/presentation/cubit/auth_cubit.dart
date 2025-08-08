import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/services/firebase_service.dart';
import 'package:se7ety/core/services/shared_prefs.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/auth/data/models/user_enum.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void login({
    required String emailAddress,
    required String password,
    required UserType usertype,
  }) async {
    emit(AuthLoading());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      User? user = credential.user;
      if (user != null) {
        SharedPrefs.saveUserId(userID: user.uid);
        await getUserData(usertype);
        emit(AuthSuccess(user: user));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthError(errorMessage: 'البريد الالكتروني غير مسجل'));
      } else if (e.code == 'wrong-password') {
        emit(AuthError(errorMessage: 'كلمة السر غير صحيحة'));
      } else if (e.code == 'invalid-credential') {
        emit(AuthError(errorMessage: 'خطأ في بيانات الدخول'));
      } else {
        emit(
          AuthError(errorMessage: 'حدث خطأ اثناء تسجيل الدخول ${e.message}'),
        );
      }
    } catch (e) {
      emit(AuthError(errorMessage: 'حدث خطأ غير متوقع${e.toString()}'));
    }
  }

  Future<void> getUserData(UserType usertype) async {
    if (usertype == UserType.doctor) {
      final userData = await FireBaseService.getDoctorData();
      if (userData.exists) {
        DoctorModel doctorModel = DoctorModel.fromJson(
          userData.data() as Map<String, dynamic>,
        );
        SharedPrefs.saveUserType(userType: usertype);
        bool isCompleted =
            (doctorModel.bio != null &&
                doctorModel.specialization != null &&
                doctorModel.openHour != null &&
                doctorModel.closeHour != null &&
                doctorModel.address != null &&
                doctorModel.phone1 != null);
        SharedPrefs.isDataCompleted(value: isCompleted);
      } else {
        SharedPrefs.remove(SharedPrefs.kUserID);
        SharedPrefs.remove(SharedPrefs.kUserType);
        throw FirebaseAuthException(code: 'user-not-found');
      }
    } else {
      final userData = await FireBaseService.getPatientData();
      if (userData.exists) {
        PatientModel patientModel = PatientModel.fromJson(
          userData.data() as Map<String, dynamic>,
        );
        SharedPrefs.saveUserType(userType: usertype);
        bool isCompleted =
            (patientModel.phone != null &&
                patientModel.age != null &&
                patientModel.bio != null &&
                patientModel.city != null);
        SharedPrefs.isDataCompleted(value: isCompleted);
      } else {
        SharedPrefs.remove(SharedPrefs.kUserID);
        SharedPrefs.remove(SharedPrefs.kUserType);

        throw FirebaseAuthException(code: 'user-not-found');
      }
    }
  }

  void register({
    required UserType userType,
    required String emailAddress,
    required String password,
    required String name,
  }) async {
    emit(AuthLoading());

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
      User? user = credential.user;
      if (userType == UserType.doctor) {
        await FireBaseService.createDoctor(
          doctorModel: DoctorModel(
            userId: user?.uid,
            name: name,
            email: emailAddress,
          ),
        );
      } else {
        await FireBaseService.createPatient(
          patientModel: PatientModel(
            userId: user?.uid,
            email: emailAddress,
            name: name,
          ),
        );
      }
      SharedPrefs.saveUserId(userID: user?.uid ?? ' ');
      user?.updateDisplayName(name);
      emit(AuthSuccess(user: user!));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthError(errorMessage: 'كلمة السر ضعيفة'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthError(errorMessage: 'البريد الالكتروني مستخدم بالفعل'));
      } else {
        emit(
          AuthError(errorMessage: 'حدث خطأ اثناء تسجيل الدخول ${e.message}'),
        );
      }
    } catch (e) {
      emit(AuthError(errorMessage: 'حدث خطأ غير متوقع${e.toString()}'));
    }
  }

  Future<void> registerDoctorData({required DoctorModel doctorModel}) async {
    emit(AuthLoading());
    try {
      FireBaseService.updateDoctorData(doctorModel: doctorModel);
      SharedPrefs.saveUserType(userType: UserType.doctor);
      SharedPrefs.isDataCompleted(value: true);
    } on FirebaseException catch (e) {
      emit(AuthError(errorMessage: 'حدث خطأ اثناء تسجيل الدخول ${e.message}'));
    } catch (e) {
      emit(AuthError(errorMessage: 'حدث خطأ غير متوقع${e.toString()}'));
    }
  }

  Future<void> registerPatientData({required PatientModel patientModel}) async {
    emit(AuthLoading());
    try {
      FireBaseService.updatePatientData(patientModel: patientModel);
      SharedPrefs.saveUserType(userType: UserType.patient);
      SharedPrefs.isDataCompleted(value: true);
    } on FirebaseException catch (e) {
      emit(AuthError(errorMessage: 'حدث خطأ اثناء تسجيل الدخول ${e.message}'));
    } catch (e) {
      emit(AuthError(errorMessage: 'حدث خطأ غير متوقع${e.toString()}'));
    }
  }
}
