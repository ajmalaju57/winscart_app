// ignore_for_file: use_build_context_synchronously, empty_constructor_bodies

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:winscart/data/services/api.dart';
import 'package:winscart/data/services/multipart_api.dart';
import 'package:winscart/data/services/urls.dart';
import 'package:winscart/ui/pages/VoiceSctionCanceled/voice_sction.dart';
import 'package:winscart/ui/pages/VoiceSctionNoAnswer/voice_sction.dart';
import 'package:winscart/ui/pages/VoiceSctionReshedule/voice_sction.dart';
import 'package:winscart/ui/pages/home/home_page.dart';
import 'package:winscart/utils/helpers/helper_date_time.dart';
import 'package:winscart/utils/helpers/helper_snackbar.dart';
import 'package:winscart/utils/helpers/page_helpers.dart';
import 'package:http/http.dart' as http;

part 'common_state.dart';

class CommonCubit extends Cubit<CommonState> {
  CommonCubit(this.context, this.orderId, this.status)
      : super(CommonInitial()) {}

  BuildContext context;
  final String orderId;
  final String status;
  TextEditingController ctrl = TextEditingController();
  TextEditingController selectDatetext = TextEditingController();

  selectDate() async {
    DateTime lastDate = DateTime(DateTime.now().year + 1);
    final DateTime firstDate =
        DateTime.now().subtract(const Duration(days: 30));
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      selectDatetext.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  changeOrderStatus() async {
    if (status == "RESHEDULED") {
      if (ctrl.text.isEmpty || selectDatetext.text.isEmpty) {
        snackBar(context,
            message: "Please Fill details", type: MessageType.error);
        return;
      }
    }
    if (status == "NO ANSWER" || status == "CANCELLED") {
      if (ctrl.text.isEmpty) {
        snackBar(context,
            message: "Please Fill details", type: MessageType.error);
        return;
      }
    }
    final body = {
      "order_id": orderId,
      "status": status,
      "note": ctrl.text,
      "delivery_date": status == "RESHEDULED"
          ? selectDatetext.text
          : getFullDate(DateTime.now().toString())
    };
    if (audioFileReshedule.text.isNotEmpty ||
        audioFileNoAnswer.text.isNotEmpty ||
        audioFileCanceled.text.isNotEmpty) {
      final file = await http.MultipartFile.fromPath(
          "audio",
          status == "RESHEDULED"
              ? audioFileReshedule.text
              : status == "NO ANSWER"
                  ? audioFileNoAnswer.text
                  : audioFileCanceled.text);
      debugPrint(
          "...${status == "RESHEDULED" ? audioFileReshedule.text : status == "NO ANSWER" ? audioFileNoAnswer.text : audioFileCanceled.text}");
      final response = await MultipartApi.upload(context,
          endPoint: changeStatusUrl, files: [file], body: body);
      snackBar(context,
          message: response['message'], type: MessageType.success);
      Screen.openAsNewPage(context, const HomePage());
      audioFileReshedule.text = '';
      audioFileNoAnswer.text = '';
      audioFileCanceled.text = '';
      ctrl.text = '';
      selectDatetext.text = '';
      return;
    }
    final response = await Api.call(
      context,
      endPoint: changeStatusUrl,
      method: Method.post,
      body: body,
    );
    if (response.status) {
      snackBar(context, message: response.message, type: MessageType.success);
      status == "DELIVERED"
          ? null
          : Screen.openAsNewPage(context, const HomePage());
      ctrl.text = '';
      selectDatetext.text = '';
    } else {
      snackBar(context, message: response.message, type: MessageType.error);
    }
  }
}
