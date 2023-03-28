part of 'seller_bloc.dart';


abstract class SellerEvent{}

class SettingsChangedEvent extends SellerEvent {}

class UpdateScreenEvent extends SellerEvent {}

class SaveSettingsEvent extends SellerEvent {
  final int index;
  final Settings settings;

  SaveSettingsEvent({required this.settings, required this.index});
}

class StartEvent extends SellerEvent {}

