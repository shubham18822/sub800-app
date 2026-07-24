import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/welcome_back_screen.dart';
import '../screens/auth/create_password_screen.dart';
import '../screens/auth/loading_screen.dart';
import '../screens/auth/create_account_screen.dart';
import '../screens/auth/office_interests_screen.dart';
import '../screens/auth/landing_screen.dart';
import '../screens/main_shell_screen.dart';
import '../screens/search/search_screen.dart';

class Routes {
  static const String landing = '/landing';
  static const String login = '/login';
  static const String welcomeBack = '/welcome_back';
  static const String createPassword = '/create_password';
  static const String loading = '/loading';
  static const String createAccount = '/create_account';
  static const String officeInterests = '/office_interests';
  static const String home = '/home';
  static const String search = '/search';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      landing: (context) => const LandingScreen(),
      login: (context) => const LoginScreen(),
      welcomeBack: (context) => const WelcomeBackScreen(),
      createPassword: (context) => const CreatePasswordScreen(),
      loading: (context) => const LoadingScreen(),
      createAccount: (context) => const CreateAccountScreen(),
      officeInterests: (context) => const OfficeInterestsScreen(),
      home: (context) => const MainShellScreen(),
      search: (context) => const SearchScreen(),
    };
  }
}


