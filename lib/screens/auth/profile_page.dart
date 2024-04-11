import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaporal/services/auth.dart';
import 'package:kaporal/ui_components/profile_picture.dart';
import 'package:kaporal/ui_components/ui_specs.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool editable = false;
  late User? user;

  double widgetWidthRatio = 1.25;
  @override
  Future<void> initState() async {
    super.initState();
    user = await AuthService.user.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            const SizedBox(
              height: 50,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ProfilePicture()],
            ),
            const Padding(padding: EdgeInsets.all(AppMargins.XS)),
            SizedBox(
              width: MediaQuery.of(context).size.width / widgetWidthRatio,
              child: TextField(
                enabled: false,
                textAlign: TextAlign.center,
                controller:
                    TextEditingController(text: user != null ? user!.email : ''),
              )
            ),
            const Padding(padding: EdgeInsets.all(AppMargins.S)),
            SizedBox(
              width: MediaQuery.of(context).size.width / widgetWidthRatio,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                    child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.burntSienna),
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    await AuthService.signOut();
                    if (mounted) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false);
                    }
                  },
                  label: const Text(
                    'Sign-out',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                )),
              ]),
            ),
            const Padding(padding: EdgeInsets.all(AppMargins.L)),
          ])),
    );
  }
}
