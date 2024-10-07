import 'package:flutter/material.dart';
import 'package:recipe_app/pages/home_page.dart';
import 'package:recipe_app/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/home',
        debugShowCheckedModeBanner: false,
        title: "Recipe",
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepOrange,
            ),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            )),
        routes: {
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage()
        });
  }
}
