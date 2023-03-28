import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw_seller/account_manager/acc_sell_repo.dart';
import 'package:lw_seller/account_manager/account.dart';
import 'package:lw_seller/network_service.dart';
import 'package:lw_seller/settings/settings.dart';
part 'seller_event.dart';
part 'seller_state.dart';

class SellerBloc extends Bloc<SellerEvent, SellerState> {

  final ToSellRepository _repository = ToSellRepository.instance;
  final network = Network.instance;

  SellerBloc() : super(SellerInitial()) {
    on<UpdateScreenEvent>(_onUpdateScreen);
    on<SaveSettingsEvent>(_onSaveSettings);
    on<StartEvent>(_onStart);

    initState();

  }

  initState() async {
    _update(_repository.getAccounts, 'Готово');
  }

  _update(accounts, status) {
    emit(UpdateScreenState(accounts: accounts, status: status));
  }


  void _onUpdateScreen(UpdateScreenEvent event, Emitter<SellerState> emit)  {
    _update(_repository.getAccounts, '');
  }


  void _onSaveSettings(SaveSettingsEvent event, Emitter<SellerState> emit) {
    _repository.changeSettings(event.index, event.settings);
  }

  Future<void> _onStart(StartEvent event, Emitter<SellerState> emit) async {

    for (var i = 0; i < _repository.getAccounts.length; i++) {
      final account = _repository.getAccounts;
      var exp = true;
      var numRetries = 0;

      do {
        if (exp) {
          print('Попытка входа ${account[i].login}');
          _update(_repository.getAccounts, 'Попытка входа ${account[i].login}');
          exp = await _loginRequest(account[i].login, account[i].password);
          numRetries++;
        }
      } while ((exp) && (numRetries < 5));

      if (exp == false) {
        _update(_repository.getAccounts, 'Вход выполнен ${account[i].login}');
        print('Вход выполнен ${account[i].login}');
        _repository.changeSettings(i, Settings(account: account[i].login, factory: await network.getFactory(), age: 0, sex: 'sex', sellType: 'sellType', cost: 500, money: 'money', nickname: 'nickname'));


      }

    }

  }

  Future<bool> _loginRequest(login, password) async {
    Network.dio.interceptors.clear();
    final session = Network.instance;
    var res = await session.login(login, password);

    return res;
  }

}
