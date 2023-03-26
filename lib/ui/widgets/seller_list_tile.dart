import 'package:flutter/material.dart';
import 'package:lw_seller/account_manager/acc_sell_repo.dart';
import 'package:lw_seller/account_manager/account.dart';
import 'package:lw_seller/constants.dart';

class SellerListTile extends StatefulWidget {
  SellerListTile({Key? key, required this.accounts}) : super(key: key);

  final List<SellAccount> accounts;
  final ToSellRepository _repository = ToSellRepository();
  int selectedIndex = 0;

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
                onTap: () => setState(() => widget.selectedIndex = i),
                child: Container(
                  height: 40,
                  color: i == widget.selectedIndex
                      ? Colors.red
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
                            iconSize: 20,
                            onPressed: () {
                              widget._repository.deleteAccount(i);

                            },
                            icon: const Icon(Icons.delete),
                          ),
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
