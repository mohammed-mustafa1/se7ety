import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/components/custom_error_widget.dart';
import 'package:se7ety/features/doctor/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:se7ety/features/doctor/home/presentation/widgets/card.dart';

class TopCards extends StatelessWidget {
  const TopCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();
        if (state is HomeLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is HomeError) {
          return CustomErrorWidget(message: state.message);
        } else if (state is HomeSuccess) {
          return Row(
            spacing: 12,
            children: [
              TopCard(
                backgroundColor: Colors.blue,
                value: cubit.allAppointments.length.toString(),
                name: 'اجمال الحجوزات',
                icon: Icons.calendar_month_rounded,
              ),

              TopCard(
                backgroundColor: Colors.orange,
                value: cubit.patients.length.toString(),
                name: 'اجمال المرضي',
                icon: Icons.people,
              ),
              TopCard(
                backgroundColor: Colors.green,
                value: cubit.todayAppointments.length.toString(),
                name: 'حجوزات اليوم',
                icon: Icons.calendar_today_rounded,
              ),
            ],
          );
        } else {
          return Text('لا توجد بيانات');
        }
      },
    );
  }
}
