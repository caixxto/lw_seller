import 'package:flutter/material.dart';
import 'package:lw_seller/constants.dart';

class SettingsWidget extends StatefulWidget {
  SettingsWidget({Key? key, required this.settingName, required this.widgets}) : super(key: key);
  final List<Widget> widgets;
  final String settingName;

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(widget.settingName, style: WHITE_TEXT_STYLE),
          const SizedBox(width: 50),
          Row(
            children: widget.widgets,
          )
        ],

      ),
    );
  }
}
