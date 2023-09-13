// ignore_for_file: unused_catch_clause

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:winscart/data/model/notification_list_model.dart';
import 'package:winscart/data/services/api.dart';
import 'package:winscart/data/services/urls.dart';
import 'package:winscart/data/shared_preferences/preference_functions.dart';
import 'package:winscart/ui/pages/login_page/login_page.dart';
import 'package:winscart/utils/helpers/helper_snackbar.dart';
import 'package:winscart/utils/helpers/page_helpers.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.context) : super(NotificationInitial()) {
    getNotificcation();
  }

  BuildContext context;

  getNotificcation() async {
    try {
      final response = await Api.call(context,
          endPoint: notificationUrl, method: Method.get);
      final data = List<Notifications>.from(
          response.data.map((x) => Notifications.fromJson(x)));
      emit(NotificationLoaded(data: data));
    } on Exception catch (e) {
      SharedPref.clear();
      Screen.openAsNewPage(context, const LoginPage());
      snackBar(context, message: "token expired", type: MessageType.error);
    }
  }
}
