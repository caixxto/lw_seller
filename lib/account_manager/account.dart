
class SellAccount {
  final String login;
  final String password;

  const SellAccount({required this.login, required this.password});
}

class BuyAccount {
  final String login;
  final String password;
  final int horses;

  BuyAccount({required this.login, required this.password, required this.horses});
}