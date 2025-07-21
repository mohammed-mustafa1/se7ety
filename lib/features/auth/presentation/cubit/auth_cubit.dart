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

  void login({required String emailAddress, required String password}) async {
    emit(AuthLoading());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      User? user = credential.user;
      SharedPrefs.saveUserId(userID: user?.uid ?? ' ');
      emit(AuthSuccess(user: user!));
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
}
