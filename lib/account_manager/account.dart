import 'package:lw_seller/settings/settings.dart';

class SellAccount {
  final String login;
  final String password;
  final Settings settings;

  SellAccount({required this.login, required this.password, required this.settings});
}

class BuyAccount {
  final String login;
  final String password;
  final int horses;

  BuyAccount({required this.login, required this.password, required this.horses});
}