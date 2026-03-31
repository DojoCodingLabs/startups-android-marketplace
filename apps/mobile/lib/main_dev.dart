/// Dev flavor entry point.
///
/// Run with: flutter run --target lib/main_dev.dart
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Initialize Supabase with dev project URL + anon key
  // TODO: Initialize Sentry with dev DSN

  runApp(const ProviderScope(child: DojoMarketplaceDevApp()));
}

class DojoMarketplaceDevApp extends StatelessWidget {
  const DojoMarketplaceDevApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dojo Marketplace (Dev)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC980FC)),
        fontFamily: 'SpaceGrotesk',
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Dojo Marketplace'),
              SizedBox(height: 8),
              Text('DEV', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
