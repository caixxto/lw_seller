import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw_seller/account_manager/acc_buy_repo.dart';
import 'package:lw_seller/account_manager/acc_sell_repo.dart';
import 'package:lw_seller/account_manager/account.dart';
import 'package:lw_seller/settings/settings.dart';
import 'package:lw_seller/constants.dart';
import 'package:lw_seller/settings/settings_repo.dart';
import 'package:lw_seller/ui/seller_screen/bloc/seller_bloc.dart';
import 'package:lw_seller/ui/widgets/chip.dart';
import 'package:lw_seller/ui/widgets/setting_widget.dart';
import 'package:lw_seller/ui/widgets/text_field.dart';

import '../widgets/drop_list_model.dart';

class SellerScreen extends StatefulWidget {
  const SellerScreen({Key? key}) : super(key: key);

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  List<String> selected = [];
  bool _diffAccounts = false;
  final toSellRepo = ToSellRepository();
  final toBuyRepo = ToBuyRepository();
  int _sellIndex = 0;
  int _buyIndex = 0;
  bool _sellChoose = false;
  bool _buyChoose = false;
  final TextEditingController _horsesController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();
  final TextEditingController _gpController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  late String factory;
  late String sex;
  late String race;
  late String money;
  late String sellType;

  final Bloc bloc = SellerBloc();
  final settingsRepo = SettingsRepository();

  OptionItem optionItemSelected =
      OptionItem(id: '', title: "Chọn quyền truy cập");

  @override
  Widget build(BuildContext context) {
    final sellAccounts = toSellRepo.getAccounts;

    return BlocConsumer<SellerBloc, SellerState>(
      listener: (context, state) {},
      builder: (context, state) {
        final acco = toSellRepo.getAccounts[_sellIndex];
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.orange,
            actions: [
              Row(
                children: [
                  const Text('Ставить на разные акки', style: WHITE_TEXT_STYLE),
                  Checkbox(
                      value: _diffAccounts,
                      onChanged: (value) {
                        setState(() {
                          _diffAccounts = value ?? false;
                        });
                      }),
                  const Text('Старт', style: WHITE_TEXT_STYLE),
                ],
              )
            ],
          ),
          body: Container(
            child: Row(
              children: [
                Container(
                  width: 150,
                  color: Color(0xff0a0a0a),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () {},
                                child: const Icon(Icons.add_circle)),
                            GestureDetector(
                                onTap: () {},
                                child: const Icon(Icons.add_circle_outline)),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    toSellRepo.deleteAccount(_sellIndex);
                                    _sellIndex = 0;
                                  });
                                },
                                child: const Icon(Icons.remove)),
                          ],
                        ),
                      ),
                      Column(
                        children: List.generate(toSellRepo.getAccounts.length,
                            (index) {
                          final account = toSellRepo.getAccounts[index];
                          return GestureDetector(
                            child: Text(account.login,
                                style: _sellChoose
                                    ? GREY_TEXT_STYLE
                                    : WHITE_TEXT_STYLE),
                            onTap: () {
                              _sellIndex = index;
                            },
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
                if (_diffAccounts)
                  Container(
                    width: 200,
                    color: Color(0xff0a0a0a),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                  onTap: () {},
                                  child: const Icon(Icons.add_circle)),
                              GestureDetector(
                                  onTap: () {},
                                  child: const Icon(Icons.add_circle_outline)),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      toBuyRepo.deleteAccount(_sellIndex);
                                      _buyIndex = 0;
                                    });
                                  },
                                  child: const Icon(Icons.remove)),
                            ],
                          ),
                        ),
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
                                    child: SellerTextField(width: 50),)
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
                  color: Color(0xff0a0a0a),
                  child: Column(
                    children: [
                      SettingsWidget(
                        settingName: 'Завод',
                        widgets: [],
                      ),
                      SettingsWidget(
                        settingName: 'Возраст',
                        widgets: [
                          SellerTextField(width: 100),
                        ],
                      ),
                      SettingsWidget(
                        settingName: 'Пол',
                        widgets: [
                          SellerChip(
                              title: 'Жеребец',
                              onTap: () {
                              },
                              isSelected: true,
                              icon: true),
                          SizedBox(width: 8),
                          SellerChip(
                              title: 'Кобыла',
                              onTap: () {
                              },
                              isSelected: false,
                              icon: false)
                        ],
                      ),
                      SettingsWidget(
                        settingName: 'Навыки',
                        widgets: [
                          SellerTextField(width: 100),
                        ],
                      ),
                      SettingsWidget(
                        settingName: 'ГП',
                        widgets: [
                          SellerTextField(width: 100),
                        ],
                      ),
                      SettingsWidget(
                        settingName: 'ЧК',
                        widgets: [

                        ],
                      ),
                      SettingsWidget(
                        settingName: 'Порода',
                        widgets: [],
                      ),
                      SettingsWidget(
                        settingName: 'Тип продажи',
                        widgets: [
                          SellerChip(
                              title: 'Прямая',
                              onTap: () {

                              },
                              isSelected: true,
                              icon: true),
                          SellerChip(
                              title: 'Резерв',
                              onTap: () {

                              },
                              isSelected: false,
                              icon: false),
                        ],
                      ),
                      SettingsWidget(
                        settingName: 'Ник',
                        widgets: [
                          SellerTextField(width: 100),
                        ],
                      ),
                      SettingsWidget(
                        settingName: 'Цена',
                        widgets: [
                          SellerTextField(width: 100),
                        ],
                      ),
                      SettingsWidget(
                        settingName: 'Валюта',
                        widgets: [
                          SellerChip(
                              title: 'Экю',
                              onTap: () {

                              },
                              isSelected: true,
                              icon: true),
                          SellerChip(
                              title: 'Пропы',
                              onTap: () {

                              },
                              isSelected: false,
                              icon: false),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
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
