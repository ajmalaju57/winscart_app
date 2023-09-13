import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:winscart/data/model/assigned_orders.dart';
import 'package:winscart/ui/components/app_button.dart';
import 'package:winscart/ui/components/app_drawer/app_drawer.dart';
import 'package:winscart/ui/components/app_text.dart';
import 'package:winscart/ui/pages/common_page/common_page.dart';
import 'package:winscart/ui/pages/common_page/cubit/common_cubit.dart';
import 'package:winscart/ui/pages/home/home_page.dart';
import 'package:winscart/ui/pages/order_list/assigned_order_list_cubit.dart';
import 'package:winscart/ui/pages/order_details/order_details_page.dart';
import 'package:winscart/utils/color.dart';
import 'package:winscart/utils/extensions/space_ext.dart';
import 'package:winscart/utils/helpers/page_helpers.dart';
import 'package:winscart/utils/string.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key, required this.orderStatus});

  final String orderStatus;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.maybeOf(context)!.size;
    debugPrint("size $size");
    return WillPopScope(
      onWillPop: () => Screen.openAsNewPage(context, const HomePage()),
      child: SafeArea(
        child: BlocProvider(
          create: (context) => AssignedOrderListCubit(context, orderStatus),
          child: Scaffold(
            drawer: const AppDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _showBottumSheetListStatusData(context);
                    },
                    child: Container(
                      height: 45,
                      width: 150,
                      decoration: _decoration(),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppText(
                            selectStatus,
                            size: 16,
                            weight: FontWeight.bold,
                          ),
                          Icon(Icons.expand_more_outlined)
                        ],
                      ),
                    ),
                  ),
                  20.wBox,
                  BlocBuilder<AssignedOrderListCubit, AssignedOrderListState>(
                    builder: (context, state) {
                      if (state is AssignedOrderListLoaded) {
                        return Container(
                          height: 45,
                          width: 75,
                          decoration: _decoration(),
                          child: Center(
                            child: AppText(
                              state.data.length,
                              weight: FontWeight.bold,
                              size: 18,
                            ),
                          ),
                        );
                      }
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ),
            body: BlocBuilder<AssignedOrderListCubit, AssignedOrderListState>(
              builder: (context, state) {
                if (state is AssignedOrderListLoaded) {
                  if (state.data.length.toString() == "0") {
                    return const Center(child: AppText("No Data"));
                  }
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.height / 100 * 1, vertical: size.width / 100 * 2),
                      child: Column(
                        children: [
                          10.hBox,
                          ListView.separated(
                            separatorBuilder: (context, index) => 10.hBox,
                            itemCount: state.data.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final listData = state.data[index];
                              return Row(
                                children: [
                                  Container(
                                    color: colorWhite,
                                    width: 20,
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                      child: AppText(
                                        "${index + 1}".toString(),
                                      ),
                                    ),
                                  ),
                                  5.wBox,
                                  InkWell(
                                    onTap: () {
                                      debugPrint("index ${index + 1}".toString());
                                      Screen.open(context, OrderDetailsPage(orderData: listData, index: index + 1));
                                    },
                                    child: Container(
                                      // height: 180,
                                      width: size.width / 100 * 89,
                                      padding: EdgeInsets.symmetric(horizontal: size.height / 100 * 2, vertical: size.width / 100 * 1.5),
                                      decoration: _decoration(),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              const AppText(
                                                "$status ",
                                                size: 10,
                                              ),
                                              AppText(
                                                listData.status,
                                                size: 10,
                                                color: Colors.red,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const AppText(
                                                orderID,
                                                size: 16,
                                              ),
                                              const Expanded(child: SizedBox()),
                                              SizedBox(
                                                width: 250,
                                                child: AppText(
                                                  listData.orderId,
                                                  style: const TextStyle(decoration: TextDecoration.underline, color: blue, fontWeight: FontWeight.bold, fontSize: 16, decorationColor: blue),
                                                ),
                                              ),
                                            ],
                                          ),
                                          5.hBox,
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const AppText(
                                                product,
                                                size: 16,
                                              ),
                                              const Expanded(child: SizedBox()),
                                              SizedBox(
                                                width: 250,
                                                child: AppText(
                                                  listData.productName,
                                                  size: 16,
                                                  maxLines: 23,
                                                  overflow: TextOverflow.ellipsis,
                                                  weight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const AppText(
                                                amount,
                                                size: 16,
                                              ),
                                              const Expanded(child: SizedBox()),
                                              SizedBox(
                                                width: 250,
                                                child: AppText(
                                                  "${listData.totalAmount} AED",
                                                  size: 16,
                                                  weight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          8.hBox,
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              AppButton(
                                                height: 28,
                                                width: 50,
                                                btBgColor: blue,
                                                text: call,
                                                fontSize: 12,
                                                textColor: colorWhite,
                                                onPressed: () {
                                                  _makePhoneCall(listData.phone.toString());
                                                },
                                              ),
                                              AppButton(
                                                height: 28,
                                                width: 80,
                                                fontSize: 13,
                                                btBgColor: Colors.green,
                                                text: whatsapp,
                                                textColor: colorWhite,
                                                onPressed: () {
                                                  _launchWhatsApp(listData.whatsapp.toString(), listData);
                                                },
                                              ),
                                              AppButton(
                                                height: 28,
                                                width: 50,
                                                btBgColor: blue,
                                                text: map,
                                                fontSize: 13,
                                                textColor: colorWhite,
                                                onPressed: () {
                                                  _launchMap(listData.lat.toString(), listData.long.toString());
                                                },
                                              ),
                                              5.wBox,
                                              listData.status == "DELIVERED"
                                                  ? 0.hBox
                                                  : AppButton(
                                                      height: 28,
                                                      width: 110,
                                                      btBgColor: primaryColor,
                                                      fontSize: 13,
                                                      text: changeStatus,
                                                      textColor: black,
                                                      onPressed: () {
                                                        _showBottumSheeChangeStatus(
                                                            context,
                                                            listData.orderId
                                                                .toString());
                                                      },
                                                    ),
                                              5.wBox,
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  );
                }
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _makePhoneCall(String number) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: number,
  );
  await launchUrl(launchUri);
}

Future<void> _launchWhatsApp(String number, Data orderData) async {
  final url =
      Uri.parse('http://wa.me/$number/?text=order%20id%20:%20${orderData.orderId}\nproduct%20:%20${orderData.productName}\namount%20:%20${orderData.totalAmount}\nstatus%20:%20${orderData.status}');
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}

Future<void> _launchMap(String lat, String long) async {
  final url = Uri.parse('https://www.google.com/maps/@$lat,$long,15.34z?entry=ttu');
  debugPrint(url.toString());
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}

BoxDecoration _decoration() {
  return BoxDecoration(
    color: colorWhite,
    borderRadius: BorderRadius.circular(12),
  );
}

void _showBottumSheetListStatusData(BuildContext ctx) {
  const name = [
    "Reshedule Delivary",
    "No Answer",
    "Order delivered",
    "Order Canceled",
  ];

  const icons = [
    Icon(Icons.event_repeat_outlined, color: black),
    Icon(Icons.phone_disabled_outlined, color: black),
    Icon(Icons.done_all_outlined, color: black),
    Icon(Icons.cancel, color: black),
  ];

  showModalBottomSheet(
    context: ctx,
    backgroundColor: colorWhite,
    builder: (BuildContext ctx) {
      return SizedBox(
        height: 350,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          children: [
            const AppText(
              selectDelivaryStatus,
              size: 20,
              weight: FontWeight.bold,
            ),
            15.hBox,
            ListView.separated(
              separatorBuilder: (context, index) => 20.hBox,
              itemCount: icons.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    switch (index) {
                      case 0:
                        Screen.open(
                            context,
                            const OrderListPage(
                              orderStatus: "resheduled_orders",
                            ));
                        break;
                      case 1:
                        Screen.open(
                            context,
                            const OrderListPage(
                              orderStatus: "no_answer_orders",
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
                              orderStatus: "cancelled_orders",
                            ));

                        break;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    elevation: 0,
                    minimumSize: const Size(0, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      icons[index],
                      const Expanded(child: SizedBox()),
                      SizedBox(
                        width: 200,
                        child: AppText(
                          name[index],
                          size: 18,
                          color: black,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}

void _showBottumSheeChangeStatus(BuildContext ctx, String orderId) {
  const name = [
    "Reshedule Delivary",
    "No Answer",
    "Order delivered",
    "Order Canceled",
  ];

  const icons = [
    Icon(Icons.event_repeat_outlined, color: black),
    Icon(Icons.phone_disabled_outlined, color: black),
    Icon(Icons.done_all_outlined, color: black),
    Icon(Icons.cancel, color: black),
  ];

  showModalBottomSheet(
    context: ctx,
    backgroundColor: colorWhite,
    builder: (BuildContext ctx) {
      return SizedBox(
        height: 350,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          children: [
            const AppText(
              selectDelivaryStatus,
              size: 20,
              weight: FontWeight.bold,
            ),
            15.hBox,
            BlocProvider(
              create: (context) => CommonCubit(context, orderId, "DELIVERED"),
              child: BlocBuilder<CommonCubit, CommonState>(
                builder: (context, state) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => 20.hBox,
                    itemCount: icons.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        onPressed: () {
                          switch (index) {
                            case 0:
                              Screen.open(
                                context,
                                CommonPage(
                                  icon: const Icon(
                                    Icons.call,
                                    color: black,
                                    size: 40,
                                  ),
                                  titile: noAnswer,
                                  isReshedule: true,
                                  orderId: orderId,
                                  status: "RESHEDULED",
                                ),
                              );
                              break;
                            case 1:
                              Screen.open(
                                context,
                                CommonPage(
                                  icon: const Icon(
                                    Icons.call,
                                    color: black,
                                    size: 40,
                                  ),
                                  titile: noAnswer,
                                  orderId: orderId,
                                  status: "NO ANSWER",
                                ),
                              );

                              break;
                            case 2:
                              Screen.open(
                                context,
                                CommonPage(
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: black,
                                    size: 40,
                                  ),
                                  titile: cancelDelivery,
                                  orderId: orderId,
                                  isDelivered: true,
                                  status: "DELIVERED",
                                ),
                              );
                              context.read<CommonCubit>().changeOrderStatus();

                              break;
                            case 3:
                              Screen.open(
                                  context,
                                  CommonPage(
                                    icon: const Icon(
                                      Icons.cancel,
                                      color: black,
                                      size: 40,
                                    ),
                                    titile: cancelDelivery,
                                    orderId: orderId,
                                    status: "CANCELLED",
                                  ));
                              break;
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          elevation: 0,
                          minimumSize: const Size(0, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            icons[index],
                            const Expanded(child: SizedBox()),
                            SizedBox(
                              width: 200,
                              child: AppText(
                                name[index],
                                size: 18,
                                color: black,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
