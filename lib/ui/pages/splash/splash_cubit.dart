import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:winscart/data/shared_preferences/preference_functions.dart';
import 'package:winscart/ui/pages/home/home_page.dart';
import 'package:winscart/ui/pages/login_page/login_page.dart';
import 'package:winscart/utils/helpers/page_helpers.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this.context) : super(SplashInitial()) {
    initPage();
  }

  final BuildContext context;

  initPage() async {
    dynamic userRoll = await SharedPref.getUserInfo();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (userRoll != null) {
          Screen.openAsNewPage(context, const HomePage());
        } else {
          Screen.openAsNewPage(context, const LoginPage());
        }
      },
    );
}
}
