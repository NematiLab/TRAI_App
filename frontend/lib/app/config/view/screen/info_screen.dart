import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/app/config/bloc/config_bloc.dart';
import 'package:frontend/app/home/bloc/home_bloc.dart';
import 'package:frontend/design/theme/colors.dart'; // Assuming ColorsData is defined here

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _patientNameController;
  late final TextEditingController _triageNoteController;
  late final TextEditingController _patientHistoryController;

  @override
  void initState() {
    super.initState();
    _patientNameController = TextEditingController();
    _triageNoteController = TextEditingController();
    _patientHistoryController = TextEditingController();
    // Initialize the ConfigBloc to load existing configuration if available
    context.read<ConfigBloc>().add(ConfigPageInitiateEvent());
  }

  @override
  void dispose() {
    _patientNameController.dispose();
    _triageNoteController.dispose();
    _patientHistoryController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<ConfigBloc>().add(
            UpdateConfigEvent(
              patientName: _patientNameController.text,
              triageNote: _triageNoteController.text,
              patientHistory: _patientHistoryController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          context.read<HomeBloc>().add(HomePageInitiateEvent());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Info Screen',
            style: TextStyle(fontSize: 20.sp),
          ),
        ),
        body: BlocConsumer<ConfigBloc, ConfigState>(
          listenWhen: (previous, current) => current is ConfigActionState,
          buildWhen: (previous, current) => current is! ConfigActionState,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ConfigLoadedState) {
              _triageNoteController.text = state.triageNote;
              _patientHistoryController.text = state.patientHistory;
              _patientNameController.text = state.patientName;
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Patient Name Field
                        Text(
                          'Patient Name',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _patientNameController,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            hintText: "Patient Name",
                            hintStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.sp),
                              ),
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.sp),
                              ),
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16.sp),
                          ),
                          style: const TextStyle(color: Colors.black),
                          cursorColor: ColorsData.appBarColor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter Patient Name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                        // Triage Note Field
                        Text(
                          'Triage Note',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          controller: _triageNoteController,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            hintText: "Triage Note",
                            hintStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.sp),
                              ),
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.sp),
                              ),
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16.sp),
                          ),
                          style: const TextStyle(color: Colors.black),
                          cursorColor: ColorsData.appBarColor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter Triage Note";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                        // Patient History Field
                        Text(
                          'Patient History',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          maxLines: 10,
                          keyboardType: TextInputType.text,
                          controller: _patientHistoryController,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            hintText: "Patient History",
                            hintStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.sp),
                              ),
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.sp),
                              ),
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16.sp),
                          ),
                          style: const TextStyle(color: Colors.black),
                          cursorColor: ColorsData.appBarColor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter Patient History";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24.h),
                        GestureDetector(
                          onTap: _onSubmit,
                          child: Container(
                            height: 45.sp,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ColorsData.appBarColor,
                              borderRadius: BorderRadius.circular(12.sp),
                            ),
                            child: Center(
                              child: Text(
                                "Update",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
