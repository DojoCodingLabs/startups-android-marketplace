import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: DojoMarketplaceApp()));
}

class DojoMarketplaceApp extends StatelessWidget {
  const DojoMarketplaceApp({super.key});

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
