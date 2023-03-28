import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw_seller/account_manager/acc_sell_repo.dart';
import 'package:lw_seller/account_manager/account.dart';
import 'package:lw_seller/constants.dart';
import 'package:lw_seller/settings/settings.dart';
import 'package:lw_seller/ui/seller_screen/bloc/seller_bloc.dart';

class SellerListTile extends StatefulWidget {
  SellerListTile({Key? key, required this.accounts, required this.age, required this.nickname, required this.cost})
      : super(key: key);

  final List<SellAccount> accounts;
  final ToSellRepository _repository = ToSellRepository.instance;
  int selectedIndex = 0;
  final bloc = SellerBloc();
  final int age;
  final String nickname;
  final int cost;

  @override
  State<SellerListTile> createState() => _SellerListTileState();
}

class _SellerListTileState extends State<SellerListTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            itemCount: widget.accounts.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    widget.selectedIndex = i;
                  });
                },
                //() => setState(() => widget.selectedIndex = i),
                child: Container(
                  height: 40,
                  color: i == widget.selectedIndex
                      ? Colors.orange
                      : Colors.transparent,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            widget.accounts[i].login,
                            style: WHITE_TEXT_STYLE,
                          ),
                        ),
                      ),
                      if (widget.selectedIndex == i)
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                              iconSize: 20,
                              onPressed: () {
                                widget._repository.deleteAccount(i);
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
    );
  }
}
