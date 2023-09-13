part of 'order_details_cubit.dart';

class OrderDetailsState {}

class OrderDetailsInitial extends OrderDetailsState {}

class OrderDetailsLoaded extends OrderDetailsState {
  Datas? orderDetails;
  OrderDetailsLoaded({required this.orderDetails});
}
