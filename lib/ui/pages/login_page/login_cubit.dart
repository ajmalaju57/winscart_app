// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:winscart/data/model/driver_details_model.dart';
import 'package:winscart/data/services/api.dart';
import 'package:winscart/data/services/urls.dart';
import 'package:winscart/data/shared_preferences/keys.dart';
import 'package:winscart/data/shared_preferences/preference_functions.dart';
import 'package:winscart/ui/pages/home/home_page.dart';
import 'package:winscart/utils/helpers/helper_loader.dart';
import 'package:winscart/utils/helpers/helper_snackbar.dart';
import 'package:winscart/utils/helpers/page_helpers.dart';
import 'package:winscart/utils/helpers/push_notification.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.context) : super(LoginInitial()) {
    firebaseNotification();
  }

  BuildContext context;

  TextEditingController usernameCtrl = TextEditingController(), passCtrl = TextEditingController();
  bool showHide = true;

  showHidePass(bool showHideClick) {
    showHide = showHideClick;
    emit(ShowHidePass());
  }

  final firebase = FirebaseNotifcation();

  firebaseNotification() async {
    await firebase.initialize();
  }

  login() async {
    final fcmToken = await firebase.getToken();
    if (usernameCtrl.text.isEmpty || passCtrl.text.isEmpty) {
      snackBar(context, message: "Please Fill details", type: MessageType.error);
      return;
    }

    final body = {
      "username": usernameCtrl.text,
      "password": passCtrl.text,
      "device_token": "$fcmToken"
    };

    final response = await Api.call(
      context,
      endPoint: loginUrl,
      method: Method.post,
      body: body,
    );
    loader(context: context);

    if (response == null) {
      snackBar(context, message: "API response is null", type: MessageType.error);
      hideLoader(context);
      return;
    }

    if (response.data == null) {
      snackBar(context, message: response.message, type: MessageType.error);
      hideLoader(context);
      return;
    }
    if (response.status && context.mounted) {
      final tokenResponse = Data.fromJson(response.data);
      userId = tokenResponse.token;
      currentUserName = tokenResponse.name;
      SharedPref.save(key: userToken, value: tokenResponse.token);
      SharedPref.save(key: userName, value: tokenResponse.name);
      await Screen.openAsNewPage(context, const HomePage());
      hideLoader(context);
    } else {
      snackBar(context, message: response.message, type: MessageType.error);
      hideLoader(context);
    }
  }
}
