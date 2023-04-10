import 'package:lw_seller/account_manager/account.dart';
import 'package:lw_seller/account_manager/factory.dart';
import 'package:lw_seller/settings/settings.dart';

class ToSellRepository {
  static final ToSellRepository _instance = ToSellRepository._();

  ToSellRepository._();

  static ToSellRepository get instance => _instance;

  //final List<AccountInfo> _list = List.empty(growable: true);
  final List<AccountInfo> _list = [
    AccountInfo(
        account: const SellAccount(login: 'Комондор', password: 'япобедю'),
        settings: Setting(
            allFactories: [
              Factory(name: 'name', id: 'id'),
            ],
            factory: Factory(name: '', id: ''),
            age: '0',
            sex: 'Кобыла',
            sellType: 'Резерв',
            nickname: 'ник1',
            price: '500',
            currency: 'Экю',
            skills: '0',
            gp: '0',
            chk: 'Чк')),
    // AccountInfo(
    //     account:
    //         const SellAccount(login: 'Тюлень Гилберт', password: 'Джеремиохотник'),
    //     settings: Setting(
    //         allFactories: [
    //           Factory(name: 'name', id: 'id'),
    //         ],
    //         factory: Factory(name: '', id: ''),
    //         age: '0',
    //         sex: 'Жеребец',
    //         sellType: 'Прямая',
    //         nickname: 'ник3',
    //         price: '1000',
    //         currency: 'Пропы',
    //         skills: '0',
    //         gp: '0',
    //         chk: 'Все')),
  ];

  List<AccountInfo> get getAccounts => _list;

  void addNewAccount(AccountInfo accountInfo) => _list.add(accountInfo);

  void deleteAccount(int index) => _list.removeAt(index);

  void change(int index, AccountInfo account) {
    _list[index] = account;
  }
}
