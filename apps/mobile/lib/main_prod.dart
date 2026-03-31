/// Prod flavor entry point.
///
/// Run with: flutter run --target lib/main_prod.dart --release
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Initialize Supabase with prod project URL + anon key
  // TODO: Initialize Sentry with prod DSN

  runApp(const ProviderScope(child: DojoMarketplaceProdApp()));
}

class DojoMarketplaceProdApp extends StatelessWidget {
  const DojoMarketplaceProdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dojo Marketplace',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC980FC)),
        fontFamily: 'SpaceGrotesk',
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Dojo Marketplace'),
        ),
      ),
    );
  }
}
