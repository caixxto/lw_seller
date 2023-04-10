import 'account.dart';

class ToBuyRepository {
  static final ToBuyRepository  _instance = ToBuyRepository._();
  ToBuyRepository._();
  static ToBuyRepository get instance => _instance;

  final List<BuyAccount> _list = List.empty(growable: true);
  // final List<BuyAccount> _list = [
  //   BuyAccount(login: 'Ник', password: 'amzfljamzflj', horses: 500),
  //   //BuyAccount(login: 'Oblivitron', password: 'M9I2mRX'),
  // ];

  List<BuyAccount> get getAccounts => _list;

  void addNewAccount(BuyAccount account) => _list.add(account);

  void deleteAccount(int index) => _list.removeAt(index);

}