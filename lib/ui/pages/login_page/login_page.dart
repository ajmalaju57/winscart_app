import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winscart/ui/components/app_text.dart';
import 'package:winscart/ui/components/app_text_field.dart';
import 'package:winscart/ui/pages/login_page/login_cubit.dart';
import 'package:winscart/utils/color.dart';
import 'package:winscart/utils/extensions/space_ext.dart';
import 'package:winscart/utils/string.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => LoginCubit(context),
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              final cubit = context.read<LoginCubit>();
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        height: 250,
                        width: 230,
                        decoration: const BoxDecoration(
                          color: colorWhite,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Image.asset(
                          "${assetLocation}logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      50.hBox,
                      const Icon(
                        Icons.account_circle_outlined,
                        size: 50,
                        color: Colors.black38,
                        weight: 5,
                      ),
                      30.hBox,
                      Container(
                        height: 50,
                        width: 300,
                        decoration: _decoration(),
                        child: AppTextField(
                          controller: cubit.usernameCtrl,
                          hintText: enterEmail,
                          prefixIcons: Icons.mail_outline,
                        ),
                      ),
                      20.hBox,
                      Container(
                        height: 50,
                        width: 300,
                        decoration: _decoration(),
                        child: AppTextField(
                          controller: cubit.passCtrl,
                          hintText: password,
                          prefixIcons: Icons.lock_outlined,
                          obscureText: context.read<LoginCubit>().showHide ? true : false,
                          sufficIcon: context.read<LoginCubit>().showHide ? Icons.visibility_off : Icons.visibility,
                          sufixOnTap: () {
                            context.read<LoginCubit>().showHidePass(context.read<LoginCubit>().showHide ? false : true);
                          },
                        ),
                      ),
                      30.hBox,
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 45),
                          backgroundColor: colorWhite,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: () {
                          cubit.login();
                        },
                        child: AppText(
                          login.toUpperCase(),
                          color: Colors.black,
                          weight: FontWeight.w400,
                        ),
                      ),
                      30.hBox,
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

BoxDecoration _decoration() {
  return const BoxDecoration(
    color: colorWhite,
    borderRadius: BorderRadius.all(Radius.circular(16)),
  );
}
