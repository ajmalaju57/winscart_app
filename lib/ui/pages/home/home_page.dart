import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winscart/data/shared_preferences/preference_functions.dart';
import 'package:winscart/ui/components/app_drawer/app_drawer.dart';
import 'package:winscart/ui/components/app_text.dart';
import 'package:winscart/ui/pages/home/cubit/home_cubit.dart';
import 'package:winscart/ui/pages/notification/notification_list.dart';
import 'package:winscart/utils/color.dart';
import 'package:winscart/utils/extensions/context_ext.dart';
import 'package:winscart/utils/extensions/space_ext.dart';
import 'package:winscart/utils/helpers/constant.dart';
import 'package:winscart/utils/helpers/helper_date_time.dart';
import 'package:winscart/utils/helpers/page_helpers.dart';
import 'package:winscart/utils/string.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocProvider(
        create: (context) => HomeCubit(context),
        child: Scaffold(
          drawer: const AppDrawer(),
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                SizedBox(
                  width: 100,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "${assetLocation}logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                context.isLandscape ? 250.wBox : 85.wBox,
                GestureDetector(
                  onTap: () {
                    Screen.open(context, const NotificationPage());
                  },
                  child: const Icon(
                    Icons.notifications_none_outlined,
                    color: black,
                  ),
                ),
                10.wBox,
                GestureDetector(
                  onTap: () {
                    showPopUp(context);
                  },
                  child: Row(
                    children: [
                      const AppText(logout, weight: FontWeight.w400),
                      5.wBox,
                      const Icon(
                        Icons.logout_outlined,
                        color: black,
                      ),
                    ],
                  ),
                ),
                20.wBox,
              ]),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is ProfileData) {
                  final userProfileData = state.profileData;
                  return Padding(
                    padding: const EdgeInsets.only(top: 5, left: 25, right: 20),
                    child: Column(
                      crossAxisAlignment: context.isLandscape
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        AppText(
                          "${greeting().toString()}, $currentUserName",
                          weight: FontWeight.bold,
                          size: context.isLandscape ? 25 : 18,
                        ),
                        10.hBox,
                        Container(
                          // margin: const EdgeInsets.only(right: 35),
                          height: context.isLandscape
                              ? context.deviceSize.height * 0.12
                              : size.height * 0.06,
                          decoration: BoxDecoration(
                              color: colorWhite,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: AppText(
                              "Date:- ${getFullDate(userProfileData.date.toString())} | Time:- ${userProfileData.time.toString().toUpperCase()}",
                              weight: FontWeight.bold,
                              size: context.isLandscape
                                  ? 20
                                  : size.height / 100 * 2,
                            ),
                          ),
                        ),
                        15.hBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: context.isLandscape
                                  ? context.deviceSize.height * 0.12
                                  : size.height * 0.06,
                              width: context.isLandscape
                                  ? context.deviceSize.width * 0.5
                                  : size.width * 0.5,
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: AppText(
                                  "Shipment in Hand",
                                  weight: FontWeight.bold,
                                  size: size.width * 0.04,
                                ),
                              ),
                            ),
                            20.wBox,
                            Container(
                              height: context.isLandscape
                                  ? 50
                                  : context.deviceSize.height * 0.06,
                              width: context.isLandscape
                                  ? 200
                                  : context.deviceSize.width * 0.25,
                              // height: 50,
                              // width: 200,
                              decoration: BoxDecoration(
                                color: colorWhite,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: AppText(
                                  userProfileData.shipmentInhand,
                                  size: context.isLandscape
                                      ? 35
                                      : size.height / 100 * 3.5,
                                  weight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        15.hBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: context.isLandscape
                                  ? context.deviceSize.height * 0.12
                                  : size.height * 0.06,
                              width: context.isLandscape
                                  ? context.deviceSize.width * 0.5
                                  : size.width * 0.5,
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: AppText(
                                  "Assigned Orders",
                                  weight: FontWeight.bold,
                                  size: size.width * 0.04,
                                ),
                              ),
                            ),
                            20.wBox,
                            Container(
                              height: context.isLandscape
                                  ? 50
                                  : context.deviceSize.height * 0.06,
                              width: context.isLandscape
                                  ? 200
                                  : context.deviceSize.width * 0.25,
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: AppText(
                                  userProfileData.asiignedOrders,
                                  weight: FontWeight.bold,
                                  size: context.isLandscape
                                      ? 35
                                      : size.height / 100 * 3.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        15.hBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: context.isLandscape
                                  ? context.deviceSize.height * 0.12
                                  : size.height * 0.06,
                              width: context.isLandscape
                                  ? context.deviceSize.width * 0.5
                                  : size.width * 0.5,
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: AppText(
                                  "Un Attended",
                                  weight: FontWeight.bold,
                                  size: size.width * 0.04,
                                ),
                              ),
                            ),
                            20.wBox,
                            Container(
                              height: context.isLandscape
                                  ? 50
                                  : context.deviceSize.height * 0.06,
                              width: context.isLandscape
                                  ? 200
                                  : context.deviceSize.width * 0.25,
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: AppText(
                                  userProfileData.unattented,
                                  weight: FontWeight.bold,
                                  size: context.isLandscape
                                      ? 35
                                      : size.height / 100 * 3.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        15.hBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: context.isLandscape
                                  ? context.deviceSize.height * 0.12
                                  : size.height * 0.06,
                              width: context.isLandscape
                                  ? context.deviceSize.width * 0.5
                                  : size.width * 0.5,
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: AppText(
                                  "Amount Collected",
                                  weight: FontWeight.bold,
                                  size: size.width * 0.04,
                                ),
                              ),
                            ),
                            20.wBox,
                            Container(
                              height: context.isLandscape
                                  ? 50
                                  : context.deviceSize.height * 0.06,
                              width: context.isLandscape
                                  ? 200
                                  : context.deviceSize.width * 0.25,
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: AppText(
                                  userProfileData.amountCollected,
                                  weight: FontWeight.bold,
                                  align: TextAlign.center,
                                  size: context.isLandscape
                                      ? 35
                                      : size.height / 100 * 3.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        15.hBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: context.isLandscape
                                  ? context.deviceSize.height * 0.12
                                  : size.height * 0.06,
                              width: context.isLandscape
                                  ? context.deviceSize.width * 0.5
                                  : size.width * 0.5,
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: AppText(
                                  "Delivery Charge",
                                  weight: FontWeight.bold,
                                  size: size.width * 0.04,
                                ),
                              ),
                            ),
                            20.wBox,
                            Container(
                              height: context.isLandscape
                                  ? 50
                                  : context.deviceSize.height * 0.06,
                              width: context.isLandscape
                                  ? 200
                                  : context.deviceSize.width * 0.25,
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: AppText(
                                  userProfileData.deliveryCharge,
                                  weight: FontWeight.bold,
                                  align: TextAlign.center,
                                  size: context.isLandscape
                                      ? 35
                                      : size.height / 100 * 3.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        15.hBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: context.isLandscape
                                  ? context.deviceSize.height * 0.12
                                  : size.height * 0.06,
                              width: context.isLandscape
                                  ? context.deviceSize.width * 0.5
                                  : size.width * 0.5,
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: AppText(
                                  "Settlement Amount",
                                  weight: FontWeight.bold,
                                  size: size.width * 0.04,
                                ),
                              ),
                            ),
                            20.wBox,
                            Container(
                              height: context.isLandscape
                                  ? 50
                                  : context.deviceSize.height * 0.06,
                              width: context.isLandscape
                                  ? 200
                                  : context.deviceSize.width * 0.25,
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: AppText(
                                  userProfileData.settlementAmount,
                                  weight: FontWeight.bold,
                                  size: context.isLandscape
                                      ? 35
                                      : size.height / 100 * 3.5,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }
                return const Center(child: CupertinoActivityIndicator());
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return FloatingActionButton(
                    backgroundColor: black,
                    onPressed: () {
                      context.read<HomeCubit>().scanQR();
                    },
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Image.asset(
                      "${assetLocation}scan.png",
                      fit: BoxFit.contain,
                      color: colorWhite,
                      height: 35,
                    ),
                  );
                },
              ),
              10.hBox,
              Container(
                width: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: colorWhite),
                child: const Center(
                    child: AppText(scanHere, weight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
