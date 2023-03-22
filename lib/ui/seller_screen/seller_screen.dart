import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lw_seller/account_manager/acc_buy_repo.dart';
import 'package:lw_seller/account_manager/acc_sell_repo.dart';
import 'package:lw_seller/account_manager/account.dart';
import 'package:lw_seller/account_manager/settings.dart';
import 'package:lw_seller/account_manager/settings_repo.dart';
import 'package:lw_seller/constants.dart';
import 'package:lw_seller/ui/seller_screen/bloc/seller_bloc.dart';

import '../widgets/drop_list_model.dart';
import '../widgets/select_drop_list.dart';

class SellerScreen extends StatefulWidget {
  const SellerScreen({Key? key}) : super(key: key);

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
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
            backgroundColor: Colors.grey,
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
                  color: Colors.red,
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
                if (_diffAccounts)
                  Container(
                    width: 200,
                    color: Colors.orange,
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
                                  width: 50,
                                  child: TextField(
                                    controller: _horsesController,
                                  ),
                                )
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                Container(
                  width: 500,
                  color: Colors.deepPurple,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text('Завод', style: WHITE_TEXT_STYLE),
                          SizedBox(
                              width: 300,
                              child: SelectDropList(
                                OptionItem(id: "0", title: "acco.settings.sex"),
                                DropListModel([
                                  OptionItem(id: "1", title: "Завод 1"),
                                  OptionItem(id: "2", title: "Завод 2")
                                ]),
                                (optionItem) {
                                  optionItemSelected = optionItem;
                                  //factory = optionItemSelected.title;
                                  //changeSettings();
                                  setState(() {});
                                },
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          Text('Возраст', style: WHITE_TEXT_STYLE),
                          SizedBox(
                              width: 300,
                              child: TextField(
                                controller: _ageController,
                                onEditingComplete: () {
                                  changeSettings();
                                },
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Пол', style: WHITE_TEXT_STYLE),
                          SizedBox(
                              width: 300,
                              child: SelectDropList(
                                OptionItem(id: "1", title: "Пол"),
                                DropListModel([
                                  OptionItem(id: "1", title: "Жеребец"),
                                  OptionItem(id: "2", title: "Кобыла")
                                ]),
                                (optionItem) {
                                  optionItemSelected = optionItem;
                                  //sex = optionItem.title;
                                  //changeSettings();
                                  setState(() {});
                                },
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Навыки', style: WHITE_TEXT_STYLE),
                          SizedBox(
                              width: 300,
                              child: TextField(
                                controller: _skillsController,
                                onEditingComplete: () {changeSettings();},
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          const Text('ГП', style: WHITE_TEXT_STYLE),
                          SizedBox(
                              width: 300,
                              child: TextField(
                                controller: _gpController,
                                onEditingComplete: () {changeSettings();},
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          const Text('ЧК', style: WHITE_TEXT_STYLE),
                          SizedBox(
                              width: 300,
                              child: Checkbox(
                                value: false,
                                onChanged: (bool? value) {},
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Порода', style: WHITE_TEXT_STYLE),
                          SizedBox(
                              width: 300,
                              child: SelectDropList(
                                OptionItem(id: "2", title: "Порода"),
                                DropListModel([
                                  OptionItem(
                                      id: "1",
                                      title: "Английская чистокровная"),
                                  OptionItem(
                                      id: "2",
                                      title: "Лошадь лузитанской породы")
                                ]),
                                (optionItem) {
                                  optionItemSelected = optionItem;
                                  race = optionItem.title;
                                  changeSettings();
                                  setState(() {});
                                },
                              ))
                        ],
                      ),
                      if (!_diffAccounts)
                        Row(
                          children: [
                            const Text('Тип продажи', style: WHITE_TEXT_STYLE),
                            SizedBox(
                                width: 300,
                                child: SelectDropList(
                                  OptionItem(id: "3", title: "Тип продажи"),
                                  DropListModel([
                                    OptionItem(
                                        id: "1", title: "Прямая продажа"),
                                    OptionItem(id: "2", title: "Резерв")
                                  ]),
                                  (optionItem) {
                                    optionItemSelected = optionItem;
                                    sellType = optionItem.title;
                                    changeSettings();
                                    setState(() {});
                                  },
                                ))
                          ],
                        ),
                      if (!_diffAccounts)
                        Row(
                          children: [
                            const Text('Ник', style: WHITE_TEXT_STYLE),
                            SizedBox(
                                width: 300,
                                child: TextField(
                                  controller: _nickNameController,
                                  //onEditingComplete: () {changeSettings();},
                                  onChanged: (text) {
                                    changeSettings();
                                  },

                                ))
                          ],
                        ),
                      Row(
                        children: [
                          const Text('Цена', style: WHITE_TEXT_STYLE),
                          SizedBox(
                              width: 300,
                              child: TextField(
                                controller: _costController,
                                onEditingComplete: () {changeSettings();},
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Валюта', style: WHITE_TEXT_STYLE),
                          SizedBox(
                              width: 300,
                              child: SelectDropList(
                                OptionItem(id: "2", title: "Валюта"),
                                DropListModel([
                                  OptionItem(id: "1", title: "Экю"),
                                  OptionItem(id: "2", title: "Пропы")
                                ]),
                                (optionItem) {
                                  optionItemSelected = optionItem;
                                  money = optionItem.title;
                                  changeSettings();
                                  setState(() {});
                                },
                              ))
                        ],
                      ),
                      if (!_diffAccounts)
                        Row(
                          children: [
                            const Text('Кол-во лошадей',
                                style: WHITE_TEXT_STYLE),
                            SizedBox(
                                width: 300,
                                child: TextField(
                                  controller: _horsesController,
                                  onEditingComplete: () {changeSettings();},
                                ))
                          ],
                        ),
                      ElevatedButton(
                          onPressed: () {
                            print(toSellRepo.getAccounts[0].settings.nickname);
                          },
                          child: Text('check'))
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

  void changeSettings() {
    final acc = toSellRepo.getAccounts[_sellIndex];
    toSellRepo.changeSettings(
        _sellIndex,
        SellAccount(
            login: acc.login,
            password: acc.password,
            settings: Settings(
                id: _sellIndex,
                factory: factory,
                age: int.parse(_ageController.text),
                sex: sex,
                gp: int.parse(_gpController.text),
                skills: int.parse(_skillsController.text),
                chK: true,
                race: race,
                sellType: sellType,
                cost: int.parse(_costController.text),
                money: money,
                nickname: _diffAccounts
                    ? toBuyRepo.getAccounts[_sellIndex].login
                    : _nickNameController.text)));
  }
}
