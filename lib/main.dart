import 'package:flutter/material.dart';
import 'package:navigation_bar/screens/bottomTabBar/FabTabsBar.dart';
import 'package:navigation_bar/screens/login/authPage.dart';
import 'package:navigation_bar/screens/login/loginPage.dart';
import 'package:navigation_bar/screens/drawer/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider()..initialize(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: provider.themeMode,
        //home: FabBar(selectedIndex: 0),
        //home: LoginPage(),
        home: const AuthPage(),
      );
    });
  }
}
