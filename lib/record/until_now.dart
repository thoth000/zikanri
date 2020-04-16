import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import '../data.dart';

class UntilNow extends StatelessWidget {
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: _TitleWidget(),
        ),
        _TimeWidget(),
        _CategoryWidget(),
        _ValueWidget(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 1,
            width: displaySize.width,
            color: Colors.grey,
          ),
        ),
        _ResultWidget(),
      ],
    );
  }
}

//Widgets =>
//タイトル
class _TitleWidget extends StatefulWidget {
  @override
  __TitleWidgetState createState() => __TitleWidgetState();
}

class __TitleWidgetState extends State<_TitleWidget> {
  void _handleText(String e) {
    setState(() {
      title = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "タイトル",
        hintStyle: TextStyle(color: Colors.grey),
      ),
      style: TextStyle(
        fontSize: displaySize.width / 10,
        fontWeight: FontWeight.w700,
      ),
      maxLength: 30,
      onChanged: _handleText,
    );
  }
}

class _TimeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Icon(
                Icons.access_time,
                size: displaySize.width / 8,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Icon(
                  null,
                  size: displaySize.width / 8,
                ),
              ),
              Icon(
                null,
                size: displaySize.width / 8,
              ),
            ],
          ),
          _TimeBottons(),
        ],
      ),
    );
  }
}

class _TimeBottons extends StatefulWidget {
  @override
  __TimeBottonsState createState() => __TimeBottonsState();
}

class __TimeBottonsState extends State<_TimeBottons> {
  DateTime _startTime = DateTime.now();
  DateTime _finishTime = DateTime.now();

  void _duration() {
    int startmin;
    int finishmin;
    var tmp;
    setState(() {
      try {
        startmin =
            int.parse(DateFormat('HH').format(_startTime).toString()) * 60 +
                int.parse(DateFormat('mm').format(_startTime).toString());
        finishmin =
            int.parse(DateFormat('HH').format(_finishTime).toString()) * 60 +
                int.parse(DateFormat('mm').format(_finishTime).toString());
      } catch (exception) {
        startmin = 0;
        finishmin = 0;
      }
      if (startmin > finishmin) {
        setState(() {
          tmp = _startTime;
          _startTime = _finishTime;
          _finishTime = tmp;
          tmp = startmin;
          startmin = finishmin;
          finishmin = tmp;
        });
      }
      time = finishmin - startmin;
      tmpValue = (time * rating).toInt();
    });
  }

  Future<Null> _startTimeSelect(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _startTime = DateTime(2020, 12, 31, picked.hour, picked.minute);
        _duration();
        tmpValue = (time * rating).toInt();
      });
    }
  }

  Future<Null> _finishTimeSelect(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _finishTime = DateTime(2020, 12, 31, picked.hour, picked.minute);
        _duration();
        tmpValue = (time * rating).toInt();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: displaySize.width / 8,
          width: displaySize.width / 3,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            onPressed: () => _startTimeSelect(context),
            child: Text(
              DateFormat('HH時mm分').format(_startTime),
              style: TextStyle(
                fontSize: displaySize.width / 20,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            Icons.arrow_downward,
            size: displaySize.width / 8,
          ),
        ),
        Container(
          height: displaySize.width / 8,
          width: displaySize.width / 3,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            onPressed: () => _finishTimeSelect(context),
            child: Text(
              DateFormat('HH時mm分').format(_finishTime),
              style: TextStyle(
                fontSize: displaySize.width / 20,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//カテゴリー
class _CategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.category,
            size: displaySize.width / 8,
          ),
          Container(
            height: displaySize.width / 8,
            width: displaySize.width / 2,
            child: _CategoryBotton(),
          ),
        ],
      ),
    );
  }
}

class _CategoryBotton extends StatefulWidget {
  @override
  __CategoryBottonState createState() => __CategoryBottonState();
}

class __CategoryBottonState extends State<_CategoryBotton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      onPressed: () => null,
      child: Text(
        (false) ? '' : 'カテゴリーを選択',
        style: TextStyle(
          fontSize: displaySize.width / 20,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ValueWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.local_parking,
            size: displaySize.width / 8,
          ),
          Container(
            height: displaySize.width / 8,
            width: displaySize.width / 1.8,
            child: _ValueSlider(),
          ),
        ],
      ),
    );
  }
}

class _ValueSlider extends StatefulWidget {
  @override
  __ValueSliderState createState() => __ValueSliderState();
}

class __ValueSliderState extends State<_ValueSlider> {
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: rating,
      min: 0,
      max: 5,
      divisions: 5,
      label: rating.toInt().toString() + 'pt',
      onChanged: (newRating) {
        setState(() {
          rating = newRating;
          tmpValue = (rating * time).toInt();
        });
      },
    );
  }
}

class _ResultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '活動時間',
                  style: TextStyle(fontSize: displaySize.width / 25),
                ),
                _ResultMinite(),
              ],
            ),
            _ResultPoint(),
          ],
        ),
      ),
    );
  }
}

class _ResultMinite extends StatefulWidget {
  @override
  __ResultMiniteState createState() => __ResultMiniteState();
}

class __ResultMiniteState extends State<_ResultMinite> {
  @override
  Widget build(BuildContext context) {
    return Text(
      time.toString() + '分',
      style: TextStyle(
          fontSize: displaySize.width / 12, fontWeight: FontWeight.w700),
    );
  }
}

class _ResultPoint extends StatefulWidget {
  @override
  __ResultPointState createState() => __ResultPointState();
}

class __ResultPointState extends State<_ResultPoint> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          tmpValue.toString(),
          style:TextStyle(
            fontSize: displaySize.width / 5,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'pt',
          style: TextStyle(
            fontSize: displaySize.width / 9,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
