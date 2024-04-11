import 'package:flutter/material.dart';
import 'package:kaporal/ui_components/ui_specs.dart';

class CustomButton extends StatefulWidget {
  final bool isPrimary;
  final String text;
  final VoidCallback onPressed;
  const CustomButton(
      {super.key,
      this.isPrimary = true,
      this.text = "",
      required this.onPressed});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.all(AppMargins.S),
            minimumSize: const Size(130, 45),
            backgroundColor:
                widget.isPrimary ? AppColors.aero : AppColors.richBlack,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0))),
        child: Text(
          widget.text,
          style: const TextStyle(fontSize: AppFontSizes.M),
        ));
  }
}