// ignore_for_file: unused_catch_clause

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:winscart/data/model/order_details_model.dart';
import 'package:winscart/data/services/api.dart';
import 'package:winscart/data/services/urls.dart';
import 'package:winscart/data/shared_preferences/preference_functions.dart';
import 'package:winscart/ui/pages/login_page/login_page.dart';
import 'package:winscart/utils/helpers/helper_snackbar.dart';
import 'package:winscart/utils/helpers/page_helpers.dart';

import '../../../data/model/assigned_orders.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit(this.context, this.orderId) : super(OrderDetailsInitial()) {
    getOrderDetails();
  }

  BuildContext context;
  final Data orderId;
  getOrderDetails() async {
    try {
      final response = await Api.call(context,
          endPoint: "$orderDetailsUrl/${orderId.orderId}", method: Method.get);
      final data = Datas.fromJson(response.data);
      emit(OrderDetailsLoaded(orderDetails: data));
    } on Exception catch (e) {
      SharedPref.clear();
      Screen.openAsNewPage(context, const LoginPage());
      snackBar(context, message: "token expired", type: MessageType.error);
    }
  }
}
