import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/login_page.dart';
import '../../features/splash/splash_sync_page.dart';
import '../providers.dart'; // aquí está tu authProvider

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    // Cargando
    if (auth.loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Error
    if (auth.error != null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Error de autenticación: ${auth.error}'),
          ),
        ),
      );
    }

    // No logueado
    if (!auth.loggedIn) {
      return const LoginPage();
    }

    // Logueado -> Sync master -> Templates
    return const SplashSyncPage();
  }
}


/*

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../session/session_providers.dart';
// importa tus pages reales:
import '../../features/auth/presentation/login_page.dart';
import '../../features/templates/presentation/templates_page.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(sessionProvider);

    return sessionAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error sesión: $e'))),
      data: (session) {
        if (session == null) {
          return const LoginPage();
        }

        // ✅ Si la sesión offline es válida: entra directo sin pedir login
        if (session.isOfflineValid) {
          return const TemplatesPage();
        }

        // ❌ Si expiró:
        // - Si no hay internet no podemos re-loguear, así que mostramos pantalla simple
        // (Luego podemos mejorar con connectivity_plus)
        return const _SessionExpiredPage();
      },
    );
  }
}

class _SessionExpiredPage extends StatelessWidget {
  const _SessionExpiredPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sesión expirada')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Tu sesión offline expiró. Conéctate a internet y vuelve a iniciar sesión.',
        ),
      ),
    );
  }
}
*/
