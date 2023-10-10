library flutter_datetime_picker;

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/src/date_model.dart';
import 'package:flutter_datetime_picker_plus/src/datetime_picker_theme.dart'
    as picker_theme;
import 'package:flutter_datetime_picker_plus/src/i18n_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

export 'package:flutter_datetime_picker_plus/src/date_model.dart';
export 'package:flutter_datetime_picker_plus/src/datetime_picker_theme.dart';
export 'package:flutter_datetime_picker_plus/src/i18n_model.dart';

typedef DateChangedCallback(DateTime time);
typedef DateCancelledCallback();
typedef String? StringAtIndexCallBack(int index);

class DatePicker {
  ///
  /// Display date picker bottom sheet.
  ///
  static Future<DateTime?> showDatePicker(
    BuildContext context, {
    bool showTitleActions = true,
    DateTime? minTime,
    DateTime? maxTime,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
    locale = LocaleType.en,
    DateTime? currentTime,
    picker_theme.DatePickerTheme? theme,
  }) async {
    return await Navigator.push(
      context,
      _DatePickerRoute(
        showTitleActions: showTitleActions,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: DatePickerModel(
          currentTime: currentTime,
          maxTime: maxTime,
          minTime: minTime,
          locale: locale,
        ),
      ),
    );
  }

  ///
  /// Display time picker bottom sheet.
  ///
  static Future<DateTime?> showTimePicker(
    BuildContext context, {
    bool showTitleActions = true,
    bool showSecondsColumn = true,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
    locale = LocaleType.en,
    DateTime? currentTime,
    picker_theme.DatePickerTheme? theme,
  }) async {
    return await Navigator.push(
      context,
      _DatePickerRoute(
        showTitleActions: showTitleActions,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: TimePickerModel(
          currentTime: currentTime,
          locale: locale,
          showSecondsColumn: showSecondsColumn,
        ),
      ),
    );
  }

  ///
  /// Display time picker bottom sheet with AM/PM.
  ///
  static Future<DateTime?> showTime12hPicker(
    BuildContext context, {
    bool showTitleActions = true,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
    locale = LocaleType.en,
    DateTime? currentTime,
    picker_theme.DatePickerTheme? theme,
  }) async {
    return await Navigator.push(
      context,
      _DatePickerRoute(
        showTitleActions: showTitleActions,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: Time12hPickerModel(
          currentTime: currentTime,
          locale: locale,
        ),
      ),
    );
  }

  ///
  /// Display date&time picker bottom sheet.
  ///
  static Future<DateTime?> showDateTimePicker(
    BuildContext context, {
    bool showTitleActions = true,
    DateTime? minTime,
    DateTime? maxTime,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
    locale = LocaleType.en,
    DateTime? currentTime,
    picker_theme.DatePickerTheme? theme,
  }) async {
    return await Navigator.push(
      context,
      _DatePickerRoute(
        showTitleActions: showTitleActions,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: DateTimePickerModel(
          currentTime: currentTime,
          minTime: minTime,
          maxTime: maxTime,
          locale: locale,
        ),
      ),
    );
  }

  ///
  /// Display date picker bottom sheet witch custom picker model.
  ///
  static Future<DateTime?> showPicker(BuildContext context,
      {bool showTitleActions = true,
      DateChangedCallback? onChanged,
      DateChangedCallback? onConfirm,
      DateCancelledCallback? onCancel,
      locale = LocaleType.en,
      BasePickerModel? pickerModel,
      picker_theme.DatePickerTheme? theme,
      bool barrierDismissible = true}) async {
    return await showGeneralDialog(
        context: context,
        pageBuilder: (context, animation1, aniamtion2) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation1.drive(tween),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: GestureDetector(
                onTap: barrierDismissible
                    ? () {
                        Navigator.of(context).pop();
                      }
                    : null,
                child: Container(
                  color: Colors.transparent,
                  alignment: Alignment.bottomCenter,
                  child: InheritedTheme.captureAll(
                      context,
                      MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: _DatePickerComponent(
                          onChanged: onChanged,
                          locale: locale,
                          theme: theme ?? picker_theme.DatePickerTheme(),
                          pickerModel: pickerModel!,
                        ),
                      )),
                ),
              ),
            ),
          );
        });
  }
}

class _DatePickerRoute<T> extends PopupRoute<T> {
  _DatePickerRoute({
    this.showTitleActions,
    this.onChanged,
    this.onConfirm,
    this.onCancel,
    picker_theme.DatePickerTheme? theme,
    this.barrierLabel,
    this.locale,
    RouteSettings? settings,
    BasePickerModel? pickerModel,
  })  : this.pickerModel = pickerModel ?? DatePickerModel(),
        this.theme = theme ?? picker_theme.DatePickerTheme(),
        super(settings: settings);

  final bool? showTitleActions;
  final DateChangedCallback? onChanged;
  final DateChangedCallback? onConfirm;
  final DateCancelledCallback? onCancel;
  final LocaleType? locale;
  final picker_theme.DatePickerTheme theme;
  final BasePickerModel pickerModel;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get barrierDismissible => true;

  @override
  final String? barrierLabel;

  @override
  Color get barrierColor => Colors.black54;

  AnimationController? _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator!.overlay!);
    return _animationController!;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget bottomSheet = MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: _DatePickerComponent(
        onChanged: onChanged,
        locale: this.locale,
        route: this,
        pickerModel: pickerModel,
      ),
    );
    return InheritedTheme.captureAll(context, bottomSheet);
  }
}

class _DatePickerComponent extends StatefulWidget {
  _DatePickerComponent(
      {Key? key,
      this.route,
      required this.pickerModel,
      this.onChanged,
      this.locale,
      this.theme})
      : super(key: key);

  final DateChangedCallback? onChanged;

  final _DatePickerRoute? route;

  final LocaleType? locale;

  final BasePickerModel pickerModel;
  picker_theme.DatePickerTheme? theme;

  @override
  State<StatefulWidget> createState() {
    return _DatePickerState();
  }
}

class _DatePickerState extends State<_DatePickerComponent> {
  late FixedExtentScrollController leftScrollCtrl,
      middleScrollCtrl,
      rightScrollCtrl;

  @override
  void initState() {
    super.initState();
    refreshScrollOffset();
  }

  void refreshScrollOffset() {
//    print('refreshScrollOffset ${widget.pickerModel.currentRightIndex()}');
    leftScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentLeftIndex());
    middleScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentMiddleIndex());
    rightScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentRightIndex());
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.w), topRight: Radius.circular(15.w)),
      child: GestureDetector(
        onTap: () {
          print("object");
        },
        child: Material(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.w),
                topRight: Radius.circular(15.w)),
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.white),
              child: SafeArea(child: _renderPickerView(widget.theme!), top: false,),
            ),
          ),
        ),
      ),
    );
  }

  void _notifyDateChanged() {
    if (widget.onChanged != null) {
      widget.onChanged!(widget.pickerModel.finalTime()!);
    }
  }

  Widget _renderPickerView(picker_theme.DatePickerTheme theme) {
    Widget itemView = _renderItemView(theme);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _renderTitleActionsView(theme),
        itemView,
        GestureDetector(
          onTap: () {
            Navigator.pop(context, widget.pickerModel.finalTime());
            if (widget.route?.onConfirm != null) {
              widget.route?.onConfirm!(widget.pickerModel.finalTime()!);
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25.w),
            width: double.infinity,
            alignment: Alignment.center,
            height: 50.w,
            decoration: BoxDecoration(
                color: Color(0xff333333),
                borderRadius: BorderRadius.circular(10.w)),
            child: Text(
              widget.pickerModel.datePickerConfirmTitle() ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 18.sp),
            ),
          ),
        ),
      ],
    );
  }

  Widget _renderColumnView(
    ValueKey key,
    picker_theme.DatePickerTheme theme,
    StringAtIndexCallBack stringAtIndexCB,
    ScrollController scrollController,
    int layoutProportion,
    ValueChanged<int> selectedChangedWhenScrolling,
    ValueChanged<int> selectedChangedWhenScrollEnd,
  ) {
    return Expanded(
      flex: layoutProportion,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        height: 250.w,
        decoration: BoxDecoration(
          color: theme.backgroundColor,
        ),
        child: NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification.depth == 0 &&
                notification is ScrollEndNotification &&
                notification.metrics is FixedExtentMetrics) {
              final FixedExtentMetrics metrics =
                  notification.metrics as FixedExtentMetrics;
              final int currentItemIndex = metrics.itemIndex;
              selectedChangedWhenScrollEnd(currentItemIndex);
            }
            return false;
          },
          child: CupertinoPicker.builder(
            key: key,
            backgroundColor: theme.backgroundColor,
            scrollController: scrollController as FixedExtentScrollController,
            itemExtent: 60.w,
            selectionOverlay: SizedBox(),
            onSelectedItemChanged: (int index) {
              selectedChangedWhenScrolling(index);
            },
            useMagnifier: true,
            itemBuilder: (BuildContext context, int index) {
              final content = stringAtIndexCB(index);
              if (content == null) {
                return null;
              }
              return Container(
                height: 44,
                alignment: Alignment.center,
                child: Text(
                  content,
                  style: theme.itemStyle,
                  textAlign: TextAlign.start,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _renderItemView(picker_theme.DatePickerTheme theme) {
    return Stack(
      children: [
        Container(
          color: theme.backgroundColor,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: widget.pickerModel.layoutProportions()[1] > 0
                      ? _renderColumnView(
                          ValueKey(widget.pickerModel.currentLeftIndex()),
                          theme,
                          widget.pickerModel.middleStringAtIndex,
                          middleScrollCtrl,
                          widget.pickerModel.layoutProportions()[1], (index) {
                          widget.pickerModel.setMiddleIndex(index);
                        }, (index) {
                          setState(() {
                            refreshScrollOffset();
                            _notifyDateChanged();
                          });
                        })
                      : null,
                ),
                Container(
                  child: widget.pickerModel.layoutProportions()[2] > 0
                      ? _renderColumnView(
                          ValueKey(
                              widget.pickerModel.currentMiddleIndex() * 100 +
                                  widget.pickerModel.currentLeftIndex()),
                          theme,
                          widget.pickerModel.rightStringAtIndex,
                          rightScrollCtrl,
                          widget.pickerModel.layoutProportions()[2], (index) {
                          widget.pickerModel.setRightIndex(index);
                        }, (index) {
                          setState(() {
                            refreshScrollOffset();
                            _notifyDateChanged();
                          });
                        })
                      : null,
                ),
                Container(
                  child: widget.pickerModel.layoutProportions()[0] > 0
                      ? _renderColumnView(
                          ValueKey(widget.pickerModel.currentLeftIndex()),
                          theme,
                          widget.pickerModel.leftStringAtIndex,
                          leftScrollCtrl,
                          widget.pickerModel.layoutProportions()[0], (index) {
                          widget.pickerModel.setLeftIndex(index);
                        }, (index) {
                          setState(() {
                            refreshScrollOffset();
                            _notifyDateChanged();
                          });
                        })
                      : null,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          child: Center(
              child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 1, color: Color(0xff333333)),
                      bottom: BorderSide(width: 1, color: Color(0xff333333)))),
              height: 60.w,
            ),
          )),
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
        )
      ],
    );
  }

  Widget _renderCustomActionView(picker_theme.DatePickerTheme theme) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      decoration: BoxDecoration(
          color: theme.headerColor ?? theme.backgroundColor,
          border:
              Border(bottom: BorderSide(color: Color(0xff3B3D3F), width: 0.5))),
      child: Text(
        widget.pickerModel.actionTitle() ?? '',
        style: TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.w100),
      ),
    );
  }

  // Title View
  Widget _renderTitleActionsView(picker_theme.DatePickerTheme theme) {
    final done = _localeDone();
    final cancel = _localeCancel();

    return Container(
      height: 60.w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.w), topLeft: Radius.circular(15.w))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 60.w,
          ),
          Expanded(
              child: Center(
            child: Text(
              widget.pickerModel.datePickerTitle() ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Color(0xff333333), fontSize: 18.sp),
            ),
          )),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: 60.w,
              child: Icon(
                Icons.close,
                color: Colors.grey,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              if (widget.route?.onCancel != null) {
                widget.route?.onCancel!();
              }
            },
          ),
        ],
      ),
    );
  }

  String _localeDone() {
    return i18nObjInLocale(widget.locale)['done'] as String;
  }

  String _localeCancel() {
    return i18nObjInLocale(widget.locale)['cancel'] as String;
  }
}

class _BottomPickerLayout extends SingleChildLayoutDelegate {
  _BottomPickerLayout(
    this.progress,
    this.theme, {
    this.showTitleActions,
    this.bottomPadding = 0,
  });

  final double progress;
  final bool? showTitleActions;
  final picker_theme.DatePickerTheme theme;
  final double bottomPadding;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = theme.containerHeight;
    if (showTitleActions == true) {
      maxHeight += theme.titleHeight;
    }

    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: maxHeight + bottomPadding,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final height = size.height - childSize.height * progress;
    return Offset(0.0, height);
  }

  @override
  bool shouldRelayout(_BottomPickerLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
