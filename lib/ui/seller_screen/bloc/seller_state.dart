part of 'seller_bloc.dart';


abstract class SellerState {}

class SellerInitial extends SellerState {
}

class UpdateScreenState extends SellerState {
  final List<AccountInfo> accountsInfo;
  final int index;
  final String status;
  UpdateScreenState({required this.accountsInfo, required this.status, required this.index});
}
