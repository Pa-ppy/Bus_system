import 'package:app/screens/scaffolds/screen_scaffold.dart';
import 'package:app/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/splash_screen.dart';
import 'package:app/screens/welcome_screen.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/otp_screen.dart';
import 'package:app/screens/registration_screen.dart';

const String splashRoute = '/';
const String welcomeRoute = '/welcome';
const String registrationRoute = '/register';
const String otpRoute = '/otp';
const String loginRoute = '/login';
const String homeRoute = '/home';
const String mapRoute = '/mapscreen';
const String settingsRoute = '/settings_screen';

final Map<String, WidgetBuilder> routes = {
  splashRoute: (context) => const SplashScreen(),
  welcomeRoute: (context) => const WelcomeScreen(),
  registrationRoute: (context) => const RegistrationScreen(),
  otpRoute: (context) => const otpscreen(),
  loginRoute: (context) => const LoginScreen(),
  homeRoute: (context) => const HomeScreen(),
  mapRoute: (context) => const ScreenScaffold(),
  settingsRoute: (context) => const SettingsScreen(),
};
