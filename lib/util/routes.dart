import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_fitness/model/user_model.dart';
import 'package:student_fitness/pages/goal_page.dart';
import 'package:student_fitness/pages/on_boarding_page.dart';
import 'package:student_fitness/pages/profile_edit_page.dart';
import 'package:student_fitness/pages/sign_in_page.dart';
import 'package:student_fitness/pages/sign_up_page.dart';
import 'package:student_fitness/pages/splash_page.dart';
import 'package:student_fitness/pages/welcome_page.dart';

class Routes {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String onBoarding = '/on-boarding';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String welcome = '/welcome';
  static const String profileEdit = '/profile-edit';
  static const String goal = '/goal';

  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getOnBoardingRoute() => onBoarding;
  static String getSignInRoute() => signIn;
  static String getSignUpRoute() => signUp;
  static String getProfileEditRoute(UserModel user, bool fromProfile) {
    String _data = base64Url.encode(utf8.encode(jsonEncode(user.toJson(false))));
    return '$profileEdit?user=$_data&page=${fromProfile ? 'profile' : 'signup'}';
  }
  static String getGoalRoute(UserModel user) {
    String _data = base64Url.encode(utf8.encode(jsonEncode(user.toJson(false))));
    return '$goal?user=$_data';
  }
  static String getWelcomeRoute(UserModel user) {
    String _data = base64Url.encode(utf8.encode(jsonEncode(user.toJson(false))));
    return '$welcome?user=$_data';
  }

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => Scaffold(body: Container(alignment: Alignment.center, child: const Text('Home Page')))),
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: onBoarding, page: () => const OnBoardingPage()),
    GetPage(name: signIn, page: () => const SignInPage()),
    GetPage(name: signUp, page: () => const SignUpPage()),
    GetPage(name: profileEdit, page: () {
      UserModel _data = UserModel.fromJson(
        jsonDecode(utf8.decode(base64Decode(Get.parameters['user']!.replaceAll(' ', '+')))), false,
      );
      return ProfileEditPage(user: _data, fromProfile: Get.parameters['page'] == 'profile');
    }),
    GetPage(name: goal, page: () {
      UserModel _data = UserModel.fromJson(
        jsonDecode(utf8.decode(base64Decode(Get.parameters['user']!.replaceAll(' ', '+')))), false,
      );
      return GoalPage(user: _data);
    }),
    GetPage(name: welcome, page: () {
      UserModel _data = UserModel.fromJson(
        jsonDecode(utf8.decode(base64Decode(Get.parameters['user']!.replaceAll(' ', '+')))), false,
      );
      return WelcomePage(user: _data);
    }),
  ];
}