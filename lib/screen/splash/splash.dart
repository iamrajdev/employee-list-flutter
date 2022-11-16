import 'dart:async';

import 'package:employee_info/helper/utils.dart';
import 'package:employee_info/screen/resources/assets_manager.dart';
import 'package:employee_info/screen/resources/route_manager.dart';
import 'package:employee_info/screen/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), () {
      _navigateToHome();
    });
  }

  _goNext() {
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }

  _goHome() {
    Navigator.pushReplacementNamed(context, Routes.mainRoute);
  }

  _navigateToHome() async {
    final isEmail = await getString(AppStrings.email);
    final isPassword = await getString(AppStrings.password);
    if (isEmail.isNotEmpty && isPassword.isNotEmpty) {
      _goHome();
    } else {
      _goNext();
    }
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(ImageAssets.splashLogo),
        ),
      ),
    );
  }
}
