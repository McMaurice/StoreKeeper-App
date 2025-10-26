import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storekepper_app/app/router.dart';
import 'package:storekepper_app/app/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Lock orientation to portrait up
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'StoreKepper App',
      theme: AppTheme.lightTheme,
    );
  }
}
