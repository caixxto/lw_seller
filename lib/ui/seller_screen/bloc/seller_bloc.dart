import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw_seller/account_manager/acc_sell_repo.dart';
import 'package:lw_seller/account_manager/account.dart';
import 'package:lw_seller/network_service.dart';
import 'package:lw_seller/settings/parse.dart';
import 'package:lw_seller/settings/settings.dart';

part 'seller_event.dart';

part 'seller_state.dart';

class SellerBloc extends Bloc<SellerEvent, SellerState> {
  final ToSellRepository _repository = ToSellRepository.instance;
  final network = Network.instance;

  SellerBloc() : super(SellerInitial()) {
    on<UpdateScreenEvent>(_onUpdateScreen);
    on<SaveAccountEvent>(_onSaveAccountInfo);
    on<StartFilterEvent>(_onFilterHorses);

    initialize();
  }

  initialize() async {
    _onStart();
  }

  _update(accounts, status, index) {
    emit(UpdateScreenState(
        accountsInfo: accounts, status: status, index: index));
  }

  void _onUpdateScreen(UpdateScreenEvent event, Emitter<SellerState> emit) {
    _update(_repository.getAccounts, '', event.index);
  }

  Map<String, dynamic> _onSetupRequest(age, ageComparaison, sexe, competences,
      competencesComparaison, genetique, genetiqueComparaison, purete, id) {
    requestMap['age'] = age;
    requestMap['ageComparaison'] = ageComparaison;
    requestMap['sexe'] = sexe;
    requestMap['competences'] = competences;
    requestMap['competencesComparaison'] = competencesComparaison;
    requestMap['genetique'] = genetique;
    requestMap['genetiqueComparaison'] = genetiqueComparaison;
    requestMap['purete'] = purete;
    requestMap['id'] = id;

    return requestMap;
  }

  Future<void> _onFilterHorses(StartFilterEvent event, Emitter<SellerState> emit)  async {
    final acc = event.account.settings;
    final map = forRequest;
    var res =  await network.getFilterHorses(_onSetupRequest(
      //TODO: get g l e
        acc.age,
        'g',
        map[acc.sex],
        acc.skills,
        'g',
        acc.gp,
        'g',
        map[acc.chk],
        acc.factory.id
    ));
  }

  Future<void> _onStart() async {
    for (var i = 0; i < _repository.getAccounts.length; i++) {
      final account = _repository.getAccounts[i].account;
      final settings = _repository.getAccounts[i].settings;
      var exp = true;
      var numRetries = 0;

      do {
        if (exp) {
          print('Попытка входа ${account.login}');
          _update(_repository.getAccounts, 'Попытка входа ${account.login}', i);
          exp = await _loginRequest(account.login, account.password);
          numRetries++;
        }
      } while ((exp) && (numRetries < 5));

      if (exp == false) {
        print('Вход выполнен ${account.login}');
        final factories = await network.getFactory();
        final nativeSettings = Setting(
            allFactories: factories,
            factory: factories.last,
            age: '0',
            skills: '0',
            gp: '0',
            sex: 'Любой',
            sellType: 'Резерв',
            nickname: '',
            price: '500',
            currency: 'Экю',
            chk: 'Все');
        final changedAccount = AccountInfo(account: SellAccount(
            login: account.login, password: account.password),
            settings: nativeSettings);

        _repository.change(i, changedAccount);
        _update(_repository.getAccounts, 'Вход выполнен ${account.login}', i);
      }
    }
  }

  Future<bool> _loginRequest(login, password) async {
    final session = Network.instance;
    var res = await session.login(login, password);

    return res;
  }

  void _onSaveAccountInfo(SaveAccountEvent event, Emitter<SellerState> emit) {
    _repository.change(event.index, event.info);
    print(event.info.settings.factory.name);
    print(event.info.settings.factory.id);
    _update(_repository.getAccounts, 'Сохранено', event.index);
  }

}
