// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winscart/ui/components/app_button.dart';
import 'package:winscart/ui/components/app_text.dart';
import 'package:winscart/ui/components/app_text_field.dart';
import 'package:winscart/ui/pages/VoiceSctionCanceled/voice_sction.dart';
import 'package:winscart/ui/pages/VoiceSctionNoAnswer/voice_sction.dart';
import 'package:winscart/ui/pages/VoiceSctionReshedule/voice_sction.dart';
import 'package:winscart/ui/pages/common_page/cubit/common_cubit.dart';
import 'package:winscart/ui/pages/home/home_page.dart';
import 'package:winscart/utils/color.dart';
import 'package:winscart/utils/extensions/space_ext.dart';
import 'package:winscart/utils/helpers/page_helpers.dart';
import 'package:winscart/utils/string.dart';

class CommonPage extends StatelessWidget {
  const CommonPage({
    super.key,
    required this.titile,
    required this.icon,
    required this.orderId,
    required this.status,
    this.isReshedule = false,
    this.isDelivered = false,
  });

  final String titile;
  final Icon icon;
  final bool isReshedule;
  final bool isDelivered;
  final String orderId;
  final String status;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => CommonCubit(context, orderId, status),
        child: BlocBuilder<CommonCubit, CommonState>(
          builder: (context, state) {
            return Scaffold(
              body: Center(
                child: isReshedule
                    ? Container(
                        // height: 430,
                        width: 325,
                        decoration: _decoration(),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const Icon(Icons.event_repeat_outlined, color: black, size: 40),
                                const AppText(
                                  rescheduleDelivery,
                                  size: 22,
                                  color: black,
                                  weight: FontWeight.bold,
                                ),
                                5.hBox,
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: grey,
                                      width: 1,
                                    ),
                                  ),
                                  child: AppTextField(
                                    controller: context.read<CommonCubit>().selectDatetext,
                                    hintText: rescheduledDate,
                                    sufficIcon: Icons.calendar_month_outlined,
                                    sufficIconSize: 20,
                                    sufixOnTap: () {
                                      context.read<CommonCubit>().selectDate();
                                    },
                                    readOnly: true,
                                  ),
                                ),
                                15.hBox,
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: grey,
                                      width: 1,
                                    ),
                                  ),
                                  child: AppTextField(
                                    controller: context.read<CommonCubit>().ctrl,
                                    maxLine: 3,
                                    hintText: note,
                                    maxLength: 1000,
                                  ),
                                ),
                                15.hBox,
                                const VoiceSctionReshedule(),
                                30.hBox,
                                AppButton(
                                  onPressed: () {
                                    context.read<CommonCubit>().changeOrderStatus();
                                  },
                                  height: 45,
                                  width: 120,
                                  btBgColor: primaryColor,
                                  textColor: black,
                                  text: submit,
                                  fontSize: 18,
                                  borderRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : isDelivered
                        ? Container(
                            // height: 240,
                            width: 300,
                            decoration: _decoration(),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const Icon(Icons.done_all_outlined, color: primaryColor, size: 70),
                                  const AppText(
                                    success,
                                    size: 30,
                                    color: black,
                                    weight: FontWeight.bold,
                                  ),
                                  const AppText(
                                    successText,
                                    size: 18,
                                    maxLines: 2,
                                    align: TextAlign.center,
                                    color: grey,
                                  ),
                                  8.hBox,
                                  Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: AppButton(
                                      onPressed: () {
                                        Screen.openAsNewPage(context, const HomePage());
                                      },
                                      height: 45,
                                      width: 120,
                                      btBgColor: primaryColor,
                                      textColor: black,
                                      text: oky,
                                      fontSize: 18,
                                      borderRadius: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            // height: 370,
                            width: 340,
                            decoration: _decoration(),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  20.hBox,
                                  icon,
                                  10.hBox,
                                  AppText(
                                    titile,
                                    weight: FontWeight.bold,
                                    size: 25,
                                  ),
                                  10.hBox,
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16, right: 16),
                                    child: Container(
                                      decoration: BoxDecoration(border: Border.all(color: grey), borderRadius: BorderRadius.circular(12)),
                                      child: AppTextField(
                                        maxLine: 3,
                                        maxLength: 1000,
                                        inputType: TextInputType.multiline,
                                        controller: context.read<CommonCubit>().ctrl,
                                        hintText: 'Notes',
                                      ),
                                    ),
                                  ),
                                  10.hBox,
                                  status == "NO ANSWER" ? VoiceSctionNoAnswer() : VoiceSctionCanceled(),
                                  15.hBox,
                                  Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: AppButton(
                                      onPressed: () {
                                        context.read<CommonCubit>().changeOrderStatus();
                                      },
                                      height: 45,
                                      width: 120,
                                      btBgColor: primaryColor,
                                      textColor: black,
                                      text: submit,
                                      fontSize: 18,
                                      borderRadius: 10,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
              ),
            );
          },
        ),
      ),
    );
  }
}

BoxDecoration _decoration() {
  return BoxDecoration(
    color: colorWhite,
    borderRadius: BorderRadius.circular(16),
  );
}
