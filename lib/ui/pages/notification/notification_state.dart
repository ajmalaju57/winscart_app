part of 'notification_cubit.dart';

class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationLoaded extends NotificationState {
  List<Notifications> data;
  NotificationLoaded({required this.data});
}
