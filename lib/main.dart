import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inxpecta/src/features/authentication/providers/auth_provider.dart';
import 'package:inxpecta/src/features/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => AuthStateProvider()), // Provide the AuthStateProvider
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme()),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}
