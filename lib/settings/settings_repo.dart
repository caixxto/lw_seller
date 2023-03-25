import 'package:injectable/injectable.dart';
import 'package:lw_seller/settings/settings.dart';

@LazySingleton(env: [Environment.dev, Environment.prod])
class SettingsRepository {

  final List<Settings> _list = List.empty(growable: true);


  List<Settings> get getSettings => _list;

  void addNewSetting(Settings settings) => _list.add(settings);

  //void deleteAccount(int index) => _list.removeAt(index);

}