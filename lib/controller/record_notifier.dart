import 'package:flutter/material.dart';
import 'package:zikanri/data.dart';

//changeNotifier for record
class RecordNotifier with ChangeNotifier {
  String _title = '';
  String get title => _title;
  bool _isRecord = true;
  bool get isRecord => _isRecord;
  int _categoryIndex = 0;
  int get categoryIndex => _categoryIndex;
  bool _isGood = false;
  bool get isGood => _isGood;
  int _time = 0;
  int get time => _time;
  bool _timeCheck = true;
  bool get timeCheck => _timeCheck;
  bool _titleCheck = true;
  bool get titleCheck => _titleCheck;
  bool _clickCheck = false;
  bool get clickCheck => _clickCheck;
  bool check() => _isRecord ? (_titleCheck || _timeCheck) : _titleCheck;

  void changeTitle(String s) {
    _title = s;
    if (_title == '') {
      _titleCheck = true;
    } else {
      _titleCheck = false;
    }
    notifyListeners();
  }

  void changeTime(String s) {
    if (s == '') {
      _timeCheck = true;
    } else {
      final int _minute = int.parse(s);
      if (_minute > 1440 || _minute == 0) {
        _timeCheck = true;
      } else {
        _timeCheck = false;
        _time = _minute;
      }
    }
    notifyListeners();
  }

  void changeValue(bool b) {
    if (_isGood == b) {
    } else {
      _isGood = b;
      Vib.select();
      notifyListeners();
    }
  }

  void changeCategoryIndex(int index) {
    _categoryIndex = index;
    notifyListeners();
  }

  void recordMode() {
    if (_isRecord == true) {
    } else {
      Vib.select();
      _isRecord = true;
      _time = 0;
      _timeCheck = true;
      _clickCheck = false;
      notifyListeners();
    }
  }

  void startMode() {
    if (_isRecord == false) {
    } else {
      Vib.select();
      _isRecord = false;
      _time = 0;
      _timeCheck = false;
      _clickCheck = false;
      notifyListeners();
    }
  }

  void copyData(int tmpCategoryIndex, String tmpTitle, int tmpTime) {
    _title = tmpTitle;
    _categoryIndex = tmpCategoryIndex;
    _time = tmpTime;
    notifyListeners();
  }

  void reset() {
    _title = '';
    _categoryIndex = 0;
    _time = 0;
    _isGood = false;
    _timeCheck = true;
    _titleCheck = true;
    _isRecord = true;
    notifyListeners();
  }
}
