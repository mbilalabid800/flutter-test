import 'package:cartzilla/providers/product_provider.dart';
import 'package:cartzilla/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProductProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cartzilla',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      initialRoute: '/splash-screen',
      routes: {
        '/splash-screen': (context) => const SplashScreen(),
        '/home-screen': (BuildContext context) => const HomeScreen(),
        // '/print-example': (BuildContext context) => PrintExample(),
      },
    );
  }
}
