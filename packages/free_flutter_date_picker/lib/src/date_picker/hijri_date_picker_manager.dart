import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:free_flutter_core/core.dart';
import 'date_picker.dart';
import 'date_picker_manager.dart';
import 'picker_helper.dart';

/// Options to customize the month view of the [SfHijriDatePicker].
///
/// Allows to customize the [firstDayOfWeek], [dayFormat], [viewHeaderHeight].
/// [viewHeaderStyle], [enableSwipeSelection], [blackoutDates], [specialDates]
/// and [weekendDays] in month view of date range picker.
///
/// ```dart
///
///Widget build(BuildContext context) {
///    return MaterialApp(
///      home: Scaffold(
///        body: SfHijriDatePicker(
///          view: HijriDatePickerView.month,
///          monthViewSettings: HijriDatePickerMonthViewSettings(
///              firstDayOfWeek: 1,
///              dayFormat: 'E',
///              viewHeaderHeight: 70,
///              viewHeaderStyle: HijriDatePickerViewHeaderStyle(
///                  backgroundColor: Colors.blue,
///                  textStyle:
///                      TextStyle(fontWeight: FontWeight.w400, fontSize: 15,
///                           Colors.black)),
///              enableSwipeSelection: false,
///              blackoutDates: <HijriDateTime>[
///                HijriDateTime.now().add(Duration(days: 4))
///              ],
///              specialDates: <HijriDateTime>[
///                HijriDateTime.now().add(Duration(days: 7)),
///                HijriDateTime.now().add(Duration(days: 8))
///              ],
///              weekendDays: <int>[
///                DateTime.monday,
///                DateTime.friday
///              ]),
///        ),
///      ),
///    );
///  }
///
/// ```
@immutable
class HijriDatePickerMonthViewSettings with Diagnosticable {
  /// Creates a date range picker month view settings for date range picker.
  ///
  /// The properties allows to customize the month view of
  /// [SfHijriDatePicker].
  const HijriDatePickerMonthViewSettings(
      {this.firstDayOfWeek = 7,
      this.dayFormat = 'EE',
      this.viewHeaderHeight = 30,
      this.viewHeaderStyle = const DatePickerViewHeaderStyle(),
      this.enableSwipeSelection = true,
      this.blackoutDates,
      this.specialDates,
      this.weekendDays = const <int>[6, 7]});

  /// Formats a text in the [SfHijriDatePicker] month view view header.
  ///
  /// Text format in the [SfHijriDatePicker] month view view header.
  ///
  /// Defaults to `EE`.
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          selectionMode: DatePickerSelectionMode.single,
  ///          monthViewSettings: HijriDatePickerMonthViewSettings(
  ///               dayFormat: 'EEE'),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final String dayFormat;

  /// Enables the swipe selection for [SfHijriDatePicker], which allows to
  /// select the range of dates by swiping on the dates.
  ///
  /// If it is [false] selecting a two different dates will form the range of
  /// dates by covering the dates between the selected dates.
  ///
  /// Defaults to `true`.
  ///
  /// _Note:_ It is only applicable when the [DatePickerSelectionMode]
  ///  set as [DatePickerSelectionMode.range] or
  /// [DatePickerSelectionMode.multiRange].
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          monthViewSettings:
  ///              HijriDatePickerMonthViewSettings(
  ///                   enableSwipeSelection: false),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final bool enableSwipeSelection;

  /// The first day of the week in the [SfHijriDatePicker] month view.
  ///
  /// Allows you to change the first day of the week in the month view,
  /// every month view will start from the day set to that property.
  ///
  /// Defaults to `7` which indicates `DateTime.sunday`.
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          monthViewSettings:
  ///              HijriDatePickerMonthViewSettings(firstDayOfWeek: 2),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final int firstDayOfWeek;

  /// Sets the style to customize [SfHijriDatePicker] month view view
  /// header.
  ///
  /// Allows to customize the [textStyle] and [backgroundColor] of the view
  /// header view in month view of [SfHijriDatePicker].
  ///
  /// See also: [DatePickerViewHeaderStyle].
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          selectionMode: DatePickerSelectionMode.single,
  ///          monthViewSettings: HijriDatePickerMonthViewSettings(
  ///              viewHeaderStyle: DatePickerViewHeaderStyle(
  ///                  backgroundColor: Colors.red,
  ///                  textStyle: TextStyle(
  ///                      fontWeight: FontWeight.w500,
  ///                      fontStyle: FontStyle.italic,
  ///                     fontSize: 20,
  ///                      color: Colors.white))),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final DatePickerViewHeaderStyle viewHeaderStyle;

  /// The height of the view header to the layout within this in month view of
  /// [SfHijriDatePicker].
  ///
  /// Defaults to `30`.
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          selectionMode: HDatePickerSelectionMode.range,
  ///          monthViewSettings:
  ///              HijriDatePickerMonthViewSettings(viewHeaderHeight: 50),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final double viewHeaderHeight;

  /// Disables the interactions for certain dates in the month view of
  /// [SfHijriDatePicker].
  ///
  /// Defaults to null.
  ///
  /// Use [HijriDatePickerMonthCellStyle.blackoutDateTextStyle] or
  /// [HijriDatePickerMonthCellStyle.blackoutDatesDecoration] property to
  /// customize the appearance of blackout dates in month view.
  ///
  /// See also:
  /// [HijriDatePickerMonthCellStyle.blackoutDateTextStyle]
  /// [HijriDatePickerMonthCellStyle.blackoutDatesDecoration].
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          monthViewSettings:
  ///              HijriDatePickerMonthViewSettings(
  ///              blackoutDates: <HijriDateTime>[
  ///               HijriDateTime.now().add(Duration(days: 2)),
  ///               HijriDateTime.now().add(Duration(days: 3)),
  ///               HijriDateTime.now().add(Duration(days: 6)),
  ///               HijriDateTime.now().add(Duration(days: 7))
  ///          ]),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final List<HijriDateTime>? blackoutDates;

  /// In the month view of [SfHijriDatePicker] highlights the unique dates
  /// with different style rather than the other dates style.
  ///
  /// Defaults to null.
  ///
  /// Use [HijriDatePickerMonthCellStyle.specialDatesTextStyle] or
  /// [HijriDatePickerMonthCellStyle.specialDatesDecoration] property to
  /// customize the appearance of blackout dates in month view.
  ///
  /// See also:
  /// [HijriDatePickerMonthCellStyle.specialDatesTextStyle]
  /// [HijriDatePickerMonthCellStyle.specialDatesDecoration].
  ///
  /// ```dart
  ///
  ///Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          monthViewSettings:
  ///              HijriDatePickerMonthViewSettings(
  ///              specialDates: <HijriDateTime>[
  ///               HijriDateTime.now().add(Duration(days: 2)),
  ///               HijriDateTime.now().add(Duration(days: 3)),
  ///               HijriDateTime.now().add(Duration(days: 6)),
  ///               HijriDateTime.now().add(Duration(days: 7))
  ///          ]),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final List<HijriDateTime>? specialDates;

  /// The weekends for month view in [SfHijriDatePicker].
  ///
  /// Defaults to `<int>[6,7]` represents `<int>[DateTime.saturday,
  ///                                                     DateTime.sunday]`.
  ///
  /// _Note:_ The [weekendDays] will not be highlighted until it's customize by
  /// using the [HijriDatePickerMonthCellStyle.weekendTextStyle] or
  /// [HijriDatePickerMonthCellStyle.weekendDatesDecoration] property.
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          monthViewSettings: HijriDatePickerMonthViewSettings(
  ///             weekendDays: <int>[DateTime.friday, DateTime.saturday]),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final List<int> weekendDays;

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final HijriDatePickerMonthViewSettings otherStyle = other;
    return otherStyle.dayFormat == dayFormat &&
        otherStyle.firstDayOfWeek == firstDayOfWeek &&
        otherStyle.viewHeaderStyle == viewHeaderStyle &&
        otherStyle.viewHeaderHeight == viewHeaderHeight &&
        otherStyle.blackoutDates == blackoutDates &&
        otherStyle.specialDates == specialDates &&
        otherStyle.weekendDays == weekendDays &&
        otherStyle.enableSwipeSelection == enableSwipeSelection;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableDiagnostics(blackoutDates)
        .toDiagnosticsNode(name: 'blackoutDates'));
    properties.add(IterableDiagnostics(specialDates)
        .toDiagnosticsNode(name: 'specialDates'));
    properties.add(IntProperty('firstDayOfWeek', firstDayOfWeek));
    properties.add(DoubleProperty('viewHeaderHeight', viewHeaderHeight));
    properties.add(StringProperty('dayFormat', dayFormat));
    properties.add(DiagnosticsProperty<bool>(
        'enableSwipeSelection', enableSwipeSelection));
    properties.add(viewHeaderStyle.toDiagnosticsNode(name: 'viewHeaderStyle'));
    properties.add(IterableProperty<int>('weekendDays', weekendDays));
  }

  @override
  int get hashCode {
    return hashValues(
        dayFormat,
        firstDayOfWeek,
        viewHeaderStyle,
        enableSwipeSelection,
        viewHeaderHeight,
        hashList(specialDates),
        hashList(blackoutDates),
        hashList(weekendDays));
  }
}

/// Options to customize the year and decade view of the
/// [SfHijriDatePicker].
///
/// Allows to customize the [textStyle], [todayTextStyle],
/// [disabledDatesTextStyle], [cellDecoration], [todayCellDecoration], and
/// [disabledDatesDecoration] in year and decade view of the
/// [SfHijriDatePicker].
///
/// ``` dart
///
/// Widget build(BuildContext context) {
///    return MaterialApp(
///      home: Scaffold(
///        body: SfHijriDatePicker(
///          view: HijriDatePickerView.decade,
///          enablePastDates: false,
///          yearCellStyle: HijriDatePickerYearCellStyle(
///            textStyle: TextStyle(
///                fontWeight: FontWeight.w400, fontSize: 15,
///                     color: Colors.black),
///            todayTextStyle: TextStyle(
///                fontStyle: FontStyle.italic,
///                fontSize: 15,
///                fontWeight: FontWeight.w500,
///                color: Colors.red),
///            disabledDatesDecoration: BoxDecoration(
///                color: const Color(0xFFDFDFDF).withOpacity(0.2),
///                border: Border.all(color: const Color(0xFFB6B6B6), width: 1),
///                shape: BoxShape.circle),
///          ),
///        ),
///      ),
///    );
///  }
///
/// ```
@immutable
class HijriDatePickerYearCellStyle with Diagnosticable {
  /// Creates a date range picker year cell style for date range picker.
  ///
  /// The properties allows to customize the year cells in year view of
  /// [SfHijriDatePicker].
  const HijriDatePickerYearCellStyle(
      {this.textStyle,
      this.todayTextStyle,
      this.disabledDatesTextStyle,
      this.cellDecoration,
      this.todayCellDecoration,
      this.disabledDatesDecoration});

  /// The text style for the text in the [SfHijriDatePicker] year and
  /// decade view cells.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// ``` dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.year,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          yearCellStyle: HijriDatePickerYearCellStyle(
  ///              textStyle: TextStyle(
  ///            fontSize: 14,
  ///            fontWeight: FontWeight.w400,
  ///            color: Colors.blue,
  ///          )),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final TextStyle? textStyle;

  /// The text style for the text in the today cell of [SfHijriDatePicker]
  /// year and decade view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.year,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          yearCellStyle: HijriDatePickerYearCellStyle(
  ///              todayTextStyle: TextStyle(
  ///                  fontSize: 14,
  ///                  fontWeight: FontWeight.w400,
  ///                  color: Colors.red,
  ///                  fontStyle: FontStyle.italic)),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final TextStyle? todayTextStyle;

  /// The text style for the text in the disabled dates cell of
  /// [SfHijriDatePicker] year and decade view.
  ///
  /// Here, disabled cells are the one which falls beyond the minimum and
  /// maximum date range.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.year,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          yearCellStyle: HijriDatePickerYearCellStyle(
  ///              disabledDatesTextStyle: TextStyle(
  ///                  fontSize: 12,
  ///                  fontWeight: FontWeight.w300,
  ///                  color: Colors.black)),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final TextStyle? disabledDatesTextStyle;

  /// The decoration for the disabled cells of [SfHijriDatePicker]
  /// year and decade view.
  ///
  /// Here, disabled cells are the one which falls beyond the minimum and
  /// maximum date range.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.decade,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          yearCellStyle: HijriDatePickerYearCellStyle(
  ///            disabledDatesDecoration: BoxDecoration(
  ///                color: Colors.black.withOpacity(0.4),
  ///                border: Border.all(color: const Color(0xFF2B732F),
  ///                     width: 1),
  ///                shape: BoxShape.rectangle),
  ///          ),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final Decoration? disabledDatesDecoration;

  /// The decoration for the cells of [SfHijriDatePicker] year and decade
  /// view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.decade,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          yearCellStyle: HijriDatePickerYearCellStyle(
  ///            cellDecoration: BoxDecoration(
  ///                color: Colors.green,
  ///                border: Border.all(color: const Color(0xFF2B732F),
  ///                     width: 1),
  ///                shape: BoxShape.circle),
  ///          ),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final Decoration? cellDecoration;

  /// The decoration for the today cell of [SfHijriDatePicker] year and
  /// decade view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.decade,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          yearCellStyle: HijriDatePickerYearCellStyle(
  ///            todayCellDecoration: BoxDecoration(
  ///                color: Colors.red,
  ///                border: Border.all(color: const Color(0xFF2B732F),
  ///                     width: 1),
  ///                shape: BoxShape.circle),
  ///          ),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final Decoration? todayCellDecoration;

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final HijriDatePickerYearCellStyle otherStyle = other;
    return otherStyle.textStyle == textStyle &&
        otherStyle.todayTextStyle == todayTextStyle &&
        otherStyle.disabledDatesDecoration == disabledDatesDecoration &&
        otherStyle.cellDecoration == cellDecoration &&
        otherStyle.todayCellDecoration == todayCellDecoration &&
        otherStyle.disabledDatesTextStyle == disabledDatesTextStyle;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextStyle>('textStyle', textStyle));
    properties
        .add(DiagnosticsProperty<TextStyle>('todayTextStyle', todayTextStyle));
    properties.add(DiagnosticsProperty<TextStyle>(
        'disabledDatesTextStyle', disabledDatesTextStyle));
    properties.add(DiagnosticsProperty<Decoration>(
        'disabledDatesDecoration', disabledDatesDecoration));
    properties
        .add(DiagnosticsProperty<Decoration>('cellDecoration', cellDecoration));
    properties.add(DiagnosticsProperty<Decoration>(
        'todayCellDecoration', todayCellDecoration));
  }

  @override
  int get hashCode {
    return hashValues(textStyle, todayTextStyle, disabledDatesTextStyle,
        disabledDatesDecoration, cellDecoration, todayCellDecoration);
  }
}

/// Options to customize the month cells of the [SfHijriDatePicker].
///
///
/// Allows to customize the [textStyle], [todayTextStyle],
/// [disabledDatesTextStyle], [blackoutDateTextStyle], [weekendTextStyle],
/// [specialDatesTextStyle], [specialDatesDecoration],
/// [blackoutDatesDecoration], [cellDecoration], [todayCellDecoration],
/// [disabledDatesDecoration],and [weekendDatesDecoration]  in the month cells
/// of the date range picker.
///
/// ``` dart
///
/// Widget build(BuildContext context) {
///    return MaterialApp(
///      home: Scaffold(
///        body: SfHijriDatePicker(
///          view: HijriDatePickerView.month,
///          enablePastDates: false,
///          monthCellStyle: HijriDatePickerMonthCellStyle(
///            textStyle: TextStyle(
///                fontWeight: FontWeight.w400, fontSize: 15,
///                     color: Colors.black),
///            todayTextStyle: TextStyle(
///                fontStyle: FontStyle.italic,
///                fontSize: 15,
///                fontWeight: FontWeight.w500,
///                color: Colors.red),
///            disabledDatesDecoration: BoxDecoration(
///                color: const Color(0xFFDFDFDF).withOpacity(0.2),
///                border: Border.all(color: const Color(0xFFB6B6B6), width: 1),
///                shape: BoxShape.circle),
///          ),
///        ),
///      ),
///    );
///  }
///
/// ```
@immutable
class HijriDatePickerMonthCellStyle with Diagnosticable {
  /// Creates a date range picker month cell style for date range picker.
  ///
  /// The properties allows to customize the month cells in month view of
  /// [SfHijriDatePicker].
  const HijriDatePickerMonthCellStyle(
      {this.textStyle,
      this.todayTextStyle,
      this.disabledDatesTextStyle,
      this.blackoutDateTextStyle,
      this.weekendTextStyle,
      this.specialDatesTextStyle,
      this.specialDatesDecoration,
      this.blackoutDatesDecoration,
      this.cellDecoration,
      this.todayCellDecoration,
      this.disabledDatesDecoration,
      this.weekendDatesDecoration});

  /// The text style for the text in the [SfHijriDatePicker] month cells.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// ``` dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///         view: HijriDatePickerView.month,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          monthCellStyle: HijriDatePickerMonthCellStyle(
  ///            textStyle: TextStyle(
  ///              fontStyle: FontStyle.normal,
  ///              fontWeight: FontWeight.w400,
  ///              fontSize: 12,
  ///              color: Colors.blue
  ///            )
  ///          ),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final TextStyle? textStyle;

  /// The text style for the text in the today cell of [SfHijriDatePicker]
  /// month view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// ``` dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          monthCellStyle: HijriDatePickerMonthCellStyle(
  ///            todayTextStyle: TextStyle(
  ///              fontStyle: FontStyle.italic,
  ///              fontWeight: FontWeight.w400,
  ///             fontSize: 12,
  ///              color: Colors.red
  ///            )
  ///          ),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final TextStyle? todayTextStyle;

  /// The text style for the text in the disabled dates cell of
  /// [SfHijriDatePicker] month view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// See also:
  /// [SfHijriDatePicker.minDate].
  /// [SfHijriDatePicker.maxDate].
  /// [SfHijriDatePicker.enablePastDates].
  ///
  /// ``` dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          monthCellStyle: HijriDatePickerMonthCellStyle(
  ///              disabledDatesTextStyle: TextStyle(
  ///                  fontStyle: FontStyle.normal,
  ///                  fontWeight: FontWeight.w300,
  ///                  fontSize: 10,
  ///                  color: Colors.grey)),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final TextStyle? disabledDatesTextStyle;

  /// The text style for the text in the blackout dates cell of
  /// [SfHijriDatePicker] month view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// See also: [HijriDatePickerMonthViewSettings.blackoutDates].
  ///
  /// ``` dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///          monthCellStyle: HijriDatePickerMonthCellStyle(
  ///              blackoutDateTextStyle: TextStyle(
  ///                  fontStyle: FontStyle.italic,
  ///                  fontWeight: FontWeight.w500,
  ///                  fontSize: 18,
  ///                  color: Colors.black54)),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final TextStyle? blackoutDateTextStyle;

  /// The text style for the text in the weekend dates cell of
  /// [SfHijriDatePicker] month view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// See also: [HijriDatePickerMonthViewSettings.weekendDays].
  ///
  /// ``` dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///          monthCellStyle: HijriDatePickerMonthCellStyle(
  ///              weekendTextStyle: TextStyle(
  ///                  fontStyle: FontStyle.italic,
  ///                  fontWeight: FontWeight.w500,
  ///                  fontSize: 12,
  ///                  color: Colors.green)),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final TextStyle? weekendTextStyle;

  /// The text style for the text in the special dates cell of
  /// [SfHijriDatePicker] month view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// See also: [HijriDatePickerMonthViewSettings.specialDates].
  ///
  /// ``` dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///          monthCellStyle: HijriDatePickerMonthCellStyle(
  ///              specialDatesTextStyle: TextStyle(
  ///                  fontWeight: FontWeight.bold,
  ///                  fontSize: 12,
  ///                  color: Colors.orange)),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final TextStyle? specialDatesTextStyle;

  /// The decoration for the special date cells of [SfHijriDatePicker]
  /// month view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///          monthCellStyle: HijriDatePickerMonthCellStyle(
  ///            specialDatesDecoration: BoxDecoration(
  ///                color: Colors.blueGrey,
  ///                border: Border.all(color: const Color(0xFF2B732F),
  ///                     width: 1),
  ///                shape: BoxShape.circle),
  ///          ),
  ///        ),
  ///     ),
  ///    );
  ///  }
  ///
  /// ```
  final Decoration? specialDatesDecoration;

  /// The decoration for the weekend date cells of [SfHijriDatePicker]
  /// month view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///          monthCellStyle: HijriDatePickerMonthCellStyle(
  ///            weekendDatesDecoration: BoxDecoration(
  ///                color: Colors.green,
  ///                border: Border.all(color: const Color(0xFF2B732F),
  ///                     width: 1),
  ///                shape: BoxShape.circle),
  ///          ),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final Decoration? weekendDatesDecoration;

  /// The decoration for the blackout date cells of [SfHijriDatePicker]
  /// month view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///          monthCellStyle: HijriDatePickerMonthCellStyle(
  ///            blackoutDatesDecoration: BoxDecoration(
  ///                color: Colors.black,
  ///                border: Border.all(color: const Color(0xFF2B732F),
  ///                     width: 1),
  ///                shape: BoxShape.circle),
  ///          ),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final Decoration? blackoutDatesDecoration;

  /// The decoration for the disabled date cells of [SfHijriDatePicker]
  /// month view.
  ///
  /// The disabled dates are the one which falls beyond the minimum and maximum
  /// date range.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// See also:
  /// [SfHijriDatePicker.minDate].
  /// [SfHijriDatePicker.maxDate].
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///          monthCellStyle: HijriDatePickerMonthCellStyle(
  ///            disabledDatesDecoration: BoxDecoration(
  ///                color: Colors.black.withOpacity(0.4),
  ///                border: Border.all(color: const Color(0xFF2B732F),
  ///                     width: 1),
  ///                shape: BoxShape.rectangle),
  ///          ),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final Decoration? disabledDatesDecoration;

  /// The decoration for the month cells of [SfHijriDatePicker] month view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///          monthCellStyle: HijriDatePickerMonthCellStyle(
  ///            cellDecoration: BoxDecoration(
  ///                color: Colors.blueGrey.withOpacity(0.4),
  ///                border: Border.all(color: const Color(0xFF2B732F),
  ///                     width: 1),
  ///               shape: BoxShape.circle),
  ///          ),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final Decoration? cellDecoration;

  /// The decoration for the today text cell of [SfHijriDatePicker] month
  /// view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///          monthCellStyle: HijriDatePickerMonthCellStyle(
  ///            todayCellDecoration: BoxDecoration(
  ///                color: Colors.red,
  ///                border: Border.all(color: const Color(0xFF2B732F),
  ///                     width: 1),
  ///                shape: BoxShape.circle),
  ///          ),
  ///        ),
  ///      ),
  ///   );
  ///  }
  ///
  /// ```
  final Decoration? todayCellDecoration;

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final HijriDatePickerMonthCellStyle otherStyle = other;
    return otherStyle.textStyle == textStyle &&
        otherStyle.todayTextStyle == todayTextStyle &&
        otherStyle.blackoutDateTextStyle == blackoutDateTextStyle &&
        otherStyle.weekendTextStyle == weekendTextStyle &&
        otherStyle.specialDatesTextStyle == specialDatesTextStyle &&
        otherStyle.specialDatesDecoration == specialDatesDecoration &&
        otherStyle.weekendDatesDecoration == weekendDatesDecoration &&
        otherStyle.blackoutDatesDecoration == blackoutDatesDecoration &&
        otherStyle.disabledDatesDecoration == disabledDatesDecoration &&
        otherStyle.cellDecoration == cellDecoration &&
        otherStyle.todayCellDecoration == todayCellDecoration &&
        otherStyle.disabledDatesTextStyle == disabledDatesTextStyle;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextStyle>('textStyle', textStyle));
    properties
        .add(DiagnosticsProperty<TextStyle>('todayTextStyle', todayTextStyle));
    properties.add(DiagnosticsProperty<TextStyle>(
        'blackoutDateTextStyle', blackoutDateTextStyle));
    properties.add(
        DiagnosticsProperty<TextStyle>('weekendTextStyle', weekendTextStyle));
    properties.add(DiagnosticsProperty<TextStyle>(
        'specialDatesTextStyle', specialDatesTextStyle));
    properties.add(DiagnosticsProperty<TextStyle>(
        'disabledDatesTextStyle', disabledDatesTextStyle));
    properties.add(DiagnosticsProperty<Decoration>(
        'disabledDatesDecoration', disabledDatesDecoration));
    properties
        .add(DiagnosticsProperty<Decoration>('cellDecoration', cellDecoration));
    properties.add(DiagnosticsProperty<Decoration>(
        'todayCellDecoration', todayCellDecoration));
    properties.add(DiagnosticsProperty<Decoration>(
        'blackoutDatesDecoration', blackoutDatesDecoration));
    properties.add(DiagnosticsProperty<Decoration>(
        'weekendDatesDecoration', weekendDatesDecoration));
    properties.add(DiagnosticsProperty<Decoration>(
        'specialDatesDecoration', specialDatesDecoration));
  }

  @override
  int get hashCode {
    return hashList(<dynamic>[
      textStyle,
      todayTextStyle,
      disabledDatesTextStyle,
      specialDatesDecoration,
      weekendDatesDecoration,
      blackoutDatesDecoration,
      disabledDatesDecoration,
      cellDecoration,
      todayCellDecoration,
      specialDatesTextStyle,
      blackoutDateTextStyle,
      weekendTextStyle,
    ]);
  }
}

/// An object that used for programmatic date navigation, date and range
/// selection and view switching in [SfHijriDatePicker].
///
/// A [HijriDatePickerController] served for several purposes. It can be
/// used to selected dates and ranges programmatically on
/// [SfHijriDatePicker] by using the [controller.selectedDate],
/// [controller.selectedDates], [controller.selectedRange],
/// [controller.selectedRanges]. It can be used to change the
/// [SfHijriDatePicker] view by using the [controller.view] property.
/// It can be used to navigate to specific date by using the
/// [controller.displayDate] property.
///
/// ## Listening to property changes:
/// The [HijriDatePickerController] is a listenable. It notifies it's
/// listeners whenever any of attached [SfHijriDatePicker]`s selected date,
/// display date and view changed (i.e: selecting a different date, swiping to
/// next/previous view and navigates to different view] in in
/// [SfHijriDatePicker].
///
/// ## Navigates to different view:
/// The [SfHijriDatePicker] visible view can be changed by using the
/// [Controller.view] property, the property allow to change the view of
/// [SfHijriDatePicker] programmatically on initial load and in rum time.
///
/// ## Programmatic selection:
/// In [SfHijriDatePicker] selecting dates programmatically can be achieved
///  by using the [controller.selectedDate], [controller.selectedDates],
/// [controller.selectedRange], [controller.selectedRanges] which allows to
/// select the dates or ranges programmatically on [SfHijriDatePicker] on
/// initial load and in run time.
///
/// See also: [HijriDatePickerSelectionMode]
///
/// Defaults to null.
///
/// This example demonstrates how to use the [HijriDatePickerController] for
/// [SfHijriDatePicker].
///
/// ``` dart
///
///class MyApp extends StatefulWidget {
///  @override
///  MyAppState createState() => MyAppState();
///}
///
///class MyAppState extends State<MyApp> {
///  HijriDatePickerController _pickerController;
///
///  @override
///  void initState() {
///    _pickerController = HijriDatePickerController();
///    _pickerController.selectedDates = <HijriDateTime>[
///      HijriDateTime.now().add(Duration(days: 2)),
///      HijriDateTime.now().add(Duration(days: 4)),
///      HijriDateTime.now().add(Duration(days: 7)),
///      HijriDateTime.now().add(Duration(days: 11))
///    ];
///    _pickerController.displayDate = HijriDateTime.now();
///    _pickerController.addPropertyChangedListener(handlePropertyChange);
///    super.initState();
///  }
///
///  void handlePropertyChange(String propertyName) {
///    if (propertyName == 'selectedDates') {
///      final List<HijriDateTime> selectedDates =
///                                 _pickerController.selectedDates;
///    } else if (propertyName == 'displayDate') {
///      final HijriDateTime displayDate = _pickerController.displayDate;
///    }
///  }
///
///  @override
///  Widget build(BuildContext context) {
///    return MaterialApp(
///      home: Scaffold(
///        body: SfHijriDatePicker(
///          view: HijriDatePickerView.month,
///          controller: _pickerController,
///          selectionMode: HijriDatePickerSelectionMode.multiple,
///        ),
///      ),
///    );
///  }
///}
///
/// ```
class HijriDatePickerController extends DatePickerValueChangeNotifier {
  HijriDateTime? _selectedDate;
  List<HijriDateTime>? _selectedDates;
  HijriDateRange? _selectedRange;
  List<HijriDateRange>? _selectedRanges;
  HijriDateTime? _displayDate;
  HijriDatePickerView? _view;

  /// The selected date in the [SfHijriDatePicker].
  ///
  /// It is only applicable when the [selectionMode] set as
  /// [DatePickerSelectionMode.single] for other selection modes this
  /// property will return as null.
  HijriDateTime? get selectedDate => _selectedDate;

  /// Selects the given date programmatically in the [SfHijriDatePicker] by
  /// checking that the date falls in between the minimum and maximum date
  /// range.
  ///
  /// _Note:_ If any date selected previously, will be removed and the selection
  ///  will be drawn to the date given in this property.
  ///
  /// If it is not [null] the widget will render the date selection for the date
  /// set to this property, even the
  /// [SfHijriDatePicker.initialSelectedDate] is not null.
  ///
  /// It is only applicable when the [DatePickerSelectionMode] set as
  /// [DatePickerSelectionMode.single].
  ///
  /// ``` dart
  ///
  /// class MyAppState extends State<MyApp> {
  ///  DatePickerController _pickerController;
  ///
  ///  @override
  ///  void initState() {
  ///    _pickerController = HijriDatePickerController();
  ///    _pickerController.selectedDate = HijriDateTime.now().add((Duration(
  ///                                days: 4)));
  ///    super.initState();
  ///  }
  ///
  ///  @override
  ///  Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          selectionMode: HijriDatePickerSelectionMode.single,
  ///          showNavigationArrow: true,
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///}
  ///
  /// ```
  set selectedDate(HijriDateTime? date) {
    if (date == null) return;

    if (_selectedDate != null) {
      final bool? isSameDate = _selectedDate?.isSameDate(date);
      if (isSameDate == null || isSameDate) return;
    }

    _selectedDate = date;
    notifyPropertyChangedListeners('selectedDate');
  }

  /// The list of dates selected in the [SfHijriDatePicker].
  ///
  /// It is only applicable when the [selectionMode] set as
  /// [DatePickerSelectionMode.multiple] for other selection modes
  /// this property will return as null.
  List<HijriDateTime>? get selectedDates => _selectedDates;

  /// Selects the given dates programmatically in the [SfHijriDatePicker]
  /// by checking that the dates falls in between the minimum and maximum date
  /// range.
  ///
  /// _Note:_ If any list of dates selected previously, will be removed and the
  /// selection will be drawn to the dates set to this property.
  ///
  /// If it is not [null] the widget will render the date selection for the
  /// dates set to this property, even the
  /// [SfHijriDatePicker.initialSelectedDates] is not null.
  ///
  /// It is only applicable when the [selectionMode] set as
  /// [DatePickerSelectionMode.multiple].
  ///
  /// ``` dart
  ///
  /// class MyAppState extends State<MyApp> {
  ///  DatePickerController _pickerController;
  ///
  ///  @override
  ///  void initState() {
  ///    _pickerController = HijriDatePickerController();
  ///    _pickerController.selectedDates = <HijriDateTime>[
  ///      HijriDateTime.now().add((Duration(days: 4))),
  ///      HijriDateTime.now().add((Duration(days: 7))),
  ///      HijriDateTime.now().add((Duration(days: 8)))
  ///    ];
  ///    super.initState();
  ///  }
  ///
  ///  @override
  ///  Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          selectionMode: DatePickerSelectionMode.multiple,
  ///          showNavigationArrow: true,
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///}
  ///
  /// ```
  set selectedDates(List<HijriDateTime>? dates) {
    if (DatePickerHelper.isDateCollectionEquals(_selectedDates, dates)) {
      return;
    }

    _selectedDates = DatePickerHelper.cloneList(dates)!.cast<HijriDateTime>();
    notifyPropertyChangedListeners('selectedDates');
  }

  /// selected date range in the [SfHijriDatePicker].
  ///
  /// It is only applicable when the [selectionMode] set as
  /// [DatePickerSelectionMode.range] for other selection modes this
  /// property will return as null.
  HijriDateRange? get selectedRange => _selectedRange;

  /// Selects the given date range programmatically in the
  /// [SfHijriDatePicker] by checking that the range of dates falls in
  /// between the minimum and maximum date range.
  ///
  /// _Note:_ If any date range selected previously, will be removed and the
  /// selection will be drawn to the range of dates set to this property.
  ///
  /// If it is not [null] the widget will render the date selection for the
  /// range set to this property, even the
  /// [SfHijriDatePicker.initialSelectedRange] is not null.
  ///
  /// It is only applicable when the [selectionMode] set as
  /// [HijriDatePickerSelectionMode.range].
  ///
  /// ``` dart
  ///
  /// class MyAppState extends State<MyApp> {
  ///  DatePickerController _pickerController;
  ///
  ///  @override
  ///  void initState() {
  ///    _pickerController = HijriDatePickerController();
  ///    _pickerController.selectedRange = HijriPickerDateRange(
  ///        HijriDateTime.now().add(Duration(days: 4)),
  ///        HijriDateTime.now().add(Duration(days: 5)));
  ///    super.initState();
  ///  }
  ///
  ///  @override
  ///  Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///}
  ///
  /// ```
  set selectedRange(HijriDateRange? range) {
    if (DatePickerHelper.isRangeEquals(_selectedRange, range)) {
      return;
    }

    _selectedRange = range;
    notifyPropertyChangedListeners('selectedRange');
  }

  /// List of selected ranges in the [SfHijriDatePicker].
  ///
  /// It is only applicable when the [selectionMode] set as
  /// [DatePickerSelectionMode.multiRange] for other selection modes
  /// this property will return as null.
  List<HijriDateRange>? get selectedRanges => _selectedRanges;

  /// Selects the given date ranges programmatically in the
  /// [SfHijriDatePicker] by checking that the ranges of dates falls in
  /// between the minimum and maximum date range.
  ///
  /// If it is not [null] the widget will render the date selection for the
  /// ranges set to this property, even the
  /// [SfHijriDatePicker.initialSelectedRanges] is not null.
  ///
  /// _Note:_ If any date ranges selected previously, will be removed and the
  /// selection will be drawn to the ranges of dates set to this property.
  ///
  /// It is only applicable when the [selectionMode] set as
  /// [DatePickerSelectionMode.multiRange].
  ///
  /// ``` dart
  ///
  /// class MyAppState extends State<MyApp> {
  ///  HijriDatePickerController _pickerController;
  ///
  ///  @override
  ///  void initState() {
  ///    _pickerController = HijriDatePickerController();
  ///    _pickerController.selectedRanges = <HijriPickerDateRange>[
  ///      PickerDateRange(HijriDateTime.now().subtract(Duration(days: 4)),
  ///          HijriDateTime.now().add(Duration(days: 4))),
  ///      PickerDateRange(HijriDateTime.now().add(Duration(days: 11)),
  ///          HijriDateTime.now().add(Duration(days: 16)))
  ///    ];
  ///    super.initState();
  ///  }
  ///
  ///  @override
  ///  Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///}
  ///
  /// ```
  set selectedRanges(List<HijriDateRange>? ranges) {
    if (DatePickerHelper.isDateRangesEquals(_selectedRanges, ranges)) {
      return;
    }

    _selectedRanges =
        DatePickerHelper.cloneList(ranges)!.cast<HijriDateRange>();
    notifyPropertyChangedListeners('selectedRanges');
  }

  /// The first date of the current visible view month, when the
  /// [HijriDatePickerMonthViewSettings.numberOfWeeksInView] set with
  /// default value 6.
  ///
  /// If the [HijriDatePickerMonthViewSettings.numberOfWeeksInView]
  /// property set with value other then 6, this will return the first visible
  /// date of the current month.
  HijriDateTime? get displayDate => _displayDate;

  /// Navigates to the given date programmatically without any animation in the
  /// [SfHijriDatePicker] by checking that the date falls in between the
  /// [SfHijriDatePicker.minDate] and [SfHijriDatePicker.maxDate]
  /// date range.
  ///
  /// If the date falls beyond the [SfHijriDatePicker.minDate] and
  /// [SfHijriDatePicker.maxDate] the widget will move the widgets min or
  /// max date.
  ///
  ///
  /// ``` dart
  ///
  /// class MyAppState extends State<MyApp> {
  ///  HijriDatePickerController _pickerController;
  ///
  ///  @override
  ///  void initState() {
  ///    _pickerController = HijriDatePickerController();
  ///    _pickerController.displayDate = HijriDateTime(2022, 02, 05);
  ///    super.initState();
  ///  }
  ///
  ///  @override
  ///  Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          selectionMode: DatePickerSelectionMode.single,
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///}
  ///
  /// ```
  set displayDate(HijriDateTime? date) {
    if (date == null) return;

    if (_displayDate != null) {
      final bool? isSameDate = _displayDate?.isSameDate(date);
      if (isSameDate == null || isSameDate) return;
    }

    _displayDate = date;
    notifyPropertyChangedListeners('displayDate');
  }

  /// The current visible [HijriDatePickerView] of
  /// [SfHijriDatePicker].
  HijriDatePickerView? get view => _view;

  /// Set the [HijriDatePickerView] for the [SfHijriDatePicker].
  ///
  ///
  /// The [SfHijriDatePicker] will display the view sets to this property.
  ///
  /// ```dart
  ///
  /// class MyAppState extends State<MyApp> {
  ///  HijriDatePickerController _pickerController;
  ///
  ///  @override
  ///  void initState() {
  ///    _pickerController = HijriDatePickerController();
  ///    _pickerController.view = HijriDatePickerView.year;
  ///    super.initState();
  ///  }
  ///
  ///  @override
  ///  Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          selectionMode: DatePickerSelectionMode.single,
  ///       ),
  ///      ),
  ///    );
  ///  }
  ///}
  ///
  /// ```
  set view(HijriDatePickerView? value) {
    if (_view == value) {
      return;
    }

    _view = value;
    notifyPropertyChangedListeners('view');
  }

  /// Moves to the next view programmatically with animation by checking that
  /// the next view dates falls between the minimum and maximum date range.
  ///
  /// _Note:_ If the current view has the maximum date range, it will not move
  /// to the next view.
  ///
  /// ```dart
  ///
  /// class MyApp extends StatefulWidget {
  ///  @override
  ///  MyAppState createState() => MyAppState();
  ///}
  ///
  ///class MyAppState extends State<MyApp> {
  ///  HijriDatePickerController _pickerController;
  ///
  ///  @override
  ///  void initState() {
  ///    _pickerController = HijriDatePickerController();
  ///    super.initState();
  ///  }
  ///
  ///  @override
  ///  Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        appBar: AppBar(
  ///          actions: <Widget>[
  ///            IconButton(
  ///              icon: Icon(Icons.arrow_forward),
  ///              onPressed: () {
  ///                _pickerController.forward();
  ///              },
  ///            )
  ///          ],
  ///          title: Text('Date Range Picker Demo'),
  ///          leading: IconButton(
  ///            icon: Icon(Icons.arrow_back),
  ///            onPressed: () {
  ///              _pickerController.backward();
  ///            },
  ///          ),
  ///        ),
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          selectionMode: DatePickerSelectionMode.single,
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///}
  ///
  /// ```
  VoidCallback? forward;

  /// Moves to the previous view programmatically with animation by checking
  /// that the previous view dates falls between the minimum and maximum date
  /// range.
  ///
  /// _Note:_ If the current view has the minimum date range, it will not move
  /// to the previous view.
  ///
  /// ```dart
  ///
  /// class MyApp extends StatefulWidget {
  ///  @override
  ///  MyAppState createState() => MyAppState();
  ///}
  ///
  ///class MyAppState extends State<MyApp> {
  ///  HijriDatePickerController _pickerController;
  ///
  ///  @override
  ///  void initState() {
  ///    _pickerController = HijriDatePickerController();
  ///    super.initState();
  ///  }
  ///
  ///  @override
  ///  Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        appBar: AppBar(
  ///          actions: <Widget>[
  ///            IconButton(
  ///              icon: Icon(Icons.arrow_forward),
  ///              onPressed: () {
  ///                _pickerController.forward();
  ///              },
  ///            )
  ///          ],
  ///          title: Text('Date Range Picker Demo'),
  ///          leading: IconButton(
  ///            icon: Icon(Icons.arrow_back),
  ///            onPressed: () {
  ///              _pickerController.backward();
  ///            },
  ///          ),
  ///        ),
  ///        body: SfHijriDatePicker(
  ///          controller: _pickerController,
  ///          view: HijriDatePickerView.month,
  ///          selectionMode: DatePickerSelectionMode.single,
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///}
  ///
  /// ```
  VoidCallback? backward;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<HijriDateTime>('displayDate', displayDate));
    properties
        .add(DiagnosticsProperty<HijriDateTime>('selectedDate', selectedDate));
    properties.add(IterableDiagnostics(selectedDates)
        .toDiagnosticsNode(name: 'selectedDates'));
    properties.add(
        DiagnosticsProperty<HijriDateRange>('selectedRange', selectedRange));
    properties.add(IterableDiagnostics(selectedRanges)
        .toDiagnosticsNode(name: 'selectedRanges'));
    properties.add(EnumProperty<HijriDatePickerView>('view', view));
  }
}

/// Available views for [SfHijriDatePicker].
enum HijriDatePickerView {
  /// - HijriDatePickerView.month, Displays the month view.
  month,

  /// - HijriDatePickerView.year, Displays the year view.
  year,

  /// - HijriDatePickerView.decade, Displays the decade view.
  decade,
}

/// The dates that visible on the view changes in [SfHIjriDatePicker].
///
/// Details for [HijriDatePickerViewChangeCallback], such as
/// [visibleDateRange] and [view].
@immutable
class HijriDatePickerViewChangeArgs {
  /// Creates details for [DatePickerViewChangeCallback].
  const HijriDatePickerViewChangeArgs(this.visibleDateRange, this.view);

  /// The date range of the currently visible view dates.
  ///
  /// See also: [HijriDateRange].
  final HijriDateRange visibleDateRange;

  /// The currently visible [HijriDatePickerView] in the
  /// [SfHijriDatePicker].
  ///
  /// See also: [HijriDatePickerView].
  final HijriDatePickerView view;
}

/// Defines a range of dates, covers the dates in between the given [startDate]
/// and [endDate] as a range.
@immutable
class HijriDateRange with Diagnosticable {
  /// Creates a picker date range with the given start and end date.
  const HijriDateRange(this.startDate, this.endDate);

  /// The start date of the range.
  final HijriDateTime? startDate;

  /// The end date of the range.
  final HijriDateTime? endDate;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<HijriDateTime>('startDate', startDate));
    properties.add(DiagnosticsProperty<HijriDateTime>('endDate', endDate));
  }
}

/// Signature for a function that creates a widget based on date range picker
/// cell details.
typedef HijriDatePickerCellBuilder = Widget Function(
    BuildContext context, HijriDatePickerCellDetails cellDetails);

/// Contains the details that needed on calendar cell builder.
class HijriDatePickerCellDetails {
  /// Constructor to store the details that needed on calendar cell builder.
  HijriDatePickerCellDetails(
      {required this.date, required this.bounds, required this.visibleDates});

  /// Date value associated with the picker cell in month, year, decade and
  /// century views.
  final HijriDateTime date;

  /// Position and size of the widget.
  final Rect bounds;

  /// Visible dates value associated with the current picker month, year,
  /// decade and century views. It is used to get the cell, leading and
  /// trailing dates details.
  final List<HijriDateTime> visibleDates;
}
