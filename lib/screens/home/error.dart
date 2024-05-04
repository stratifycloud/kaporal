import 'package:flutter/material.dart';
import 'package:kaporal/ui_components/custom_app_bar.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final String errorMessage = arguments['message'];
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Text("An error occured: $errorMessage"),
      ),
    );
  }
}
