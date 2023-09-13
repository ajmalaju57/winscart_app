import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winscart/ui/components/app_button.dart';
import 'package:winscart/ui/components/app_text.dart';
import 'package:winscart/utils/color.dart';
import 'package:winscart/utils/helpers/helper_dialog.dart';
import 'package:winscart/utils/helpers/logout_cubit/logout_cubit.dart';
import 'package:winscart/utils/helpers/page_helpers.dart';
import 'package:winscart/utils/string.dart';

bool isLoading = false;

void showPopUp(BuildContext ctx) {
  showPopup(
    ctx,
    barrierDismissible: true,
    content: BlocProvider(
      create: (context) => LogoutCubit(ctx),
      child: BlocBuilder<LogoutCubit, LogoutState>(
        builder: (context, state) {
          return Container(
            height: 200,
            width: 270,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: black,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppText(
                  logoutDes1,
                  size: 20,
                  align: TextAlign.center,
                  color: colorWhite,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(
                      width: 95,
                      height: 31,
                      onPressed: () {
                        Screen.closeDialog(ctx);
                      },
                      text: "Cancel",
                      textColor: colorWhite,
                      btBgColor: grey,
                    ),
                    AppButton(
                      width: 95,
                      height: 31,
                      onPressed: () {
                        context.read<LogoutCubit>().logOut();
                      },
                      text: "Logout",
                      btBgColor: blue,
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    ),
    // ),
  );
}
