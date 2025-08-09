part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<DoctorModel>? doctors;
  HomeSuccess({this.doctors});
}

final class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
