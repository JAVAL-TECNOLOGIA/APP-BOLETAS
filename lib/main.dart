import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';

void main() {
  runApp(const ProviderScope(child: DonLuisApp()));
}
/*
import 'package:flutter/material.dart';
import 'features/auth/presentation/login_page.dart';
import 'features/auth/presentation/splash_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';

void main() {
  runApp(const ProviderScope(child: DonLuisApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(next: const LoginPage()),
    );
  }
}*/

