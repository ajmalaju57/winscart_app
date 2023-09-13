// ignore_for_file: avoid_print, use_build_context_synchronously, unused_catch_clause

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:winscart/data/model/profile_model.dart';
import 'package:winscart/data/services/api.dart';
import 'package:winscart/data/services/urls.dart';
import 'package:winscart/data/shared_preferences/preference_functions.dart';
import 'package:winscart/ui/pages/login_page/login_page.dart';
import 'package:winscart/utils/helpers/helper_date_time.dart';
import 'package:winscart/utils/helpers/helper_snackbar.dart';
import 'package:winscart/utils/helpers/page_helpers.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.context) : super(HomeInitial()) {
    initPage();
  }

  BuildContext context;

  initPage() {
    getProfile();
  }

  getProfile() async {
    try {
      final response = await Api.call(context,
          endPoint: profileDetailUrl, method: Method.get);
      if (response.data != null && response.data is Map<String, dynamic>) {
        final profileData = Data.fromJson(response.data);
        emit(ProfileData(profileData: profileData));
      } else {
        print('Error: Invalid or null response data');
      }
    } on Exception catch (e) {
      SharedPref.clear();
      Screen.openAsNewPage(context, const LoginPage());
      snackBar(context, message: "token expired", type: MessageType.error);
    }
  }

  String? barcodeScanRes;

  scanQR() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      debugPrint(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // if (!mounted) return;

    debugPrint(barcodeScanRes);
    await pickUpOrder();
  }

  pickUpOrder() async {
    final body = {"order_id": barcodeScanRes, "status": "PICKEDUP", "delivery_date": getFullDate(DateTime.now().toString())};
    final response = await Api.call(
      context,
      endPoint: changeStatusUrl,
      method: Method.post,
      body: body,
    );
    if (response.status) {
      snackBar(context, message: response.message, type: MessageType.success);
      initPage();
    } else {
      snackBar(context, message: response.message, type: MessageType.error);
    }
  }
}
