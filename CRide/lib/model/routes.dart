import 'package:app/screens/scaffolds/passenger_screen_scaffold.dart';
import 'package:app/screens/settings_screen.dart';
import 'package:app/screens/waiting_mapscreen.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/splash_screen.dart';
import 'package:app/screens/welcome_screen.dart';
import 'package:app/screens/choose_mode.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/otp_screen.dart';
import 'package:app/screens/registration_screen.dart';
import 'package:app/screens/passenger_mode.dart';
import 'package:app/screens/waiting_mode.dart';

const String splashRoute = '/';
const String welcomeRoute = '/welcome';
const String registrationRoute = '/register';
const String otpRoute = '/otp';
const String loginRoute = '/login';
const String chooseModeRoute = '/choose_mode';
const String homeRoute = '/home';
const String passengerModeRoute = '/passenger_mode';
const String waitingModeRoute = '/waiting_mode';
const String passMapRoute = '/passenger_mapscreen';
const String waitMapRoute = '/waiting_mapscreen';
const String gMap = '/google_map';
const String settingsRoute = '/settings_screen';

final Map<String, WidgetBuilder> routes = {
  splashRoute: (context) => const SplashScreen(),
  welcomeRoute: (context) => const WelcomeScreen(),
  registrationRoute: (context) => const RegistrationScreen(),
  otpRoute: (context) => const otpscreen(),
  loginRoute: (context) => const LoginScreen(),
  chooseModeRoute: (context) => const ChooseModeScreen(),
  homeRoute: (context) => const HomeScreen(),
  passengerModeRoute: (context) => const PassengerModeScreen(),
  waitingModeRoute: (context) => const WaitingModeScreen(),
  passMapRoute: (context) => const ScreenScaffold(),
  settingsRoute: (context) => const SettingsScreen(),
  waitMapRoute: (context) => const WaitingMapScreen(),
};
