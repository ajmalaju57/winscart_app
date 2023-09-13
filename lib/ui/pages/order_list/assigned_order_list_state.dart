part of 'assigned_order_list_cubit.dart';

class AssignedOrderListState {}

class AssignedOrderListInitial extends AssignedOrderListState {}

class AssignedOrderListLoaded extends AssignedOrderListState {
  List<Data> data;
  AssignedOrderListLoaded({required this.data});
}
