import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inxpecta/features/authentication/providers/auth_provider.dart';
import 'package:inxpecta/features/authentication/widgets/sign_up.dart';
import 'package:inxpecta/features/home/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthStateProvider()), // Provide the AuthStateProvider
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "InXpecta"),
    );
  }
}
