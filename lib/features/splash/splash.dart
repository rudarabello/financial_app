import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design_sys/colors.dart';
import 'splash_controller.dart';
import 'splash_states.dart';
import 'widgets/animated_logo.dart';
import 'widgets/app_progress.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Image _logo = Image.asset('assets/logo_white_flat.png');

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashController, SplashState>(
      listener: (context, state) {
        if (state is LoggedSplashState) {
          Navigator.of(context).pushReplacementNamed('/home-page');
        }
        if (state is UnloggedSplashState) {
          Navigator.of(context).pushReplacementNamed('/register-page');
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: AnimatedLogo(logo: _logo),
              ),
              const AppProgress(),
            ],
          ),
        ),
      ),
    );
  }
}
