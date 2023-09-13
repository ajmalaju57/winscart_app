import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winscart/ui/components/app_text.dart';
import 'package:winscart/ui/pages/notification/notification_cubit.dart';
import 'package:winscart/utils/color.dart';
import 'package:winscart/utils/extensions/space_ext.dart';
import 'package:winscart/utils/helpers/helper_date_time.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.5,
        title: const AppText(
          "Notifications",
          color: black,
          size: 16,
        ),
      ),
      body: BlocProvider(
        create: (context) => NotificationCubit(context),
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoaded) {
              if (state.data.isEmpty) {
                return const Center(
                  child: AppText("No Notifications"),
                );
              }
              return ListView.separated(
                itemCount: 10,
                shrinkWrap: true,
                separatorBuilder: (context, index) => 10.hBox,
                itemBuilder: (context, index) {
                  final notificationList = state.data[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      tileColor: colorWhite,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      title: AppText(
                        notificationList.title,
                        color: black,
                        size: 16,
                        weight: FontWeight.bold,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppText(
                            notificationList.body,
                          ),
                          5.hBox,
                          AppText(
                            getTimeAgo(notificationList.createdAt.toString()),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
