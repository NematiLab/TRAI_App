import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/app/home/bloc/home_bloc.dart';

/// A widget representing a unit in the home screen.
/// It displays a text and triggers a HomeEvent when tapped.
class HomeUnitWidget extends StatelessWidget {
  const HomeUnitWidget({required this.text, required this.event, super.key});

  final String text;
  final HomeEvent event;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        // Trigger the HomeBloc event when the unit is tapped
        context.read<HomeBloc>().add(event),
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          color: Colors.blue[100],
          border: Border.all(
            width: 2.sp,
          ),
        ),
        padding: EdgeInsets.all(8.sp),
        child: Center(
          // Display the text in the center of the unit
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }
}
