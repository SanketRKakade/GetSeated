import 'package:app_frontend/core/theme/getSeatedTheme.dart';
import 'package:app_frontend/features/authentication/ui/sign_in.dart';
import 'package:app_frontend/features/home_page/ui/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: get_seated_theme,
      home: SignInPage(),
    );
  }
}
