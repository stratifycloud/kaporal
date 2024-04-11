import 'package:flutter/material.dart';
import 'package:kaporal/firebase_options.dart';
import 'package:kaporal/screens/auth/login_page.dart';
import 'package:kaporal/screens/auth/profile_page.dart';
import 'package:kaporal/screens/auth/register_page.dart';
import 'package:kaporal/screens/home/home_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaporal/ui_components/ui_specs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: Kaporal()));
}

class Kaporal extends StatelessWidget {
  const Kaporal({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kaporal',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: AppColors.richBlack,
            secondary: AppColors.aero,
            tertiary: AppColors.cadetGray,
            outline: AppColors.moonstone,
            error: AppColors.burntSienna),
      ),
      routes: {
          '/': (context) => const HomeWrapper(),
          // '/error': (context) => const ErrorPage(),
          '/login': (context) => const LoginPage(),
          '/profile': (context) => const ProfilePage(),
          '/register': (context) => const RegisterPage(),
        }
    );
  }
}