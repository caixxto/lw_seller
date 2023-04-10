import 'package:lw_seller/account_manager/account.dart';
import 'package:lw_seller/account_manager/factory.dart';

class Setting {
  List<Factory> allFactories;
  Factory factory;
  String age;
  String skills;
  String gp;
  String sex;
  String sellType;
  String nickname;
  String price;
  String currency;
  String chk;

  Setting({
    required this.allFactories,
    required this.factory,
    required this.age,
    required this.skills,
    required this.gp,
    required this.sex,
    required this.sellType,
    required this.nickname,
    required this.price,
    required this.currency,
    required this.chk

});

}

class AccountInfo {
  SellAccount account;
  Setting settings;

  AccountInfo({
    required this.account,
    required this.settings
});

}


