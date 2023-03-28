import 'package:lw_seller/account_manager/factory.dart';
import 'package:lw_seller/settings/settings.dart';
import 'account.dart';

class ToSellRepository {
  static final ToSellRepository  _instance = ToSellRepository._();
  ToSellRepository._();
  static ToSellRepository get instance => _instance;
  //final List<SellAccount> _list = List.empty(growable: true);
  final List<SellAccount> _list = [
    SellAccount(
        login: 'Комондор',
        password: 'япобедю',
        settings: Settings(
            account: 'Зелёная стрела',
            factory: [Factory(name: '1', id: ''), Factory(name: '2', id: ''), Factory(name: '3', id: '')],
            age: 1,
            sex: '234234',
            sellType: '',
            cost: 5200,
            money: '',
            nickname: '222')),
  ];

  List<SellAccount> get getAccounts => _list;

  void addNewAccount(SellAccount account) => _list.add(account);

  void deleteAccount(int index) => _list.removeAt(index);

  void changeSettings(int index, Settings settings) {
    final login = _list[index].login;
    final password = _list[index].password;
    _list.removeAt(index).settings;
    _list.insert(index, SellAccount(login: login, password: password, settings: settings));
}

}
