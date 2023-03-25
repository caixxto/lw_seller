import 'package:injectable/injectable.dart';
import 'package:lw_seller/settings/settings.dart';
import 'account.dart';

@LazySingleton(env: [Environment.dev, Environment.prod])
class ToSellRepository {
  //final List<Account> _list = List.empty(growable: true);
  final List<SellAccount> _list = [
    SellAccount(
        login: 'Зелёная стрела',
        password: 'SiOiJKGqF',
        settings: Settings(
            account: 'Зелёная стрела',
            factory: '',
            age: 500,
            sex: 'sexeeeeee',
            gp: 500,
            skills: 500,
            chK: true,
            race: '',
            sellType: '',
            cost: 500,
            money: '',
            nickname: '')),
    // Account(login: 'Pistol Whip', password: 'canseeclearly'),
    // Account(login: 'Oblivitron', password: 'M9I2mRX'),
  ];

  List<SellAccount> get getAccounts => _list;

  void addNewAccount(SellAccount account) => _list.add(account);

  void deleteAccount(int index) => _list.removeAt(index);

  void changeSettings(int index, element) {
    _list.removeAt(index);
    _list.insert(index, element);
}
}
