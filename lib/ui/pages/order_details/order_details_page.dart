// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winscart/ui/components/app_drawer/app_drawer.dart';
import 'package:winscart/ui/components/app_text.dart';
import 'package:winscart/ui/pages/order_details/order_details_cubit.dart';
import 'package:winscart/utils/color.dart';
import 'package:winscart/utils/extensions/space_ext.dart';

import '../../../data/model/assigned_orders.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage(
      {super.key, required this.orderData, required this.index});

  final Data orderData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => OrderDetailsCubit(context, orderData),
        child: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
          builder: (context, state) {
            if (state is OrderDetailsLoaded) {
              final orderData = state.orderDetails;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: colorWhite),
                            child: Center(
                              child: AppText(
                                " $index",
                                weight: FontWeight.bold,
                                size: 18,
                              ),
                            ),
                          ),
                          20.wBox,
                          Container(
                            height: 40,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: colorWhite),
                            child: const Center(
                              child: AppText(
                                " Order Details ",
                                weight: FontWeight.bold,
                                size: 18,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    10.hBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: colorWhite,
                            borderRadius: BorderRadius.circular(18)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 5, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const AppText(
                                    "Order ID: ",
                                    weight: FontWeight.bold,
                                    size: 18,
                                  ),
                                  AppText(
                                    orderData?.orderId,
                                    style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                      color: blue,
                                      fontSize: 18,
                                      decorationColor: blue,
                                    ),
                                  ),
                                ],
                              ),
                              10.hBox,
                              Row(
                                children: [
                                  const AppText(
                                    "Name: ",
                                    weight: FontWeight.bold,
                                    size: 18,
                                  ),
                                  AppText(
                                    orderData?.name,
                                    weight: FontWeight.normal,
                                    size: 18,
                                  ),
                                ],
                              ),
                              10.hBox,
                              Row(
                                children: [
                                  const AppText(
                                    "Email: ",
                                    weight: FontWeight.bold,
                                    size: 18,
                                  ),
                                  AppText(
                                    orderData?.email,
                                    weight: FontWeight.normal,
                                    size: 18,
                                  ),
                                ],
                              ),
                              10.hBox,
                              Row(
                                children: [
                                  const AppText(
                                    "Phone: ",
                                    weight: FontWeight.bold,
                                    size: 18,
                                  ),
                                  AppText(
                                    orderData?.phone,
                                    weight: FontWeight.normal,
                                    size: 18,
                                  ),
                                ],
                              ),
                              10.hBox,
                              Row(
                                children: [
                                  const AppText(
                                    "Region: ",
                                    weight: FontWeight.bold,
                                    size: 18,
                                  ),
                                  AppText(
                                    orderData?.region,
                                    weight: FontWeight.normal,
                                    size: 18,
                                  ),
                                ],
                              ),
                              10.hBox,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(
                                    "Address: ",
                                    weight: FontWeight.bold,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: AppText(
                                      orderData?.address.toString(),
                                      weight: FontWeight.normal,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                              10.hBox,
                              Row(
                                children: [
                                  const AppText(
                                    "Comment: ",
                                    weight: FontWeight.bold,
                                    size: 18,
                                  ),
                                  AppText(
                                    orderData?.comment ?? "",
                                    weight: FontWeight.normal,
                                    size: 18,
                                  ),
                                ],
                              ),
                              10.hBox,
                              Row(
                                children: [
                                  const AppText(
                                    "Status: ",
                                    weight: FontWeight.bold,
                                    size: 18,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    color: Colors.indigoAccent,
                                    child: AppText(
                                      orderData?.status ?? "",
                                      weight: FontWeight.normal,
                                      color: colorWhite,
                                      size: 14,
                                    ),
                                  ),
                                ],
                              ),
                              10.hBox,
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    dataRowHeight: 100,
                                    border: TableBorder.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                        width: 2),
                                    columns: const [
                                      DataColumn(
                                        label: AppText(
                                          'Product',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                      DataColumn(
                                        label: AppText(
                                          'Image',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                      DataColumn(
                                        label: AppText(
                                          'Quantity',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                      DataColumn(
                                        label: AppText(
                                          'Price',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                      DataColumn(
                                        label: AppText(
                                          'Delivery Charge',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                      DataColumn(
                                        label: AppText(
                                          'Total Price',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                    rows: List.generate(
                                      state.orderDetails!.productItems.length,
                                      (index) {
                                        debugPrint(
                                            "length ${state.orderDetails!.productItems.length}");
                                        final orderData = state
                                            .orderDetails?.productItems[index];
                                        final product =
                                            orderData?.productName.toString();
                                        final imageUrl =
                                            orderData?.image.toString();
                                        final quantity =
                                            orderData?.quantity.toString();
                                        final price =
                                            orderData?.price.toString();
                                        final deliveryCharge =
                                            orderData?.price.toString();
                                        final totalPrice =
                                            orderData?.subTotal.toString();
                                        return DataRow(
                                          cells: [
                                            DataCell(
                                              SizedBox(
                                                width: 120,
                                                child: Text(
                                                  product.toString(),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              SizedBox(
                                                width: 100,
                                                child: Image.network(
                                                  imageUrl.toString(),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                quantity.toString(),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                price.toString(),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                deliveryCharge.toString(),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                totalPrice.toString(),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              10.hBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const AppText(
                                    "Total Amount :",
                                    weight: FontWeight.bold,
                                    size: 20,
                                  ),
                                  AppText(
                                    "${orderData?.totalAmount.toString()} AED",
                                    weight: FontWeight.bold,
                                    size: 20,
                                  )
                                ],
                              ),
                              20.hBox,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          },
        ),
      ),
    );
  }
}
