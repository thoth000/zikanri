//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:zikanri/controller/add_time_controller.dart';
//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/ui/parts/bottom_sheet_bar.dart';

class AddSheet extends StatelessWidget {
  AddSheet._();
  static Widget wrapped(int index) {
    return ChangeNotifierProvider(
      create: (_) => AddTimeController(
        index: index,
      ),
      child: AddSheet._(),
    );
  }

  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom * 1.1,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetBar(),
          Text(
            '時間の追加',
            style: TextStyle(
              fontSize: FontSize.large,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: displaySize.width / 20,
          ),
          Row(
            children: [
              Text(
                '　時間（分）',
                style: TextStyle(
                  fontSize: FontSize.small,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: displaySize.width / 30,
              vertical: displaySize.width / 50,
            ),
            child: _TimeFieldWidget(),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: _AddTimeButton(),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

class _TimeFieldWidget extends StatefulWidget {
  @override
  __TimeFieldWidgetState createState() => __TimeFieldWidgetState();
}

class __TimeFieldWidgetState extends State<_TimeFieldWidget> {
  TextEditingController textController;

  @override
  void initState() {
    super.initState();
    setState(() {
      textController = TextEditingController();
    });
  }

  @override
  Widget build(BuildContext context) {
    final addTimeController = Provider.of<AddTimeController>(context);
    final theme = Provider.of<ThemeNotifier>(context);
    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return TextField(
      autofocus: true,
      controller: textController,
      style: TextStyle(
        fontSize: FontSize.midium,
      ),
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.go,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        hintText: '追加する時間',
        fillColor: Colors.grey,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
      ),
      onChanged: (text) {
        if (text.isEmpty) {
          addTimeController.changeTime(0);
        } else {
          int _time = int.parse(text);
          addTimeController.changeTime(_time);
        }
      },
    );
  }
}

class _AddTimeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addTimeController = Provider.of<AddTimeController>(context);
    final int index = addTimeController.index;
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    final theme = Provider.of<ThemeNotifier>(context);
    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Container(
      height: displaySize.width / 6.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(500),
        border: Border.all(
          color: addTimeController.timecheck ? color : color.withOpacity(0.5),
          width: 3,
        ),
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(500),
        ),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '追加する',
              style: TextStyle(
                color: addTimeController.timecheck ? null : Colors.grey,
                fontSize: FontSize.small,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        onPressed: addTimeController.timecheck
            ? () async {
                userData.addTime(
                  index,
                  addTimeController.time,
                );
                Navigator.pop(context);
              }
            : null,
      ),
    );
  }
}
