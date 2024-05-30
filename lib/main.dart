import 'package:flutter/material.dart';
import 'package:kaporal/firebase_options.dart';
import 'package:kaporal/providers/shared_preference_provider.dart';
import 'package:kaporal/screens/auth/login_page.dart';
import 'package:kaporal/screens/auth/profile_page.dart';
import 'package:kaporal/screens/auth/register_page.dart';
import 'package:kaporal/screens/capi/select_provider.dart';
import 'package:kaporal/screens/capi/create_cluster.dart';
import 'package:kaporal/screens/home/error.dart';
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

class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Eagerly initialize providers by watching them.
    // By using "watch", the provider will stay alive and not be disposed.
    final result = ref.watch(sharedPreferencesFutureProvider);

    // Handle error states and loading states
    if (result.isLoading) {
      return const CircularProgressIndicator();
    } else if (result.hasError) {
      return const Text('An error has ocurred');
    }
    return child;
  }
}

class Kaporal extends StatelessWidget {
  const Kaporal({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => _EagerInitialization(
        child: MaterialApp(
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
            '/error': (context) => const ErrorPage(),
            '/login': (context) => const LoginPage(),
            '/profile': (context) => const ProfilePage(),
            '/register': (context) => const RegisterPage(),
            '/create-cluster': (context) => const CreateClusterPage(),
            '/select-provider': (context) => const SelectProviderPage(),
          },
        ),
      );
}
