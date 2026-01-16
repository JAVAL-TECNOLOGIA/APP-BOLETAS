import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers.dart';
import '../features/auth/presentation/login_page.dart';
import '../features/home/home_page.dart';
import '../features/splash/splash_page.dart';

class DonLuisApp extends ConsumerStatefulWidget {
  const DonLuisApp({super.key});

  @override
  ConsumerState<DonLuisApp> createState() => _DonLuisAppState();
}

class _DonLuisAppState extends ConsumerState<DonLuisApp> {
  bool _showSplash = true;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    Widget screen;
    if (_showSplash) {
      screen = SplashPage(
        onFinish: () => setState(() => _showSplash = false),
      );
    } else {
      screen = auth.loggedIn ? const HomePage() : const LoginPage();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: screen,
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers.dart';
import '../features/auth/presentation/login_page.dart';
import '../features/home/home_page.dart';

class DonLuisApp extends ConsumerWidget {
  const DonLuisApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: auth.loggedIn ? const HomePage() : const LoginPage(),
    );
  }
}
*/
