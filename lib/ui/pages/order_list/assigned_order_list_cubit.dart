// ignore_for_file: unused_catch_clause

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:winscart/data/model/assigned_orders.dart';
import 'package:winscart/data/services/api.dart';
import 'package:winscart/data/services/urls.dart';
import 'package:winscart/data/shared_preferences/preference_functions.dart';
import 'package:winscart/ui/pages/login_page/login_page.dart';
import 'package:winscart/utils/helpers/helper_snackbar.dart';
import 'package:winscart/utils/helpers/page_helpers.dart';

part 'assigned_order_list_state.dart';

class AssignedOrderListCubit extends Cubit<AssignedOrderListState> {
  AssignedOrderListCubit(this.context, this.orderStatus)
      : super(AssignedOrderListInitial()) {
    getAssignedOrderList();
  }

  BuildContext context;
  String orderStatus;
  getAssignedOrderList() async {
    try {
      final response = await Api.call(context,
          endPoint: "$assignedOrdersUrl/$orderStatus", method: Method.get);
      final data = AssignedOrderList.fromJson(response.data).data;
      debugPrint("data ${data.length}");
      emit(AssignedOrderListLoaded(data: data));
    } on Exception catch (e) {
      SharedPref.clear();
      Screen.openAsNewPage(context, const LoginPage());
      snackBar(context, message: "token expired", type: MessageType.error);
    }
  }
}
