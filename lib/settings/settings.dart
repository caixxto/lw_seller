
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
  String factory;
  int age;
  String sex;
  int gp;
  int skills;
  bool chK;
  String race;
  String sellType;
  int cost;
  String money;
  String nickname;

  Settings({
    required this.account,
    required this.factory,
    this.age = 0,
    required this.sex,
    this.gp = 0,
    this.skills = 0,
    required this.chK,
    required this.race,
    required this.sellType,
    required this.cost,
    required this.money,
    required this.nickname});

}

// class SettingsDTO {
//   String name;
//   String dataType;
//   Widget widget;
// }
