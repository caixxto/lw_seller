import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lw_seller/settings/settings.dart';
import 'package:meta/meta.dart';

part 'seller_event.dart';
part 'seller_state.dart';

class SellerBloc extends Bloc<SellerEvent, SellerState> {
  SellerBloc() : super(SellerInitial()) {
    on<SettingsChangedEvent>(_onSettingsChanged);

  }



  FutureOr<void> _onSettingsChanged(SettingsChangedEvent event, Emitter<SellerState> emit) {

  }
}
