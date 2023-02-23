import 'package:ez_bank/firebase_options.dart';
import 'package:ez_bank/screens/Profile.dart';
import 'package:ez_bank/repository/authRepository.dart';
import 'package:ez_bank/screens/AboutScreen.dart';
import 'package:ez_bank/screens/BillingScreen.dart';
import 'package:ez_bank/screens/EditProfileScreen.dart';
import 'package:ez_bank/screens/HelpScreen.dart';
import 'package:ez_bank/screens/SettingsScreen.dart';
import 'package:ez_bank/screens/TransactionsScreen.dart';
import 'package:ez_bank/utils/theme.dart';
import 'package:ez_bank/utils/theme_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'screens/HomeScreen.dart';
import 'screens/LoginScreen.dart';
import 'screens/SignupScreen.dart';
import 'screens/WelcomeScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthRepository()));
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(App());
}

ThemeManager themeManager = ThemeManager();

class App extends StatefulWidget {
  App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    themeManager.addListener(themeListener);
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/help': (context) => HelpScreen(),
        '/about': (context) => AboutScreen(),
        '/billing': (context) => BillingScreen(),
        '/settings': (context) => SettingsScreen(),
        '/edit': (context) => UpdateProfileScreen(),
        '/transactions': (context) => TransactionsScreen(),
      },
      title: 'EZ Bank',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeManager.themeMode,
      home: WelcomeScreen(),
    );
  }
}
