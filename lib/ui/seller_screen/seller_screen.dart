import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw_seller/account_manager/acc_buy_repo.dart';
import 'package:lw_seller/account_manager/acc_sell_repo.dart';
import 'package:lw_seller/account_manager/account.dart';
import 'package:lw_seller/account_manager/factory.dart';
import 'package:lw_seller/settings/settings.dart';
import 'package:lw_seller/constants.dart';
import 'package:lw_seller/settings/settings_repo.dart';
import 'package:lw_seller/ui/seller_screen/bloc/seller_bloc.dart';
import 'package:lw_seller/ui/widgets/chip.dart';
import 'package:lw_seller/ui/widgets/seller_list_tile.dart';
import 'package:lw_seller/ui/widgets/setting_widget.dart';
import 'package:lw_seller/ui/widgets/text_field.dart';

class SellerScreen extends StatelessWidget {
  List<String> selected = [];
  bool _diffAccounts = false;
  final toBuyRepo = ToBuyRepository.instance;
  int _buyIndex = 0;
  int selectedIndex = 0;
  late String factory;
  late String sex;
  late String race;
  late String money;
  late String sellType;
  final Bloc bloc = SellerBloc();
  final settingsRepo = SettingsRepository();
  final ToSellRepository _repository = ToSellRepository.instance;
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _horsesController = TextEditingController();

  SellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SellerBloc, SellerState>(
      listener: (context, state) {},
      builder: (context, state) {
        var accounts = (state as UpdateScreenState).accounts;
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.orange,
            actions: [
              Row(
                children: [
                  Text(state.status),
                  const Text('Ставить на разные акки', style: WHITE_TEXT_STYLE),
                  Checkbox(
                      value: _diffAccounts,
                      onChanged: (value) {
                        _diffAccounts = value ?? false;
                        context.read<SellerBloc>().add(UpdateScreenEvent());
                      }),
                  ElevatedButton(
                      onPressed: () {
                        context.read<SellerBloc>().add(StartEvent());
                      },
                  child: const Text('Старт', style: WHITE_TEXT_STYLE)),
                ],
              )
            ],
          ),
          body: Row(
            children: [
              Container(
                width: 200,
                color: const Color(0xff0a0a0a),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                _showDialog(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: PRIMARY_COLOR),
                              child: const Text('Добавить',
                                  style: WHITE_TEXT_SMALL_STYLE)),
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                _repository.getAccounts.clear();
                                context
                                    .read<SellerBloc>()
                                    .add(UpdateScreenEvent());
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: PRIMARY_COLOR),
                              child: const Text('Очистить',
                                  style: WHITE_TEXT_SMALL_STYLE)),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ListView.builder(
                            itemCount: accounts.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                onTap: () {
                                  _nickNameController.text =
                                      accounts[i].settings.nickname;
                                  _costController.text =
                                      accounts[i].settings.cost.toString();
                                  _ageController.text =
                                      accounts[i].settings.age.toString();
                                  selectedIndex = i;
                                  context
                                      .read<SellerBloc>()
                                      .add(UpdateScreenEvent());
                                },
                                child: Container(
                                  height: 40,
                                  color: i == selectedIndex
                                      ? Colors.orange
                                      : Colors.transparent,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            accounts[i].login,
                                            style: WHITE_TEXT_STYLE,
                                          ),
                                        ),
                                      ),
                                      if (selectedIndex == i)
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                              icon: const Icon(Icons.delete),
                                              color: Colors.red,
                                              iconSize: 20,
                                              onPressed: () {
                                                _repository.deleteAccount(i);
                                                context
                                                    .read<SellerBloc>()
                                                    .add(UpdateScreenEvent());
                                              }),
                                        )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                color: Colors.orange,
              ),
              if (_diffAccounts)
                Container(
                  width: 200,
                  color: const Color(0xff0a0a0a),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: List.generate(toBuyRepo.getAccounts.length,
                            (index) {
                          final account = toBuyRepo.getAccounts[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                child: Text(account.login,
                                    style: WHITE_TEXT_STYLE),
                                onTap: () {
                                  _buyIndex = index;
                                },
                              ),
                              SizedBox(
                                height: 40,
                                width: 50,
                                child: SellerTextField(
                                    width: 50, controller: _horsesController),
                              )
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              Container(
                width: 1,
                color: Colors.orange,
              ),
              Container(
                width: 500,
                color: const Color(0xff0a0a0a),
                child: Column(
                  children: [
                    SettingsWidget(
                      settingName: 'Завод',
                      widgets: [
                        Text(state.accounts[selectedIndex].settings.factory[0].name, style: WHITE_TEXT_STYLE),
                        SizedBox(width: 10,),
                        Text(state.accounts[selectedIndex].settings.factory[1].name, style: WHITE_TEXT_STYLE),
                      ],
                    ),
                    SettingsWidget(
                      settingName: 'Возраст',
                      widgets: [
                        SellerTextField(width: 100, controller: _ageController),
                      ],
                    ),
                    SettingsWidget(
                      settingName: 'Пол',
                      widgets: [
                        SellerChip(
                            title: 'Жеребец',
                            onTap: () {},
                            isSelected: true,
                            icon: true),
                        const SizedBox(width: 8),
                        SellerChip(
                            title: 'Кобыла',
                            onTap: () {},
                            isSelected: false,
                            icon: false)
                      ],
                    ),
                    SettingsWidget(
                      settingName: 'Тип продажи',
                      widgets: [
                        SellerChip(
                            title: 'Прямая',
                            onTap: () {},
                            isSelected: true,
                            icon: true),
                        SellerChip(
                            title: 'Резерв',
                            onTap: () {},
                            isSelected: false,
                            icon: false),
                      ],
                    ),
                    SettingsWidget(
                      settingName: 'Ник',
                      widgets: [
                        SellerTextField(
                            width: 100, controller: _nickNameController),
                      ],
                    ),
                    SettingsWidget(
                      settingName: 'Цена',
                      widgets: [
                        SellerTextField(
                            width: 100, controller: _costController),
                      ],
                    ),
                    SettingsWidget(
                      settingName: 'Валюта',
                      widgets: [
                        SellerChip(
                            title: 'Экю',
                            onTap: () {},
                            isSelected: true,
                            icon: true),
                        SellerChip(
                            title: 'Пропы',
                            onTap: () {},
                            isSelected: false,
                            icon: false),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context.read<SellerBloc>().add(SaveSettingsEvent(
                              settings: Settings(
                                  account: accounts[selectedIndex].login,
                                  factory: [],
                                  sex: '',
                                  age: int.parse(_ageController.text),
                                  sellType: '',
                                  cost: int.parse(_costController.text),
                                  money: '',
                                  nickname: _nickNameController.text),
                              index: selectedIndex));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: PRIMARY_COLOR),
                        child: const Text('Сохранить настройки',
                            style: WHITE_TEXT_SMALL_STYLE)),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _showDialog(BuildContext context) {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.black,
            child: AlertDialog(
              backgroundColor: Colors.black12,
              title: const Text('Добавить аккаунт'),
              actions: [
                TextField(
                  onChanged: (value) {},
                  controller: _loginController,
                ),
                TextField(
                  controller: _passwordController,
                ),
                ElevatedButton(
                    onPressed: () {
                      _repository.addNewAccount(SellAccount(
                          login: _loginController.text,
                          password: _passwordController.text,
                          settings: Settings(
                              account: '',
                              factory: [],
                              sex: '',
                              sellType: '',
                              cost: 500,
                              money: '',
                              nickname: '',
                              age: 1)));
                      context.read<SellerBloc>().add(UpdateScreenEvent());
                      Navigator.of(context).pop();
                    },
                    child: const Text('Добавить', style: WHITE_TEXT_STYLE)),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Закрыть', style: WHITE_TEXT_STYLE)),
              ],
            ),
          );
        });
    context.read<SellerBloc>().add(UpdateScreenEvent());
  }

// void changeSettings() {
//   final acc = toSellRepo.getAccounts[_sellIndex];
//   toSellRepo.changeSettings(
//       _sellIndex,
//       SellAccount(
//           login: acc.login,
//           password: acc.password,
//           settings: Settings(
//               id: _sellIndex,
//               factory: factory,
//               age: int.parse(_ageController.text),
//               sex: sex,
//               gp: int.parse(_gpController.text),
//               skills: int.parse(_skillsController.text),
//               chK: true,
//               race: race,
//               sellType: sellType,
//               cost: int.parse(_costController.text),
//               money: money,
//               nickname: _diffAccounts
//                   ? toBuyRepo.getAccounts[_sellIndex].login
//                   : _nickNameController.text)));
// }
}
