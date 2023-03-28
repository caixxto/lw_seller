part of 'seller_bloc.dart';


abstract class SellerState {}

class SellerInitial extends SellerState {
}

class UpdateScreenState extends SellerState {
  final List<SellAccount> accounts;
  final String status;
  UpdateScreenState({required this.accounts, required this.status});
}
