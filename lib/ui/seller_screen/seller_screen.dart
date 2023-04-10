import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lw_seller/account_manager/account.dart';
import 'package:lw_seller/account_manager/factory.dart';
import 'package:lw_seller/settings/settings.dart';
import 'package:lw_seller/constants.dart';
import 'package:lw_seller/ui/seller_screen/bloc/seller_bloc.dart';
import 'package:lw_seller/ui/widgets/chip.dart';
import 'package:lw_seller/ui/widgets/setting_widget.dart';
import 'package:lw_seller/ui/widgets/text_field.dart';

class SellerScreen extends StatelessWidget {
  bool _diffAccounts = false;

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _horsesController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();
  final TextEditingController _gpController = TextEditingController();

  SellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SellerBloc, SellerState>(
      listener: (context, state) {},
      builder: (context, state) {

        if (state is SellerInitial) {
          return CircularProgressIndicator();
        }

        var accounts = (state as UpdateScreenState).accountsInfo;
        final acc = state.accountsInfo[state.index].account;
        final sett = state.accountsInfo[state.index].settings;
        _ageController.text = sett.age.toString();
        _nickNameController.text = sett.nickname;
        _priceController.text = sett.price.toString();
        _skillsController.text = sett.skills.toString();
        _gpController.text = sett.gp.toString();

        if (state is UpdateScreenState) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.orange,
              actions: [
                Row(
                  children: [
                    Text(state.status),
                    const Text('Ставить на разные акки',
                        style: WHITE_TEXT_STYLE),
                    Checkbox(
                        value: _diffAccounts,
                        onChanged: (value) {
                          _diffAccounts = value ?? false;
                          context
                              .read<SellerBloc>()
                              .add(UpdateScreenEvent(index: state.index));
                        }),
                    ElevatedButton(
                        onPressed: () {
                          context.read<SellerBloc>().add(StartFilterEvent(account: state.accountsInfo[state.index]));
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
                                  //TODO: null index
                                  context
                                      .read<SellerBloc>()
                                      .add(ClearAccountEvent());
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
                                    context
                                        .read<SellerBloc>()
                                        .add(UpdateScreenEvent(index: i));
                                  },
                                  child: Container(
                                    height: 40,
                                    color: i == state.index
                                        ? Colors.orange
                                        : Colors.transparent,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              accounts[i].account.login,
                                              style: WHITE_TEXT_STYLE,
                                            ),
                                          ),
                                        ),
                                        if (state.index == i)
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                                icon: const Icon(Icons.delete),
                                                color: Colors.red,
                                                iconSize: 20,
                                                onPressed: () {
                                                  //TODO: delete
                                                  //_repository.deleteAccount(i);
                                                  // context
                                                  //     .read<SellerBloc>()
                                                  //     .add(UpdateScreenEvent(index: state.index));
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
                        // Column(
                        //   children: List.generate(toBuyRepo.getAccounts.length,
                        //       (index) {
                        //     final account = toBuyRepo.getAccounts[index];
                        //     return Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //       children: [
                        //         GestureDetector(
                        //           child: Text(account.login,
                        //               style: WHITE_TEXT_STYLE),
                        //           onTap: () {
                        //             _buyIndex = index;
                        //           },
                        //         ),
                        //         SizedBox(
                        //           height: 40,
                        //           width: 50,
                        //           child: SellerTextField(
                        //             width: 50,
                        //             controller: _horsesController,
                        //             onChanged: (text) {
                        //               print(text);
                        //             },
                        //           ),
                        //         )
                        //       ],
                        //     );
                        //   }),
                        // ),
                      ],
                    ),
                  ),
                Container(
                  width: 1,
                  color: Colors.orange,
                ),
                Container(
                  width: 900,
                  color: const Color(0xff0a0a0a),
                  child: Column(
                    children: [
                      SettingsWidget(
                        settingName: 'Завод',
                        widgets: [
                          SellerChip(
                            onSelected: (value) {
                              context.read<SellerBloc>().add(SaveAccountEvent(
                                  index: state.index,
                                  info: AccountInfo(
                                      account: SellAccount(
                                          login: acc.login,
                                          password: acc.password),
                                      settings: Setting(
                                          allFactories: sett.allFactories,
                                          factory: sett.allFactories.firstWhere((e) => e.name == value),
                                          age: sett.age,
                                          sex: sett.sex,
                                          sellType: sett.sellType,
                                          nickname: sett.nickname,
                                          price: sett.price,
                                          currency: sett.currency,
                                          skills: sett.skills,
                                          gp: sett.gp,
                                          chk: sett.chk))));
                            },
                            title: sett.factory.name,
                            titleList: sett.allFactories.map((e) => e.name).toList(),
                          ),
                        ],
                      ),
                      SettingsWidget(
                        settingName: 'Возраст',
                        widgets: [
                          SellerTextField(
                            width: 100,
                            controller: _ageController,
                            onChanged: (value) {
                              context.read<SellerBloc>().add(SaveAccountEvent(
                                  index: state.index,
                                  info: AccountInfo(
                                      account: SellAccount(
                                          login: acc.login,
                                          password: acc.password),
                                      settings: Setting(
                                          allFactories: sett.allFactories,
                                          factory: sett.factory,
                                          age: value,
                                          sex: sett.sex,
                                          sellType: sett.sellType,
                                          nickname: sett.nickname,
                                          price: sett.price,
                                          currency: sett.currency,
                                          skills: sett.skills,
                                          gp: sett.gp,
                                          chk: sett.chk))));
                            },
                          ),
                        ],
                      ),
                      SettingsWidget(
                        settingName: 'ГП',
                        widgets: [
                          SellerTextField(
                            width: 100,
                            controller: _gpController,
                            onChanged: (value) {
                              context.read<SellerBloc>().add(SaveAccountEvent(
                                  index: state.index,
                                  info: AccountInfo(
                                      account: SellAccount(
                                          login: acc.login,
                                          password: acc.password),
                                      settings: Setting(
                                          allFactories: sett.allFactories,
                                          factory: sett.factory,
                                          age: sett.age,
                                          sex: sett.sex,
                                          sellType: sett.sellType,
                                          nickname: sett.nickname,
                                          price: sett.price,
                                          currency: sett.currency,
                                          skills: sett.skills,
                                          gp: value,
                                          chk: sett.chk))));
                            },
                          ),
                        ],
                      ),
                      SettingsWidget(
                        settingName: 'Навыки',
                        widgets: [
                          SellerTextField(
                            width: 100,
                            controller: _skillsController,
                            onChanged: (value) {
                              context.read<SellerBloc>().add(SaveAccountEvent(
                                  index: state.index,
                                  info: AccountInfo(
                                      account: SellAccount(
                                          login: acc.login,
                                          password: acc.password),
                                      settings: Setting(
                                          allFactories: sett.allFactories,
                                          factory: sett.factory,
                                          age: sett.age,
                                          sex: sett.sex,
                                          sellType: sett.sellType,
                                          nickname: sett.nickname,
                                          price: sett.price,
                                          currency: sett.currency,
                                          skills: value,
                                          gp: sett.gp,
                                          chk: sett.chk))));
                            },
                          ),
                        ],
                      ),
                      SettingsWidget(
                        settingName: 'Пол',
                        widgets: [
                          SellerChip(
                            onSelected: (title) {
                              context.read<SellerBloc>().add(SaveAccountEvent(
                                  index: state.index,
                                  info: AccountInfo(
                                      account: SellAccount(
                                          login: acc.login,
                                          password: acc.password),
                                      settings: Setting(
                                          allFactories: sett.allFactories,
                                          factory: sett.factory,
                                          age: sett.age,
                                          sex: title,
                                          sellType: sett.sellType,
                                          nickname: sett.nickname,
                                          price: sett.price,
                                          currency: sett.currency,
                                          skills: sett.skills,
                                          gp: sett.gp,
                                          chk: sett.chk))));
                            },
                            title: sett.sex,
                            titleList: ['Жеребец', 'Кобыла', 'Любой'],
                          ),
                        ],
                      ),
                      SettingsWidget(
                        settingName: 'ЧК',
                        widgets: [
                          SellerChip(
                            onSelected: (title) {
                              context.read<SellerBloc>().add(SaveAccountEvent(
                                  index: state.index,
                                  info: AccountInfo(
                                      account: SellAccount(
                                          login: acc.login,
                                          password: acc.password),
                                      settings: Setting(
                                          allFactories: sett.allFactories,
                                          factory: sett.factory,
                                          age: sett.age,
                                          sex: sett.sex,
                                          sellType: sett.sellType,
                                          nickname: sett.nickname,
                                          price: sett.price,
                                          currency: sett.currency,
                                          skills: sett.skills,
                                          gp: sett.gp,
                                          chk: title))));
                            },
                            title: sett.chk,
                            titleList: ['Чк', 'Нечк', 'Все'],
                          ),
                        ],
                      ),
                      SettingsWidget(
                        settingName: 'Тип продажи',
                        widgets: [
                          SellerChip(
                            title: sett.sellType,
                            onSelected: (title) {
                              context.read<SellerBloc>().add(SaveAccountEvent(
                                  index: state.index,
                                  info: AccountInfo(
                                      account: SellAccount(
                                          login: acc.login,
                                          password: acc.password),
                                      settings: Setting(
                                          allFactories: sett.allFactories,
                                          factory: sett.factory,
                                          age: sett.age,
                                          sex: sett.sex,
                                          sellType: title,
                                          nickname: sett.nickname,
                                          price: sett.price,
                                          currency: sett.currency,
                                          skills: sett.skills,
                                          gp: sett.gp,
                                          chk: sett.chk))));
                            },
                            titleList: ['Прямая', 'Резерв'],
                          ),
                        ],
                      ),
                      SettingsWidget(
                        settingName: 'Ник',
                        widgets: [
                          SellerTextField(
                            width: 100,
                            controller: _nickNameController,
                            onChanged: (text) {
                              context.read<SellerBloc>().add(SaveAccountEvent(
                                  index: state.index,
                                  info: AccountInfo(
                                      account: SellAccount(
                                          login: acc.login,
                                          password: acc.password),
                                      settings: Setting(
                                          allFactories: sett.allFactories,
                                          factory: sett.factory,
                                          age: sett.age,
                                          sex: sett.sex,
                                          sellType: sett.sellType,
                                          nickname: text,
                                          price: sett.price,
                                          currency: sett.currency,
                                          skills: sett.skills,
                                          gp: sett.gp,
                                          chk: sett.chk))));
                            },
                          ),
                        ],
                      ),
                      SettingsWidget(
                        settingName: 'Цена',
                        widgets: [
                          SellerTextField(
                            width: 100,
                            controller: _priceController,
                            onChanged: (text) {
                              context.read<SellerBloc>().add(SaveAccountEvent(
                                  index: state.index,
                                  info: AccountInfo(
                                      account: SellAccount(
                                          login: acc.login,
                                          password: acc.password),
                                      settings: Setting(
                                          allFactories: sett.allFactories,
                                          factory: sett.factory,
                                          age: sett.age,
                                          sex: sett.sex,
                                          sellType: sett.sellType,
                                          nickname: sett.nickname,
                                          price: text,
                                          currency: sett.currency,
                                          skills: sett.skills,
                                          gp: sett.gp,
                                          chk: sett.chk))));
                            },
                          ),
                        ],
                      ),
                      SettingsWidget(
                        settingName: 'Валюта',
                        widgets: [
                          SellerChip(
                            title: sett.currency,
                            onSelected: (title) {
                              context.read<SellerBloc>().add(SaveAccountEvent(
                                  index: state.index,
                                  info: AccountInfo(
                                      account: SellAccount(
                                          login: acc.login,
                                          password: acc.password),
                                      settings: Setting(
                                          allFactories: sett.allFactories,
                                          factory: sett.factory,
                                          age: sett.age,
                                          sex: sett.sex,
                                          sellType: sett.sellType,
                                          nickname: sett.nickname,
                                          price: sett.price,
                                          currency: title,
                                          skills: sett.skills,
                                          gp: sett.gp,
                                          chk: sett.chk))));
                            },
                            titleList: ['Экю', 'Пропы'],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return Placeholder();
        }
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
                      // _repository.addNewAccount(SellAccount(
                      //     login: _loginController.text,
                      //     password: _passwordController.text,
                      //     settings: Settings(
                      //         account: '',
                      //         factory: [],
                      //         sex: '',
                      //         sellType: '',
                      //         cost: 500,
                      //         money: '',
                      //         nickname: '',
                      //         age: 1)));
                      // context.read<SellerBloc>().add(UpdateScreenEvent());
                      // Navigator.of(context).pop();
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
    //context.read<SellerBloc>().add(UpdateScreenEvent());
  }
}
