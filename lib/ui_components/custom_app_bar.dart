import 'package:flutter/material.dart';
import 'package:kaporal/ui_components/custom_button.dart';
import 'package:kaporal/ui_components/ui_specs.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: AppColors.moonstone,
        leadingWidth: AppMargins.XXL,
        leading: TextButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, "/");
          },
          icon: const Icon(Icons.home_filled),
          label: const Text("Home")
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, "/profile");
            },
            icon: const Icon(Icons.person_pin),
            label: const Text("Profile")),
        ],
      );
  }
}