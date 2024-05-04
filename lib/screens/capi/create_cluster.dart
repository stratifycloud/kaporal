import 'package:flutter/material.dart';
import 'package:kaporal/ui_components/custom_app_bar.dart';
import 'package:kaporal/ui_components/custom_button.dart';
import 'package:kaporal/ui_components/custom_textfield.dart';
import 'package:kaporal/ui_components/ui_specs.dart';

class CreateClusterPage extends StatefulWidget {
  const CreateClusterPage({super.key});

  @override
  State<CreateClusterPage> createState() => _CreateClusterPageState();
}

class _CreateClusterPageState extends State<CreateClusterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/6, vertical: AppMargins.XXL),
        child: Column(
          children: [
            CustomTextField(label: "Cluster name"),

          ]
        )
      )
    );
  }
}