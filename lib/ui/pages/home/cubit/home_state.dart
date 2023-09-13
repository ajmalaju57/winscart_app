// ignore_for_file: must_be_immutable

part of 'home_cubit.dart';

class HomeState {}

class HomeInitial extends HomeState {}

class ProfileData extends HomeState {
  Data profileData;
  ProfileData({required this.profileData});
}
