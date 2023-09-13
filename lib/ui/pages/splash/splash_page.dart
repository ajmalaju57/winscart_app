import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winscart/ui/components/app_splash_box.dart';
import 'package:winscart/ui/pages/splash/splash_cubit.dart';
import 'package:winscart/utils/color.dart';
import 'package:winscart/utils/string.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(context),
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          return AppSplashBox(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Container(
                  height: 160,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: colorWhite,
                  ),
                  child: Image.asset("${assetLocation}logo.png",
                      fit: BoxFit.contain)),
            )
          ]);
        },
      ),
    );
  }
}
