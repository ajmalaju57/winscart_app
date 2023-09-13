// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:winscart/data/shared_preferences/preference_functions.dart';
import 'package:winscart/ui/components/app_text.dart';
import 'package:winscart/ui/pages/home/home_page.dart';
import 'package:winscart/ui/pages/order_list/order_list.dart';
import 'package:winscart/utils/color.dart';
import 'package:winscart/utils/extensions/space_ext.dart';
import 'package:winscart/utils/helpers/constant.dart';
import 'package:winscart/utils/helpers/page_helpers.dart';
import 'package:winscart/utils/string.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static final menuItems = [
    "Home",
    "Assigned Orders",
    "Deliverd",
    "Reshedule",
    "Cancelled",
    "No Answer",
    "RTO",
    "Picked Up Orders",
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: InkWell(
                  onTap: () {
                    Screen.close(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: grey,
                  ),
                ),
              ),
              Center(
                child: Image.asset(
                  "${assetLocation}logo.png",
                  fit: BoxFit.contain,
                  height: 70,
                ),
              ),
              20.hBox,
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Row(
                  children: [
                    const Icon(
                      Icons.account_circle_outlined,
                      size: 50,
                    ),
                    SizedBox(
                      width: 200,
                      child: AppText(
                        currentUserName,
                        weight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        size: 17,
                      ),
                    )
                  ],
                ),
              ),
              25.hBox,
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: menuItems.length,
                  separatorBuilder: (context, index) => 0.hBox,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        selected(index, context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 63),
                        height: 50,
                        child: AppText(
                          menuItems[index],
                          size: 20,
                          weight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
              10.hBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 63),
                child: InkWell(
                  onTap: () {
                    showPopUp(context);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.logout,
                        color: grey,
                      ),
                      15.wBox,
                      const AppText(
                        "Logout",
                        size: 20,
                        color: grey,
                        weight: FontWeight.bold,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void selected(int index, BuildContext context) {
    switch (index) {
      case 0:
        Screen.openAsNewPage(context, const HomePage());
        break;
      case 1:
        Screen.open(
            context,
            const OrderListPage(
              orderStatus: "assigned_orders",
            ));
        break;
      case 2:
        Screen.open(
            context,
            const OrderListPage(
              orderStatus: "delivered_orders",
            ));
        break;
      case 3:
        Screen.open(
            context,
            const OrderListPage(
              orderStatus: "resheduled_orders",
            ));
        break;
      case 4:
        Screen.open(
            context,
            const OrderListPage(
              orderStatus: "cancelled_orders",
            ));
        break;
      case 5:
        Screen.open(
            context,
            const OrderListPage(
              orderStatus: "no_answer_orders",
            ));
        break;
      case 6:
        Screen.open(
            context,
            const OrderListPage(
              orderStatus: "rto_orders",
            ));
        break;
      case 7:
        Screen.open(
            context,
            const OrderListPage(
              orderStatus: "pickedup_orders",
            ));
        break;
    }
  }
}
