import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:winscart/data/services/api.dart';
import 'package:winscart/data/services/urls.dart';
import 'package:winscart/data/shared_preferences/preference_functions.dart';
import 'package:winscart/ui/pages/login_page/login_page.dart';
import 'package:winscart/utils/helpers/helper_snackbar.dart';
import 'package:winscart/utils/helpers/page_helpers.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this.context) : super(LogoutInitial());

  BuildContext context;
  logOut() async {
    final response = await Api.call(context, endPoint: logOutUrl, method: Method.post);
    if (response.status && context.mounted) {
      snackBar(context, message: response.message, type: MessageType.success);
      SharedPref.clear();
      Screen.openAsNewPage(context, const LoginPage());
    }
  }
}
