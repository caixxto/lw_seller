part of 'seller_bloc.dart';


abstract class SellerEvent{}

class SettingsChangedEvent extends SellerEvent {}

class UpdateScreenEvent extends SellerEvent {
  final int index;
  UpdateScreenEvent({required this.index});
}

class SaveAccountEvent extends SellerEvent {
  final AccountInfo info;
  final int index;
  SaveAccountEvent({required this.info, required this.index});
}

class ClearAccountEvent extends SellerEvent {}

class StartFilterEvent extends SellerEvent {
  final AccountInfo account;
  StartFilterEvent({required this.account});
}

