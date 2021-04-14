import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:free_flutter_core/core.dart';
import 'picker_helper.dart';

/// Sets the style for customizing the [DatePicker] header view.
///
/// Allows to customize the [textStyle], [textAlign] and [backgroundColor] of
/// the header view in [DatePicker].
///
/// ``` dart
/// Widget build(BuildContext context) {
///    return MaterialApp(
///      home: Scaffold(
///        body: DatePicker(
///          view: DatePickerViewType.month,
///          headerStyle: DatePickerHeaderStyle(
///            textAlign: TextAlign.left,
///            textStyle: TextStyle(
///                color: Colors.blue, fontSize: 18,
///                     fontWeight: FontWeight.w400),
///            backgroundColor: Colors.grey,
///          ),
///        ),
///      ),
///    );
///  }
///
/// ```
@immutable
class DatePickerHeaderStyle with Diagnosticable {
  /// Creates a header style for date range picker.
  const DatePickerHeaderStyle(
      {this.textAlign = TextAlign.left, this.backgroundColor, this.textStyle});

  /// The text style for the text in the [DatePicker] header view.
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
  ///        body: DatePicker(
  ///            controller: _pickerController,
  ///            view: DatePickerViewType.month,
  ///            selectionMode: DatePickerSelectionMode.single,
  ///            headerStyle: DatePickerHeaderStyle(
  ///              textStyle: TextStyle(
  ///                  color: Colors.blue,
  ///                  fontSize: 18,
  ///                  fontWeight: FontWeight.w400),
  ///            )),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final TextStyle? textStyle;

  /// How the text should  be aligned horizontally in [DatePicker] header
  /// view.
  ///
  /// Defaults to `TextAlign.left`.
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///            controller: _pickerController,
  ///            view: DatePickerViewType.month,
  ///            selectionMode: DatePickerSelectionMode.single,
  ///            headerStyle: DatePickerHeaderStyle(
  ///              textAlign: TextAlign.right,
  ///            )),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final TextAlign textAlign;

  /// The color which fills the [DatePicker] header view background.
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
  ///        body: DatePicker(
  ///            controller: _pickerController,
  ///            view: DatePickerViewType.month,
  ///            selectionMode: DatePickerSelectionMode.single,
  ///            headerStyle: DatePickerHeaderStyle(
  ///              backgroundColor: Colors.grey,
  ///            )),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final Color? backgroundColor;

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final DatePickerHeaderStyle otherStyle = other;
    return otherStyle.textStyle == textStyle &&
        otherStyle.textAlign == textAlign &&
        otherStyle.backgroundColor == backgroundColor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<TextAlign>('textAlign', textAlign));
    properties.add(ColorProperty('backgroundColor', backgroundColor));
    properties.add(DiagnosticsProperty<TextStyle>('textStyle', textStyle));
  }

  @override
  int get hashCode {
    return hashValues(
      textStyle,
      textAlign,
      backgroundColor,
    );
  }
}

/// Sets the style to customize [DatePicker] month view view header.
///
/// Allows to customize the [textStyle] and [backgroundColor] of the view header
/// view in month view of [DatePicker].
///
/// ```dart
///
/// Widget build(BuildContext context) {
///    return MaterialApp(
///      home: Scaffold(
///        body: DatePicker(
///          controller: _pickerController,
///          view: DatePickerViewType.month,
///          selectionMode: DatePickerSelectionMode.single,
///          monthViewSettings: DatePickerMonthViewSettings(
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
@immutable
class DatePickerViewHeaderStyle with Diagnosticable {
  /// creates a view header style for month view in [DatePicker].
  const DatePickerViewHeaderStyle({this.backgroundColor, this.textStyle});

  /// The color which fills the background of [DatePicker] view header in
  /// month view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// ```dart
  ///
  ///Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.single,
  ///          monthViewSettings: DatePickerMonthViewSettings(
  ///              viewHeaderStyle:
  ///                 DatePickerViewHeaderStyle(
  ///                       backgroundColor: Colors.red)),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final Color? backgroundColor;

  /// The text style for the text in the [DatePicker] view header view of
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
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.single,
  ///          monthViewSettings: DatePickerMonthViewSettings(
  ///              viewHeaderStyle: DatePickerViewHeaderStyle(
  ///                  textStyle: TextStyle(
  ///                      fontWeight: FontWeight.w500,
  ///                      fontStyle: FontStyle.italic,
  ///                      fontSize: 20,
  ///                      color: Colors.white))),
  ///        ),
  ///      ),
  ///    );
  /// }
  ///
  /// ```
  final TextStyle? textStyle;

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final DatePickerViewHeaderStyle otherStyle = other;
    return otherStyle.backgroundColor == backgroundColor &&
        otherStyle.textStyle == textStyle;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('backgroundColor', backgroundColor));
    properties.add(DiagnosticsProperty<TextStyle>('textStyle', textStyle));
  }

  @override
  int get hashCode {
    return hashValues(
      backgroundColor,
      textStyle,
    );
  }
}

/// The settings have properties which allow to customize the month view of the
/// [DatePicker].
///
/// Allows to customize the [numberOfWeeksInView], [firstDayOfWeek],
/// [dayFormat], [viewHeaderHeight], [showTrailingAndLeadingDates],
/// [viewHeaderStyle], [enableSwipeSelection], [blackoutDates], [specialDates]
/// and [weekendDays] in month view of date range picker.
///
/// ```dart
///
///Widget build(BuildContext context) {
///    return MaterialApp(
///      home: Scaffold(
///        body: DatePicker(
///          view: DatePickerViewType.month,
///          monthViewSettings: DatePickerMonthViewSettings(
///              numberOfWeeksInView: 5,
///              firstDayOfWeek: 1,
///              dayFormat: 'E',
///              viewHeaderHeight: 70,
///              selectionRadius: 10,
///              showTrailingAndLeadingDates: true,
///              viewHeaderStyle: DatePickerViewHeaderStyle(
///                  backgroundColor: Colors.blue,
///                  textStyle:
///                      TextStyle(fontWeight: FontWeight.w400, fontSize: 15,
///                           Colors.black)),
///              enableSwipeSelection: false,
///              blackoutDates: <DateTime>[
///                DateTime.now().add(Duration(days: 4))
///              ],
///              specialDates: <DateTime>[
///                DateTime.now().add(Duration(days: 7)),
///                DateTime.now().add(Duration(days: 8))
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
class DatePickerMonthViewSettings with Diagnosticable {
  /// Creates a date range picker month view settings for date range picker.
  ///
  /// The properties allows to customize the month view of [DatePicker].
  const DatePickerMonthViewSettings(
      {this.numberOfWeeksInView = 6,
      this.firstDayOfWeek = 7,
      this.dayFormat = 'EE',
      this.viewHeaderHeight = 30,
      this.showTrailingAndLeadingDates = false,
      this.viewHeaderStyle = const DatePickerViewHeaderStyle(),
      this.enableSwipeSelection = true,
      this.blackoutDates,
      this.specialDates,
      this.weekendDays = const <int>[6, 7]});

  /// Formats a text in the [DatePicker] month view view header.
  ///
  /// Text format in the [DatePicker] month view view header.
  ///
  /// Defaults to `EE`.
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.single,
  ///          monthViewSettings: DatePickerMonthViewSettings(
  ///               dayFormat: 'EEE'),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final String dayFormat;

  /// The number of weeks to display in [DatePicker]'s month view.
  ///
  /// Defaults to `6`.
  ///
  /// _Note:_ If this property is set to a value other than ' 6, ' the trailing
  /// and lead dates style will not be updated and the trailing and leading
  /// dates will be displayed even if the [showTrailingAndLeadingDates] property
  /// is set to [false].
  ///
  /// This property not applicable when the [DatePicker.pickerMode] set
  ///  as [DatePickerMode.hijri].
  ///
  /// See also: [DatePickerMonthCellStyle] to know about leading and
  /// trailing dates style.
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.single,
  ///          monthViewSettings:
  ///              DatePickerMonthViewSettings(numberOfWeeksInView: 4),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final int numberOfWeeksInView;

  /// Enables the swipe selection for [DatePicker], which allows to
  /// select the range of dates by swiping on the dates.
  ///
  /// If it is [false] selecting a two different dates will form the range of
  /// dates by covering the dates between the selected dates.
  ///
  /// Defaults to `true`.
  ///
  /// _Note:_ It is only applicable when the [DatePickerSelectionMode] set
  /// as [DatePickerSelectionMode.range] or
  /// [DatePickerSelectionMode.multiRange].
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          monthViewSettings:
  ///              DatePickerMonthViewSettings(
  ///                   enableSwipeSelection: false),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final bool enableSwipeSelection;

  /// The first day of the week in the [DatePicker] month view.
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
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          monthViewSettings:
  ///              DatePickerMonthViewSettings(firstDayOfWeek: 2),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final int firstDayOfWeek;

  /// Sets the style to customize [DatePicker] month view view header.
  ///
  /// Allows to customize the [textStyle] and [backgroundColor] of the view
  /// header view in month view of [DatePicker].
  ///
  /// See also: [DatePickerViewHeaderStyle].
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.single,
  ///          monthViewSettings: DatePickerMonthViewSettings(
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
  /// [DatePicker].
  ///
  /// Defaults to `30`.
  ///
  /// ![view header with height as 100](https://help.syncfusion.com/flutter/daterangepicker/images/headers/viewheaderheight.png)
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          monthViewSettings:
  ///              DatePickerMonthViewSettings(viewHeaderHeight: 50),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final double viewHeaderHeight;

  /// Makes the [DatePicker] month view leading and trailing dates
  /// visible.
  ///
  /// Defaults to `false`.
  ///
  /// _Note:_ This property not applicable when the
  /// [DatePicker.pickerMode] set as [DatePickerMode.hijri].
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///         selectionMode: DatePickerSelectionMode.range,
  ///          monthViewSettings: DatePickerMonthViewSettings(
  ///              showTrailingAndLeadingDates: true),
  ///        ),
  ///      ),
  ///   );
  ///  }
  ///
  /// ```
  final bool showTrailingAndLeadingDates;

  /// Disables the interactions for certain dates in the month view of
  /// [DatePicker].
  ///
  /// Defaults to null.
  ///
  /// Use [DatePickerMonthCellStyle.blackoutDateTextStyle] or
  /// [DatePickerMonthCellStyle.blackoutDatesDecoration] property to
  /// customize the appearance of blackout dates in month view.
  ///
  /// See also:
  /// [DatePickerMonthCellStyle.blackoutDateTextStyle]
  /// [DatePickerMonthCellStyle.blackoutDatesDecoration].
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          monthViewSettings:
  ///              DatePickerMonthViewSettings(blackoutDates: <DateTime>[
  ///            DateTime.now().add(Duration(days: 2)),
  ///            DateTime.now().add(Duration(days: 3)),
  ///            DateTime.now().add(Duration(days: 6)),
  ///            DateTime.now().add(Duration(days: 7))
  ///          ]),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final List<DateTime>? blackoutDates;

  /// In the month view of [DatePicker] highlights the unique dates with
  /// different style rather than the other dates style.
  ///
  /// Defaults to null.
  ///
  /// Use [DatePickerMonthCellStyle.specialDatesTextStyle] or
  /// [DatePickerMonthCellStyle.specialDatesDecoration] property to
  /// customize the appearance of blackout dates in month view.
  ///
  /// See also:
  /// [DatePickerMonthCellStyle.specialDatesTextStyle]
  /// [DatePickerMonthCellStyle.specialDatesDecoration].
  ///
  /// ```dart
  ///
  ///Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          monthViewSettings:
  ///              DatePickerMonthViewSettings(specialDates: <DateTime>[
  ///            DateTime.now().add(Duration(days: 2)),
  ///            DateTime.now().add(Duration(days: 3)),
  ///            DateTime.now().add(Duration(days: 6)),
  ///            DateTime.now().add(Duration(days: 7))
  ///          ]),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final List<DateTime>? specialDates;

  /// The weekends for month view in [DatePicker].
  ///
  /// Defaults to `<int>[6,7]` represents `<int>[DateTime.saturday,
  ///  DateTime.sunday]`.
  ///
  /// _Note:_ The [weekendDays] will not be highlighted until it's customize by
  /// using the [DatePickerMonthCellStyle.weekendTextStyle] or
  /// [DatePickerMonthCellStyle.weekendDatesDecoration] property.
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          monthViewSettings: DatePickerMonthViewSettings(
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

    final DatePickerMonthViewSettings otherStyle = other;
    return otherStyle.dayFormat == dayFormat &&
        otherStyle.numberOfWeeksInView == numberOfWeeksInView &&
        otherStyle.firstDayOfWeek == firstDayOfWeek &&
        otherStyle.viewHeaderStyle == viewHeaderStyle &&
        otherStyle.viewHeaderHeight == viewHeaderHeight &&
        otherStyle.showTrailingAndLeadingDates == showTrailingAndLeadingDates &&
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
    properties.add(IntProperty('numberOfWeeksInView', numberOfWeeksInView));
    properties.add(IntProperty('firstDayOfWeek', firstDayOfWeek));
    properties.add(DoubleProperty('viewHeaderHeight', viewHeaderHeight));
    properties.add(StringProperty('dayFormat', dayFormat));
    properties.add(DiagnosticsProperty<bool>(
        'showTrailingAndLeadingDates', showTrailingAndLeadingDates));
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
        showTrailingAndLeadingDates,
        numberOfWeeksInView,
        hashList(specialDates),
        hashList(blackoutDates),
        hashList(weekendDays));
  }
}

/// The style have properties which allow to customize the year, decade and
/// century view of the [DatePicker].
///
/// Allows to customize the [textStyle], [todayTextStyle],
/// [leadingDatesTextStyle], [disabledDatesTextStyle], [cellDecoration],
/// [todayCellDecoration], [leadingDatesDecoration] and
/// [disabledDatesDecoration] in year, decade and century view of the
/// [DatePicker].
///
/// ``` dart
///
/// Widget build(BuildContext context) {
///    return MaterialApp(
///      home: Scaffold(
///        body: DatePicker(
///          view: DatePickerViewType.decade,
///          enablePastDates: false,
///          yearCellStyle: DatePickerYearCellStyle(
///            textStyle: TextStyle(
///                fontWeight: FontWeight.w400, fontSize: 15,
///                     color: Colors.black),
///            todayTextStyle: TextStyle(
///                fontStyle: FontStyle.italic,
///                fontSize: 15,
///                fontWeight: FontWeight.w500,
///                color: Colors.red),
///            leadingDatesDecoration: BoxDecoration(
///                color: const Color(0xFFDFDFDF),
///                border: Border.all(color: const Color(0xFFB6B6B6), width: 1),
///                shape: BoxShape.circle),
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
class DatePickerYearCellStyle with Diagnosticable {
  /// Creates a date range picker year cell style for date range picker.
  ///
  /// The properties allows to customize the year cells in year view of
  /// [DatePicker].
  const DatePickerYearCellStyle(
      {this.textStyle,
      this.todayTextStyle,
      this.leadingDatesTextStyle,
      this.disabledDatesTextStyle,
      this.cellDecoration,
      this.todayCellDecoration,
      this.disabledDatesDecoration,
      this.leadingDatesDecoration});

  /// The text style for the text in the [DatePicker] year, decade and
  /// century view cells.
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
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.year,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          yearCellStyle: DatePickerYearCellStyle(
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

  /// The text style for the text in the today cell of [DatePicker]
  /// year, decade and century view.
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
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.year,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          yearCellStyle: DatePickerYearCellStyle(
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

  /// The text style for the text in the leading dates cells of
  /// [DatePicker] year, decade and century view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// _Note:_ This property not applicable when the
  /// [DatePicker.pickerMode] set as [DatePickerMode.hijri].
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.year,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          yearCellStyle: DatePickerYearCellStyle(
  ///              leadingDatesTextStyle: TextStyle(
  ///                  fontSize: 12,
  ///                  fontWeight: FontWeight.w300,
  ///                  color: Colors.black)),
  ///       ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```
  final TextStyle? leadingDatesTextStyle;

  /// The text style for the text in the disabled dates cell of
  /// [DatePicker] year, decade and century view.
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
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.year,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          yearCellStyle: DatePickerYearCellStyle(
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

  /// The decoration for the disabled cells of [DatePicker]
  /// year, decade and century view.
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
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.century,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          yearCellStyle: DatePickerYearCellStyle(
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

  /// The decoration for the cells of [DatePicker] year, decade
  /// and century view.
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
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.century,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          yearCellStyle: DatePickerYearCellStyle(
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

  /// The decoration for the today cell of [DatePicker] year, decade
  /// and century view.
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
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.century,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          yearCellStyle: DatePickerYearCellStyle(
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

  /// The decoration for the leading date cells of [DatePicker]
  /// year, decade and century view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// _Note:_ This property not applicable when the
  /// [DatePicker.pickerMode] set as [DatePickerMode.hijri].
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.century,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          yearCellStyle: DatePickerYearCellStyle(
  ///            leadingDatesDecoration: BoxDecoration(
  ///                color: Colors.grey.withOpacity(0.4),
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
  final Decoration? leadingDatesDecoration;

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final DatePickerYearCellStyle otherStyle = other;
    return otherStyle.textStyle == textStyle &&
        otherStyle.todayTextStyle == todayTextStyle &&
        otherStyle.leadingDatesTextStyle == leadingDatesTextStyle &&
        otherStyle.disabledDatesDecoration == disabledDatesDecoration &&
        otherStyle.cellDecoration == cellDecoration &&
        otherStyle.todayCellDecoration == todayCellDecoration &&
        otherStyle.leadingDatesDecoration == leadingDatesDecoration &&
        otherStyle.disabledDatesTextStyle == disabledDatesTextStyle;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextStyle>('textStyle', textStyle));
    properties
        .add(DiagnosticsProperty<TextStyle>('todayTextStyle', todayTextStyle));
    properties.add(DiagnosticsProperty<TextStyle>(
        'leadingDatesTextStyle', leadingDatesTextStyle));
    properties.add(DiagnosticsProperty<TextStyle>(
        'disabledDatesTextStyle', disabledDatesTextStyle));
    properties.add(DiagnosticsProperty<Decoration>(
        'disabledDatesDecoration', disabledDatesDecoration));
    properties
        .add(DiagnosticsProperty<Decoration>('cellDecoration', cellDecoration));
    properties.add(DiagnosticsProperty<Decoration>(
        'todayCellDecoration', todayCellDecoration));
    properties.add(DiagnosticsProperty<Decoration>(
        'leadingDatesDecoration', leadingDatesDecoration));
  }

  @override
  int get hashCode {
    return hashValues(
        textStyle,
        todayTextStyle,
        leadingDatesTextStyle,
        disabledDatesTextStyle,
        disabledDatesDecoration,
        cellDecoration,
        todayCellDecoration,
        leadingDatesDecoration);
  }
}

/// The style allows to customize month cells of the [DatePicker].
///
///
/// Allows to customize the [textStyle],
/// [todayTextStyle], [trailingDatesTextStyle], [leadingDatesTextStyle],
/// [disabledDatesTextStyle], [blackoutDateTextStyle],
/// [weekendTextStyle], [specialDatesTextStyle], [specialDatesDecoration],
/// [blackoutDatesDecoration], [cellDecoration], [todayCellDecoration],
/// [disabledDatesDecoration], [trailingDatesDecoration],
/// [leadingDatesDecoration], and [weekendDatesDecoration]  in the month cells
/// of the date range picker.
///
/// ``` dart
///
/// Widget build(BuildContext context) {
///    return MaterialApp(
///      home: Scaffold(
///        body: DatePicker(
///          view: DatePickerViewType.month,
///          enablePastDates: false,
///          monthCellStyle: DatePickerMonthCellStyle(
///            textStyle: TextStyle(
///                fontWeight: FontWeight.w400, fontSize: 15,
///                     color: Colors.black),
///            todayTextStyle: TextStyle(
///                fontStyle: FontStyle.italic,
///                fontSize: 15,
///                fontWeight: FontWeight.w500,
///                color: Colors.red),
///            leadingDatesDecoration: BoxDecoration(
///                color: const Color(0xFFDFDFDF),
///                border: Border.all(color: const Color(0xFFB6B6B6), width: 1),
///                shape: BoxShape.circle),
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
class DatePickerMonthCellStyle with Diagnosticable {
  /// Creates a date range picker month cell style for date range picker.
  ///
  /// The properties allows to customize the month cells in month view of
  /// [DatePicker].
  const DatePickerMonthCellStyle(
      {this.textStyle,
      this.todayTextStyle,
      this.trailingDatesTextStyle,
      this.leadingDatesTextStyle,
      this.disabledDatesTextStyle,
      this.blackoutDateTextStyle,
      this.weekendTextStyle,
      this.specialDatesTextStyle,
      this.specialDatesDecoration,
      this.blackoutDatesDecoration,
      this.cellDecoration,
      this.todayCellDecoration,
      this.disabledDatesDecoration,
      this.trailingDatesDecoration,
      this.leadingDatesDecoration,
      this.weekendDatesDecoration});

  /// The text style for the text in the [DatePicker] month cells.
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
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///         view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          monthCellStyle: DatePickerMonthCellStyle(
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

  /// The text style for the text in the today cell of [DatePicker]
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
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          monthCellStyle: DatePickerMonthCellStyle(
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

  /// The text style for the text in the trailing dates cell of
  /// [DatePicker] month view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// _Note:_ This is applies only when the
  /// [DatePickerMonthViewSettings.showTrailingAndLeadingDates] property
  /// set as [true].
  ///
  /// This property not applicable when the [DatePicker.pickerMode] set
  /// as [DatePickerMode.hijri].
  ///
  /// See also:[DatePickerMonthViewSettings.showTrailingAndLeadingDates].
  ///
  /// ``` dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          monthViewSettings: DatePickerMonthViewSettings(
  ///              showTrailingAndLeadingDates: true),
  ///          monthCellStyle: DatePickerMonthCellStyle(
  ///              trailingDatesTextStyle: TextStyle(
  ///                  fontStyle: FontStyle.normal,
  ///                  fontWeight: FontWeight.w300,
  ///                  fontSize: 11,
  ///                  color: Colors.black)),
  ///        ),
  ///     ),
  ///    );
  ///  }
  ///
  /// ```
  final TextStyle? trailingDatesTextStyle;

  /// The text style for the text in the leading dates cell of
  /// [DatePicker] month view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// _Note:_ This is applies only when the
  /// [DatePickerMonthViewSettings.showTrailingAndLeadingDates] property
  /// set as [true].
  ///
  /// This property not applicable when the [DatePicker.pickerMode] set
  /// as [DatePickerMode.hijri].
  ///
  /// See also:[DatePickerMonthViewSettings.showTrailingAndLeadingDates].
  ///
  /// ``` dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          monthViewSettings: DatePickerMonthViewSettings(
  ///              showTrailingAndLeadingDates: true),
  ///          monthCellStyle: DatePickerMonthCellStyle(
  ///              leadingDatesTextStyle: TextStyle(
  ///                  fontStyle: FontStyle.normal,
  ///                  fontWeight: FontWeight.w300,
  ///                  fontSize: 11,
  ///                  color: Colors.black)),
  ///        ),
  ///     ),
  ///    );
  ///  }
  ///
  /// ```
  final TextStyle? leadingDatesTextStyle;

  /// The text style for the text in the disabled dates cell of
  /// [DatePicker] month view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// See also:
  /// [DatePicker.minDate].
  /// [DatePicker.maxDate].
  /// [DatePicker.enablePastDates].
  ///
  /// ``` dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///          monthCellStyle: DatePickerMonthCellStyle(
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

  /// The text style for the text in the selected range or ranges cell of
  /// [DatePicker] month view.
  ///
  /// The style applies to the dates that falls between the
  /// [PickerDateRange.startDate] and [PickerDateRange.endDate].
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// _Note:_ This applies only when [DatePickerSelectionMode] set as
  /// [DatePickerSelectionMode.range] or
  /// [DatePickerSelectionMode.multiRange].
  ///
  /// See also:
  /// [PickerDateRange]
  /// [DatePickerSelectionMode]
  ///
  /// ``` dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///          monthCellStyle: DatePickerMonthCellStyle(
  ///              rangeTextStyle: TextStyle(
  ///                  fontStyle: FontStyle.italic,
  ///                  fontWeight: FontWeight.w500,
  ///                  fontSize: 12,
  ///                  color: Colors.black)),
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///
  /// ```

  final TextStyle? blackoutDateTextStyle;

  /// The text style for the text in the weekend dates cell of
  /// [DatePicker] month view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// See also: [DatePickerMonthViewSettings.weekendDays].
  ///
  /// ``` dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///          monthCellStyle: DatePickerMonthCellStyle(
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
  /// [DatePicker] month view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// See also: [DatePickerMonthViewSettings.specialDates].
  ///
  /// ``` dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///          monthCellStyle: DatePickerMonthCellStyle(
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

  /// The decoration for the special date cells of [DatePicker]
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
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///          monthCellStyle: DatePickerMonthCellStyle(
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

  /// The decoration for the weekend date cells of [DatePicker]
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
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///          monthCellStyle: DatePickerMonthCellStyle(
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

  /// The decoration for the blackout date cells of [DatePicker]
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
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///          monthCellStyle: DatePickerMonthCellStyle(
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

  /// The decoration for the disabled date cells of [DatePicker]
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
  /// [DatePicker.minDate].
  /// [DatePicker.maxDate].
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///          monthCellStyle: DatePickerMonthCellStyle(
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

  /// The decoration for the month cells of [DatePicker] month view.
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
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///          monthCellStyle: DatePickerMonthCellStyle(
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

  /// The decoration for the today text cell of [DatePicker] month view.
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
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///          monthCellStyle: DatePickerMonthCellStyle(
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

  /// The decoration for the trailing date cells of [DatePicker]
  /// month view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// _Note:_ This is applies only when the
  /// [DatePickerMonthViewSettings.showTrailingAndLeadingDates] property
  /// set as [true].
  ///
  /// This property not applicable when the [DatePicker.pickerMode] set
  /// as [DatePickerMode.hijri].
  ///
  /// See also:[DatePickerMonthViewSettings.showTrailingAndLeadingDates].
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///          monthCellStyle: DatePickerMonthCellStyle(
  ///            trailingDatesDecoration: BoxDecoration(
  ///                color: Colors.black26,
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
  final Decoration? trailingDatesDecoration;

  /// The decoration for the leading date cells of [DatePicker]
  /// month view.
  ///
  /// Defaults to null.
  ///
  /// Using a [DatePickerTheme] gives more fine-grained control over the
  /// appearance of various components of the date range picker.
  ///
  /// _Note:_  This is applies only when the
  /// [DatePickerMonthViewSettings.showLeadingAndTrailingDate] property set
  /// as [true].
  ///
  /// This property not applicable when the [DatePicker.pickerMode] set
  /// as [DatePickerMode.hijri].
  ///
  /// See also:[DatePickerMonthViewSettings.showLeadingAndTrailingDate].
  ///
  /// ```dart
  ///
  /// Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          enablePastDates: false,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///          monthCellStyle: DatePickerMonthCellStyle(
  ///            leadingDatesDecoration: BoxDecoration(
  ///                color: Colors.black26,
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
  final Decoration? leadingDatesDecoration;

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final DatePickerMonthCellStyle otherStyle = other;
    return otherStyle.textStyle == textStyle &&
        otherStyle.todayTextStyle == todayTextStyle &&
        otherStyle.trailingDatesTextStyle == trailingDatesTextStyle &&
        otherStyle.leadingDatesTextStyle == leadingDatesTextStyle &&
        otherStyle.blackoutDateTextStyle == blackoutDateTextStyle &&
        otherStyle.weekendTextStyle == weekendTextStyle &&
        otherStyle.specialDatesTextStyle == specialDatesTextStyle &&
        otherStyle.specialDatesDecoration == specialDatesDecoration &&
        otherStyle.weekendDatesDecoration == weekendDatesDecoration &&
        otherStyle.blackoutDatesDecoration == blackoutDatesDecoration &&
        otherStyle.disabledDatesDecoration == disabledDatesDecoration &&
        otherStyle.cellDecoration == cellDecoration &&
        otherStyle.todayCellDecoration == todayCellDecoration &&
        otherStyle.trailingDatesDecoration == trailingDatesDecoration &&
        otherStyle.leadingDatesDecoration == leadingDatesDecoration &&
        otherStyle.disabledDatesTextStyle == disabledDatesTextStyle;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextStyle>('textStyle', textStyle));
    properties
        .add(DiagnosticsProperty<TextStyle>('todayTextStyle', todayTextStyle));
    properties.add(DiagnosticsProperty<TextStyle>(
        'trailingDatesTextStyle', trailingDatesTextStyle));
    properties.add(DiagnosticsProperty<TextStyle>(
        'leadingDatesTextStyle', leadingDatesTextStyle));
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
        'trailingDatesDecoration', trailingDatesDecoration));
    properties.add(DiagnosticsProperty<Decoration>(
        'leadingDatesDecoration', leadingDatesDecoration));
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
      trailingDatesTextStyle,
      leadingDatesTextStyle,
      disabledDatesTextStyle,
      specialDatesDecoration,
      weekendDatesDecoration,
      blackoutDatesDecoration,
      disabledDatesDecoration,
      cellDecoration,
      todayCellDecoration,
      trailingDatesDecoration,
      leadingDatesDecoration,
      specialDatesTextStyle,
      blackoutDateTextStyle,
      weekendTextStyle,
    ]);
  }
}

typedef DatePickerValueChangeCallback = void Function(String);

/// Notifier used to notify the when the objects properties changed.
class DatePickerValueChangeNotifier with Diagnosticable {
  List<DatePickerValueChangeCallback>? _listeners;

  /// Calls the listener every time the controller's property changed.
  ///
  /// Listeners can be removed with [removePropertyChangedListener].
  void addPropertyChangedListener(DatePickerValueChangeCallback listener) {
    _listeners ??= <DatePickerValueChangeCallback>[];
    _listeners?.add(listener);
  }

  /// remove the listener used for notify the data source changes.
  ///
  /// Stop calling the listener every time in controller's property changed.
  ///
  /// If `listener` is not currently registered as a listener, this method does
  /// nothing.
  ///
  /// Listeners can be added with [addPropertyChangedListener].
  void removePropertyChangedListener(DatePickerValueChangeCallback listener) {
    if (_listeners == null) {
      return;
    }

    _listeners?.remove(listener);
  }

  /// Call all the registered listeners.
  ///
  /// Call this method whenever the object changes, to notify any clients the
  /// object may have. Listeners that are added during this iteration will not
  /// be visited. Listeners that are removed during this iteration will not be
  /// visited after they are removed.
  ///
  /// This method must not be called after [dispose] has been called.
  ///
  /// Surprising behavior can result when reentrantly removing a listener (i.e.
  /// in response to a notification) that has been registered multiple times.
  /// See the discussion at [removePropertyChangedListener].
  void notifyPropertyChangedListeners(String value) {
    if (_listeners == null) {
      return;
    }

    for (final DatePickerValueChangeCallback listener in _listeners!) {
      listener.call(value);
    }
  }

  /// Discards any resources used by the object. After this is called, the
  /// object is not in a usable state and should be discarded (calls to
  /// [addListener] and [removeListener] will throw after the object is
  /// disposed).
  ///
  /// This method should only be called by the object's owner.
  @mustCallSuper
  void dispose() {
    _listeners = null;
  }
}

/// An object that used for programmatic date navigation, date and range
/// selection and view switching in [DatePicker].
///
/// A [DatePickerController] served for several purposes. It can be used
/// to selected dates and ranges programmatically on [DatePicker] by
/// using the[controller.selectedDate], [controller.selectedDates],
/// [controller.selectedRange], [controller.selectedRanges]. It can be used to
/// change the [DatePicker] view by using the [controller.view] property.
/// It can be used to navigate to specific date by using the
/// [controller.displayDate] property.
///
/// ## Listening to property changes:
/// The [DatePickerController] is a listenable. It notifies it's listeners
/// whenever any of attached [DatePicker]`s selected date, display date
/// and view changed (i.e: selecting a different date, swiping to next/previous
/// view and navigates to different view] in in [DatePicker].
///
/// ## Navigates to different view:
/// The [DatePicker] visible view can be changed by using the
/// [Controller.view] property, the property allow to change the view of
/// [DatePicker] programmatically on initial load and in rum time.
///
/// ## Programmatic selection:
/// In [DatePicker] selecting dates programmatically can be achieved by
/// using the [controller.selectedDate], [controller.selectedDates],
/// [controller.selectedRange], [controller.selectedRanges] which allows to
/// select the dates or ranges programmatically on [DatePicker] on
/// initial load and in run time.
///
/// See also: [DatePickerSelectionMode]
///
/// Defaults to null.
///
/// This example demonstrates how to use the [DatePickerController] for
/// [DatePicker].
///
/// ``` dart
///
///class MyApp extends StatefulWidget {
///  @override
///  MyAppState createState() => MyAppState();
///}
///
///class MyAppState extends State<MyApp> {
///  DatePickerController _pickerController;
///
///  @override
///  void initState() {
///    _pickerController = DatePickerController();
///    _pickerController.selectedDates = <DateTime>[
///      DateTime.now().add(Duration(days: 2)),
///      DateTime.now().add(Duration(days: 4)),
///      DateTime.now().add(Duration(days: 7)),
///      DateTime.now().add(Duration(days: 11))
///    ];
///    _pickerController.displayDate = DateTime.now();
///    _pickerController.addPropertyChangedListener(handlePropertyChange);
///    super.initState();
///  }
///
///  void handlePropertyChange(String propertyName) {
///    if (propertyName == 'selectedDates') {
///      final List<DateTime> selectedDates = _pickerController.selectedDates;
///    } else if (propertyName == 'displayDate') {
///      final DateTime displayDate = _pickerController.displayDate;
///    }
///  }
///
///  @override
///  Widget build(BuildContext context) {
///    return MaterialApp(
///      home: Scaffold(
///        body: DatePicker(
///          view: DatePickerViewType.month,
///          controller: _pickerController,
///          selectionMode: DatePickerSelectionMode.multiple,
///        ),
///      ),
///    );
///  }
///}
///
/// ```
class DatePickerController extends DatePickerValueChangeNotifier {
  DateTime? _selectedDate;
  List<DateTime>? _selectedDates;
  PickerDateRange? _selectedRange;
  List<PickerDateRange>? _selectedRanges;
  DateTime? _displayDate;
  DatePickerViewType? _view;

  /// The selected date in the [DatePicker].
  ///
  /// It is only applicable when the [selectionMode] set as
  /// [DatePickerSelectionMode.single] for other selection modes this
  /// property will return as null.
  DateTime? get selectedDate => _selectedDate;

  /// Selects the given date programmatically in the [DatePicker] by
  /// checking that the date falls in between the minimum and maximum date
  /// range.
  ///
  /// _Note:_ If any date selected previously, will be removed and the selection
  ///  will be drawn to the date given in this property.
  ///
  /// If it is not [null] the widget will render the date selection for the date
  /// set to this property, even the [DatePicker.initialSelectedDate] is
  /// not null.
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
  ///    _pickerController = DatePickerController();
  ///    _pickerController.selectedDate = DateTime.now().add((Duration(
  ///                                days: 4)));
  ///    super.initState();
  ///  }
  ///
  ///  @override
  ///  Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.single,
  ///          showNavigationArrow: true,
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///}
  ///
  /// ```
  set selectedDate(DateTime? date) {
    if (date == null) return;

    final bool? isSameDate = _selectedDate?.isSameDate(date);
    if (isSameDate == null || isSameDate) return;

    _selectedDate = date;
    notifyPropertyChangedListeners('selectedDate');
  }

  /// The list of dates selected in the [DatePicker].
  ///
  /// It is only applicable when the [selectionMode] set as
  /// [DatePickerSelectionMode.multiple] for other selection modes this
  /// property will return as null.
  List<DateTime>? get selectedDates => _selectedDates;

  /// Selects the given dates programmatically in the [DatePicker] by
  /// checking that the dates falls in between the minimum and maximum date
  /// range.
  ///
  /// _Note:_ If any list of dates selected previously, will be removed and the
  /// selection will be drawn to the dates set to this property.
  ///
  /// If it is not [null] the widget will render the date selection for the
  /// dates set to this property, even the
  /// [DatePicker.initialSelectedDates] is not null.
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
  ///    _pickerController = DatePickerController();
  ///    _pickerController.selectedDates = <DateTime>[
  ///      DateTime.now().add((Duration(days: 4))),
  ///      DateTime.now().add((Duration(days: 7))),
  ///      DateTime.now().add((Duration(days: 8)))
  ///    ];
  ///    super.initState();
  ///  }
  ///
  ///  @override
  ///  Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.multiple,
  ///          showNavigationArrow: true,
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///}
  ///
  /// ```
  set selectedDates(List<DateTime>? dates) {
    if (DatePickerHelper.isDateCollectionEquals(_selectedDates, dates)) {
      return;
    }

    _selectedDates = DatePickerHelper.cloneList(dates)?.cast<DateTime>();
    notifyPropertyChangedListeners('selectedDates');
  }

  /// selected date range in the [DatePicker].
  ///
  /// It is only applicable when the [selectionMode] set as
  /// [DatePickerSelectionMode.range] for other selection modes this
  /// property will return as null.
  PickerDateRange? get selectedRange => _selectedRange;

  /// Selects the given date range programmatically in the [DatePicker]
  /// by checking that the range of dates falls in between the minimum and
  /// maximum date range.
  ///
  /// _Note:_ If any date range selected previously, will be removed and the
  /// selection will be drawn to the range of dates set to this property.
  ///
  /// If it is not [null] the widget will render the date selection for the
  /// range set to this property, even the
  /// [DatePicker.initialSelectedRange] is not null.
  ///
  /// It is only applicable when the [selectionMode] set as
  /// [DatePickerSelectionMode.range].
  ///
  /// ``` dart
  ///
  /// class MyAppState extends State<MyApp> {
  ///  DatePickerController _pickerController;
  ///
  ///  @override
  ///  void initState() {
  ///    _pickerController = DatePickerController();
  ///    _pickerController.selectedRange = PickerDateRange(
  ///        DateTime.now().add(Duration(days: 4)),
  ///        DateTime.now().add(Duration(days: 5)));
  ///    super.initState();
  ///  }
  ///
  ///  @override
  ///  Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.range,
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///}
  ///
  /// ```
  set selectedRange(PickerDateRange? range) {
    if (DatePickerHelper.isRangeEquals(_selectedRange, range)) {
      return;
    }

    _selectedRange = range;
    notifyPropertyChangedListeners('selectedRange');
  }

  /// List of selected ranges in the [DatePicker].
  ///
  /// It is only applicable when the [selectionMode] set as
  /// [DatePickerSelectionMode.multiRange] for other selection modes this
  /// property will return as null.
  List<PickerDateRange>? get selectedRanges => _selectedRanges;

  /// Selects the given date ranges programmatically in the [DatePicker]
  /// by checking that the ranges of dates falls in between the minimum and
  /// maximum date range.
  ///
  /// If it is not [null] the widget will render the date selection for the
  /// ranges set to this property, even the
  /// [DatePicker.initialSelectedRanges] is not null.
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
  ///  DatePickerController _pickerController;
  ///
  ///  @override
  ///  void initState() {
  ///    _pickerController = DatePickerController();
  ///    _pickerController.selectedRanges = <PickerDateRange>[
  ///      PickerDateRange(DateTime.now().subtract(Duration(days: 4)),
  ///          DateTime.now().add(Duration(days: 4))),
  ///      PickerDateRange(DateTime.now().add(Duration(days: 11)),
  ///          DateTime.now().add(Duration(days: 16)))
  ///    ];
  ///    super.initState();
  ///  }
  ///
  ///  @override
  ///  Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.multiRange,
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///}
  ///
  /// ```
  set selectedRanges(List<PickerDateRange>? ranges) {
    if (DatePickerHelper.isDateRangesEquals(_selectedRanges, ranges)) {
      return;
    }

    _selectedRanges =
        DatePickerHelper.cloneList(ranges)?.cast<PickerDateRange>();
    notifyPropertyChangedListeners('selectedRanges');
  }

  /// The first date of the current visible view month, when the
  /// [MonthViewSettings.numberOfWeeksInView] set with default value 6.
  ///
  /// If the [MonthViewSettings.numberOfWeeksInView] property set with value
  /// other then 6, this will return the first visible date of the current
  /// month.
  DateTime? get displayDate => _displayDate;

  /// Navigates to the given date programmatically without any animation in the
  /// [DatePicker] by checking that the date falls in between the
  /// [DatePicker.minDate] and [DatePicker.maxDate] date range.
  ///
  /// If the date falls beyond the [DatePicker.minDate] and
  /// [DatePicker.maxDate] the widget will move the widgets min or max
  /// date.
  ///
  ///
  /// ``` dart
  ///
  /// class MyAppState extends State<MyApp> {
  ///  DatePickerController _pickerController;
  ///
  ///  @override
  ///  void initState() {
  ///    _pickerController = DatePickerController();
  ///    _pickerController.displayDate = DateTime(2022, 02, 05);
  ///    super.initState();
  ///  }
  ///
  ///  @override
  ///  Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.single,
  ///        ),
  ///      ),
  ///    );
  ///  }
  ///}
  ///
  /// ```
  set displayDate(DateTime? date) {
    if (date == null) return;

    final bool? isSameDate = _displayDate?.isSameDate(date);
    if (isSameDate == null || isSameDate) return;

    _displayDate = date;
    notifyPropertyChangedListeners('displayDate');
  }

  /// The current visible [DatePickerViewType] of [DatePicker].
  DatePickerViewType? get view => _view;

  /// Set the [DatePickerViewType] for the [DatePicker].
  ///
  ///
  /// The [DatePicker] will display the view sets to this property.
  ///
  /// ```dart
  ///
  /// class MyAppState extends State<MyApp> {
  ///  DatePickerController _pickerController;
  ///
  ///  @override
  ///  void initState() {
  ///    _pickerController = DatePickerController();
  ///    _pickerController.view = DatePickerViewType.year;
  ///    super.initState();
  ///  }
  ///
  ///  @override
  ///  Widget build(BuildContext context) {
  ///    return MaterialApp(
  ///      home: Scaffold(
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
  ///          selectionMode: DatePickerSelectionMode.single,
  ///       ),
  ///      ),
  ///    );
  ///  }
  ///}
  ///
  /// ```
  set view(DatePickerViewType? value) {
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
  ///  DatePickerController _pickerController;
  ///
  ///  @override
  ///  void initState() {
  ///    _pickerController = DatePickerController();
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
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
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
  ///  DatePickerController _pickerController;
  ///
  ///  @override
  ///  void initState() {
  ///    _pickerController = DatePickerController();
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
  ///        body: DatePicker(
  ///          controller: _pickerController,
  ///          view: DatePickerViewType.month,
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
    properties.add(DiagnosticsProperty<DateTime>('displayDate', displayDate));
    properties.add(DiagnosticsProperty<DateTime>('selectedDate', selectedDate));
    properties.add(IterableDiagnostics(selectedDates)
        .toDiagnosticsNode(name: 'selectedDates'));
    properties.add(
        DiagnosticsProperty<PickerDateRange>('selectedRange', selectedRange));
    properties.add(IterableDiagnostics(selectedRanges)
        .toDiagnosticsNode(name: 'selectedRanges'));
    properties.add(EnumProperty<DatePickerViewType>('view', view));
  }
}

/// Selection modes for [DatePicker].
enum DatePickerSelectionMode {
  /// - DatePickerSelectionMode.single, Allows to select a single date,
  /// selecting a new date will remove the selection for previous date and
  /// updates selection to the new selected date.
  single,

  /// - DatePickerSelection.multiple, Allows multiple date selection,
  /// selecting a new date will not remove the selection for previous dates,
  /// allows to select as many dates as possible.
  multiple,

  /// - DatePickerSelection.range, Allows to select a single range of
  /// dates.
  /// See also: [PickerDateRange]
  range,

  /// - DatePickerSelection.multiRange, Allows to select a multiple ranges
  /// of dates.
  ///
  /// See also: [PickerDateRange].
  multiRange
}

/// Available views for [DatePicker].
enum DatePickerViewType {
  /// - DatePickerViewType.month, Displays the month view.
  month,

  /// - DatePickerViewType.year, Displays the year view.
  year,

  /// - DatePickerViewType.decade, Displays the decade view.
  decade,

  /// - DatePickerViewType.century, Display the century view.
  ///
  /// _Note:_ This property not applicable when the
  /// [DatePicker.pickerMode] set as [DatePickerMode.hijri].
  century
}

/// The shape for the selection view in [DatePicker].
enum DatePickerSelectionShape {
  /// - DatePickerSelectionShape.circle, Draws the date selection in circle
  /// shape.
  circle,

  /// - DatePickerSelectionShape.rectangle, Draws the date selection in
  /// rectangle shape.
  rectangle
}

/// A direction in which the [DatePicker] navigates.
enum DatePickerNavigationDirection {
  /// - DatePickerNavigationDirection.vertical, Navigates in top and bottom
  /// direction.
  vertical,

  /// - DatePickerNavigationDirection.horizontal, Navigates in right and
  /// left direction.
  horizontal
}

/// A type specifies how the date picker navigation interaction works.
enum DatePickerNavigationMode {
  /// Disables the next or previous view dates to be shown by scrolling or
  /// swipe interaction in [DatePicker] and [SfHijriDatePicker].
  ///
  /// It will not impact [DatePickerController.forward()],
  /// [DatePickerController.backward()] and [showNavigationArrow].
  none,

  /// Allows navigating to previous/next views through swipe interaction in
  /// [DatePicker] and [SfHijriDatePicker].
  snap,

  /// Enable free-scrolling based on [DatePicker]'s navigation direction.
  ///
  /// Note:
  /// 1.Swipe selection is not supported when range and multi-range are the
  /// selection modes.
  /// 2.[onViewChanged] will be called when the view reaches the starting
  /// position of the date range picker view.
  /// 3.[DatePickerController.forward()],
  /// [DatePickerController.backward()] and [showNavigationArrow] is
  /// not supported.
  /// 4. [viewSpacing] value not applicable when [enableMultiView] enabled for
  /// scroll mode.
  /// 5. [textAlign] in picker header style is not supported on horizontal
  /// navigation direction.
  /// 6. header view background color changed to white on light theme or
  /// grey[850] on dark theme when [backgroundColor] in
  /// [DatePickerHeaderStyle] is transparent.
  scroll
}

/// The dates that visible on the view changes in [DatePicker].
///
/// Details for [DatePickerViewChangedCallback], such as [visibleDateRange]
/// and [view].
@immutable
class DatePickerViewChangeArgs {
  /// Creates details for [DatePickerViewChangedCallback].
  const DatePickerViewChangeArgs(this.visibleDateRange, this.view);

  /// The date range of the currently visible view dates.
  ///
  /// See also: [PickerDateRange].
  final PickerDateRange visibleDateRange;

  /// The currently visible [DatePickerViewType] in the [DatePicker].
  ///
  /// See also: [DatePickerViewType].
  final DatePickerViewType view;
}

/// The selected dates or ranges changes in the [DatePicker].
///
/// Details for [DatePickerSelectionChangedCallback], such as selected
/// value.
@immutable
class DatePickerSelectionChangeArgs {
  /// Creates details for [DatePickerSelectionChangedCallback].
  const DatePickerSelectionChangeArgs(this.value);

  /// The changed selected dates or ranges value.
  ///
  /// The argument value will return the changed date as [DateTime] when the
  /// widget [DatePickerSelectionMode] set as single.
  ///
  /// The argument value will return the changed dates as [List<DateTime>] when
  /// the widget [DatePickerSelectionMode] set as multiple.
  ///
  /// The argument value will return the changed range as [PickerDateRange]
  /// when the widget [DatePickerSelectionMode] set as range.
  ///
  /// The argument value will return the changed ranges as
  /// [List<PickerDateRange] when the widget [DatePickerSelectionMode] set
  /// as multi range.
  final dynamic value;
}

/// Defines a range of dates, covers the dates in between the given [startDate]
/// and [endDate] as a range.
@immutable
class PickerDateRange with Diagnosticable {
  /// Creates a picker date range with the given start and end date.
  const PickerDateRange(this.startDate, this.endDate);

  /// The start date of the range.
  final DateTime? startDate;

  /// The end date of the range.
  final DateTime? endDate;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DateTime>('startDate', startDate));
    properties.add(DiagnosticsProperty<DateTime>('endDate', endDate));
  }
}

/// Signature for a function that creates a widget based on date range picker
/// cell details.
typedef DatePickerCellBuilder = Widget Function(
    BuildContext context, DatePickerCellDetails cellDetails);

/// Contains the details that needed on calendar cell builder.
class DatePickerCellDetails {
  /// Constructor to store the details that needed on calendar cell builder.
  DatePickerCellDetails(
      {required this.date, required this.bounds, required this.visibleDates});

  /// Date value associated with the picker cell in month, year, decade and
  /// century views.
  final DateTime date;

  /// Position and size of the widget.
  final Rect bounds;

  /// Visible dates value associated with the current picker month, year,
  /// decade and century views. It is used to get the cell, leading and
  /// trailing dates details.
  final List<DateTime> visibleDates;
}

/// Defines the diagnostics for the collection.
class IterableDiagnostics<T> extends DiagnosticableTree {
  /// Constructor for collection diagnostics.
  IterableDiagnostics(this.collection);

  /// Iterable that used to generate diagnostics.
  final List<T>? collection;

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    if (collection != null && collection!.isNotEmpty) {
      return collection!.map<DiagnosticsNode>((T value) {
        if (value is Diagnosticable) {
          return value.toDiagnosticsNode();
        } else {
          return DiagnosticsProperty<T>('', value);
        }
      }).toList();
    }
    return super.debugDescribeChildren();
  }

  @override
  String toStringShort() {
    return collection == null
        ? 'null'
        : collection!.isNotEmpty
            ? '<' + T.toString() + '>'
            : '<none>';
  }
}
