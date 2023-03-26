import 'package:injectable/injectable.dart';
import 'account.dart';

@LazySingleton(env: [Environment.dev, Environment.prod])
class ToBuyRepository {

  //final List<Account> _list = List.empty(growable: true);
  final List<BuyAccount> _list = [
    BuyAccount(login: 'Ник', password: 'amzfljamzflj', horses: 500),
    //BuyAccount(login: 'Oblivitron', password: 'M9I2mRX'),
  ];

  List<BuyAccount> get getAccounts => _list;

  void addNewAccount(BuyAccount account) => _list.add(account);

  void deleteAccount(int index) => _list.removeAt(index);

}