
import 'package:lw_seller/account_manager/factory.dart';

enum SellType {
  equus,
  passes
}

enum HorseSex {
  male,
  female
}

class Settings {
  String account;
  List<Factory> factory;
  int age;
  String sex;
  String sellType;
  int cost;
  String money;
  String nickname;

  Settings({
    required this.account,
    required this.factory,
    required this.age,
    required this.sex,
    required this.sellType,
    required this.cost,
    required this.money,
    required this.nickname});

}

