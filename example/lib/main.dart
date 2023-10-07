import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(new MyApp());

class CustomPicker extends picker.CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({DateTime? currentTime, picker.LocaleType? locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.year);
    this.setMiddleIndex(this.currentTime.month);
    this.setRightIndex(this.currentTime.month);
  }

  @override
  String? leftStringAtIndex(int index) {
    return '$index';
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index < 1 || index > 12) return null;
    return '$index';
  }

  @override
  Widget? leftDividerWidget() {
    // TODO: implement leftDividerWidget
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        left: 10,
      ),
      height: 44,
      child: Text(
        '年',
        style: TextStyle(color: Color(0xff92969A), fontSize: 13),
      ),
      decoration: BoxDecoration(
          border: Border(
        left: BorderSide(color: Color(0xff3B3D3F)),
      )),
    );
  }

  @override
  Widget? rightDividerWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        left: 10,
      ),
      height: 44,
      child:
          Text('月', style: TextStyle(color: Color(0xff92969A), fontSize: 13)),
      decoration: BoxDecoration(
          border: Border(
        left: BorderSide(color: Color(0xff3B3D3F)),
      )),
    );
  }

  @override
  String? rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? actionTitle() {
    // TODO: implement actionTitle
    return '选择日期';
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 1, 1];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex())
        : DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex());
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, child) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new HomePage(),
      );
    },
      designSize: const Size(430, 812),);
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datetime Picker'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextButton(
                onPressed: () {
                  picker.DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2018, 3, 5),
                      maxTime: DateTime(2019, 6, 7),
                      theme: picker.DatePickerTheme(
                          headerColor: Colors.orange,
                          backgroundColor: Colors.blue,
                          itemStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          doneStyle:
                              TextStyle(color: Colors.white, fontSize: 16)),
                      onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                  }, onConfirm: (date) {
                    print('confirm $date');
                  }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
                },
                child: Text(
                  'show date picker(custom theme &date time range)',
                  style: TextStyle(color: Colors.blue),
                )),
            TextButton(
                onPressed: () {
                  picker.DatePicker.showTimePicker(context,
                      showTitleActions: true, onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                  }, onConfirm: (date) {
                    print('confirm $date');
                  }, currentTime: DateTime.now());
                },
                child: Text(
                  'show time picker',
                  style: TextStyle(color: Colors.blue),
                )),
            TextButton(
                onPressed: () {
                  picker.DatePicker.showTime12hPicker(context,
                      showTitleActions: true, onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                  }, onConfirm: (date) {
                    print('confirm $date');
                  }, currentTime: DateTime.now());
                },
                child: Text(
                  'show 12H time picker with AM/PM',
                  style: TextStyle(color: Colors.blue),
                )),
            TextButton(
                onPressed: () {
                  picker.DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2020, 5, 5, 20, 50),
                      maxTime: DateTime(2020, 6, 7, 05, 09), onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                  }, onConfirm: (date) {
                    print('confirm $date');
                  }, locale: picker.LocaleType.zh);
                },
                child: Text(
                  'show date time picker (Chinese)',
                  style: TextStyle(color: Colors.blue),
                )),
            TextButton(
                onPressed: () {
                  picker.DatePicker.showDateTimePicker(context,
                      showTitleActions: true, onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                  }, onConfirm: (date) {
                    print('confirm $date');
                  }, currentTime: DateTime(2008, 12, 31, 23, 12, 34));
                },
                child: Text(
                  'show date time picker (English-America)',
                  style: TextStyle(color: Colors.blue),
                )),
            TextButton(
                onPressed: () {
                  picker.DatePicker.showDateTimePicker(context,
                      showTitleActions: true, onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                  }, onConfirm: (date) {
                    print('confirm $date');
                  },
                      currentTime: DateTime(2008, 12, 31, 23, 12, 34),
                      locale: picker.LocaleType.nl);
                },
                child: Text(
                  'show date time picker (Dutch)',
                  style: TextStyle(color: Colors.blue),
                )),
            TextButton(
                onPressed: () {
                  picker.DatePicker.showDateTimePicker(context,
                      showTitleActions: true, onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                  }, onConfirm: (date) {
                    print('confirm $date');
                  },
                      currentTime: DateTime(2008, 12, 31, 23, 12, 34),
                      locale: picker.LocaleType.ru);
                },
                child: Text(
                  'show date time picker (Russian)',
                  style: TextStyle(color: Colors.blue),
                )),
            TextButton(
                onPressed: () {
                  picker.DatePicker.showDateTimePicker(context,
                      showTitleActions: true, onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                  }, onConfirm: (date) {
                    print('confirm $date');
                  },
                      currentTime: DateTime.utc(2019, 12, 31, 23, 12, 34),
                      locale: picker.LocaleType.de);
                },
                child: Text(
                  'show date time picker in UTC (German)',
                  style: TextStyle(color: Colors.blue),
                )),
            TextButton(
                onPressed: () {
                  picker.DatePicker.showPicker(context,
                      theme: picker.DatePickerTheme(
                        containerHeight: 250,
                        cancelStyle: TextStyle(color: Colors.white),
                          itemStyle: TextStyle(
                              color: Color(0xff333333),
                              fontWeight: FontWeight.w500,
                              fontSize: 25.sp),
                          backgroundColor: Colors.white),
                      showTitleActions: false, onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                  }, onConfirm: (date) {
                    print('confirm $date');
                  },
                      pickerModel: DatePickerModel(),
                      locale: picker.LocaleType.en);
                },
                child: Text(
                  'show custom time picker,\nyou can custom picker model like this',
                  style: TextStyle(color: Colors.blue),
                )),
          ],
        ),
      ),
    );
  }
}
