import 'package:flutter/material.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/screens/login_screen.dart';

// Once you add a state-management package (Provider, per our earlier
// decision) and build out auth_controller.dart, this file is also where
// you'd wrap DokoApp in a ChangeNotifierProvider / MultiProvider so
// every screen below it can read the logged-in user's role, cart, etc.
//
// import 'package:provider/provider.dart';
// import 'features/auth/controllers/auth_controller.dart';

/// Root widget of the Doko app.
/// Holds the MaterialApp config — theme, title, and the first screen
/// shown on launch. As you add more screens, named routes can be
/// registered here too (see the commented `routes:` block below) instead
/// of navigating with raw MaterialPageRoute calls everywhere.
class DokoApp extends StatelessWidget {
  const DokoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      // The first screen a user sees. Swap this later for a small
      // "is the user already logged in?" check (reading from
      // AuthController / Firebase Auth) that decides between
      // LoginScreen and the role-specific home screen automatically.
      home: const LoginScreen(),

      // Optional: named routes, once you have more than a couple of
      // screens to navigate between. Each key here matches a route
      // name you'd call with Navigator.pushNamed(context, '/register').
      //
      // routes: {
      //   '/login': (context) => const LoginScreen(),
      //   '/register': (context) => const ShopOwnerRegisterScreen(),
      //   '/marketplace': (context) => const MarketplaceHomeScreen(),
      // },
    );
  }
}