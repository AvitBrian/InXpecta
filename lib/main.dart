import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inxpecta/src/features/authentication/providers/auth_provider.dart';
import 'package:inxpecta/src/features/authentication/providers/connection_provider.dart';
import 'package:inxpecta/src/screens/splash_Screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) =>
                  AuthStateProvider()), // Provide the AuthStateProvider
          ChangeNotifierProvider(create: (context) => ConnectionProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
              useMaterial3: true,
              textTheme: GoogleFonts.poppinsTextTheme()),
          themeMode: ThemeMode.system,
          home: const SplashScreen(),
        ));
  }
}
