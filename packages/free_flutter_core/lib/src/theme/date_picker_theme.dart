import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core_theme.dart';

/// Applies a theme to descendant Syncfusion date range picker widgets.
///
/// ```dart
/// Widget build(BuildContext context) {
///  return Scaffold(
///     body: DatePickerTheme(
///       data: DatePickerThemeData(
///         backgroundColor: Colors.grey,
///         brightness: Brightness.dark,
///       ),
///       child: DatePicker()
///     ),
///   );
/// }
/// ```
class DatePickerTheme extends InheritedTheme {
  /// Constructor for teh calendar theme class, which applies a theme to
  /// descendant Syncfusion date range picker widgets.
  const DatePickerTheme({Key? key, required this.data, required this.child})
      : super(key: key, child: child);

  /// Specifies the color and typography values for descendant chart widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///     body: DatePickerTheme(
  ///       data: DatePickerThemeData(
  ///         backgroundColor: Colors.grey,
  ///         brightness: Brightness.dark,
  ///       ),
  ///       child: DatePicker()
  ///     ),
  ///   );
  /// }
  /// ```
  final DatePickerThemeData data;

  /// Specifies a widget that can hold single child.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///     body: DatePickerTheme(
  ///       data: DatePickerThemeData(
  ///         backgroundColor: Colors.grey,
  ///         brightness: Brightness.dark,
  ///       ),
  ///       child: DatePicker()
  ///     ),
  ///   );
  /// }
  /// ```
  @override
  final Widget child;

  /// The data from the closest [DatePickerTheme] instance
  /// that encloses the given context.
  ///
  /// Defaults to [CoreThemeData.dateRangePickerTheme] if there is no
  /// [DatePickerTheme] in the given build context.
  static DatePickerThemeData of(BuildContext context) {
    final DatePickerTheme? datePickerTheme =
        context.dependOnInheritedWidgetOfExactType<DatePickerTheme>();
    return datePickerTheme?.data ?? CoreTheme.of(context).datePickerThemeData;
  }

  @override
  bool updateShouldNotify(DatePickerTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final DatePickerTheme? ancestorTheme =
        context.findAncestorWidgetOfExactType<DatePickerTheme>();
    return identical(this, ancestorTheme)
        ? child
        : DatePickerTheme(data: data, child: child);
  }
}

/// Holds the color and typography values for a [DatePickerTheme]. Use
///  this class to configure a [DatePickerTheme] widget
///
/// To obtain the current theme, use [DatePickerTheme.of].
///
/// ```dart
/// Widget build(BuildContext context) {
///  return Scaffold(
///     body: DatePickerTheme(
///       data: DatePickerThemeData(
///         backgroundColor: Colors.grey,
///         brightness: Brightness.dark,
///       ),
///       child: DatePicker()
///     ),
///   );
/// }
/// ```
class DatePickerThemeData with Diagnosticable {
  /// Create a [DatePickerThemeData] that's used to configure a
  /// [DatePickerTheme].
  factory DatePickerThemeData({
    Brightness? brightness,
    Color? backgroundColor,
    Color? startRangeSelectionColor,
    Color? endRangeSelectionColor,
    Color? headerBackgroundColor,
    Color? viewHeaderBackgroundColor,
    Color? todayHighlightColor,
    Color? selectionColor,
    Color? rangeSelectionColor,
    TextStyle? viewHeaderTextStyle,
    TextStyle? headerTextStyle,
    TextStyle? trailingDatesTextStyle,
    TextStyle? leadingCellTextStyle,
    TextStyle? activeDatesTextStyle,
    TextStyle? cellTextStyle,
    TextStyle? rangeSelectionTextStyle,
    TextStyle? leadingDatesTextStyle,
    TextStyle? disabledDatesTextStyle,
    TextStyle? disabledCellTextStyle,
    TextStyle? selectionTextStyle,
    TextStyle? blackoutDatesTextStyle,
    TextStyle? todayTextStyle,
    TextStyle? todayCellTextStyle,
    TextStyle? weekendDatesTextStyle,
    TextStyle? specialDatesTextStyle,
  }) {
    brightness = brightness ?? Brightness.light;
    final bool isLight = brightness == Brightness.light;
    backgroundColor ??= Colors.transparent;
    headerBackgroundColor ??= Colors.transparent;
    viewHeaderBackgroundColor ??= Colors.transparent;
    viewHeaderTextStyle ??= isLight
        ? TextStyle(color: Colors.black87, fontSize: 11, fontFamily: 'Roboto')
        : TextStyle(color: Colors.white, fontSize: 11, fontFamily: 'Roboto');
    headerTextStyle ??= isLight
        ? TextStyle(color: Colors.black87, fontSize: 16, fontFamily: 'Roboto')
        : TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Roboto');
    trailingDatesTextStyle ??= isLight
        ? TextStyle(color: Colors.black54, fontSize: 13, fontFamily: 'Roboto')
        : TextStyle(color: Colors.white54, fontSize: 13, fontFamily: 'Roboto');
    leadingCellTextStyle ??= isLight
        ? TextStyle(color: Colors.black54, fontSize: 13, fontFamily: 'Roboto')
        : TextStyle(color: Colors.white54, fontSize: 13, fontFamily: 'Roboto');
    activeDatesTextStyle ??= isLight
        ? TextStyle(color: Colors.black87, fontSize: 13, fontFamily: 'Roboto')
        : TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'Roboto');
    cellTextStyle ??= isLight
        ? TextStyle(color: Colors.black87, fontSize: 13, fontFamily: 'Roboto')
        : TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'Roboto');
    leadingDatesTextStyle ??= isLight
        ? TextStyle(color: Colors.black54, fontSize: 13, fontFamily: 'Roboto')
        : TextStyle(color: Colors.white54, fontSize: 13, fontFamily: 'Roboto');
    rangeSelectionTextStyle ??= isLight
        ? TextStyle(color: Colors.black87, fontSize: 13, fontFamily: 'Roboto')
        : TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'Roboto');
    disabledDatesTextStyle ??= isLight
        ? TextStyle(color: Colors.black26, fontSize: 13, fontFamily: 'Roboto')
        : TextStyle(color: Colors.white38, fontSize: 13, fontFamily: 'Roboto');
    disabledCellTextStyle ??= isLight
        ? TextStyle(color: Colors.black26, fontSize: 13, fontFamily: 'Roboto')
        : TextStyle(color: Colors.white38, fontSize: 13, fontFamily: 'Roboto');
    selectionTextStyle ??= isLight
        ? TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'Roboto')
        : TextStyle(color: Colors.black, fontSize: 13, fontFamily: 'Roboto');
    todayTextStyle ??= isLight
        ? const TextStyle(fontSize: 13, fontFamily: 'Roboto')
        : const TextStyle(fontSize: 13, fontFamily: 'Roboto');
    todayCellTextStyle ??= isLight
        ? const TextStyle(fontSize: 13, fontFamily: 'Roboto')
        : const TextStyle(fontSize: 13, fontFamily: 'Roboto');
    specialDatesTextStyle ??= isLight
        ? const TextStyle(
            color: Color(0xFF339413), fontSize: 13, fontFamily: 'Roboto')
        : const TextStyle(
            color: Color(0xFFEA75FF), fontSize: 13, fontFamily: 'Roboto');

    return DatePickerThemeData.raw(
      brightness: brightness,
      backgroundColor: backgroundColor,
      viewHeaderTextStyle: viewHeaderTextStyle,
      headerTextStyle: headerTextStyle,
      trailingDatesTextStyle: trailingDatesTextStyle,
      leadingCellTextStyle: leadingCellTextStyle,
      activeDatesTextStyle: activeDatesTextStyle,
      cellTextStyle: cellTextStyle,
      rangeSelectionTextStyle: rangeSelectionTextStyle,
      rangeSelectionColor: rangeSelectionColor,
      leadingDatesTextStyle: leadingDatesTextStyle,
      disabledDatesTextStyle: disabledDatesTextStyle,
      disabledCellTextStyle: disabledCellTextStyle,
      selectionColor: selectionColor,
      selectionTextStyle: selectionTextStyle,
      startRangeSelectionColor: startRangeSelectionColor,
      endRangeSelectionColor: endRangeSelectionColor,
      headerBackgroundColor: headerBackgroundColor,
      viewHeaderBackgroundColor: viewHeaderBackgroundColor,
      blackoutDatesTextStyle: blackoutDatesTextStyle,
      todayHighlightColor: todayHighlightColor,
      todayTextStyle: todayTextStyle,
      todayCellTextStyle: todayCellTextStyle,
      weekendDatesTextStyle: weekendDatesTextStyle,
      specialDatesTextStyle: specialDatesTextStyle,
    );
  }

  /// Create a [DatePickerThemeData] given a set of exact values.
  /// All the values must be specified.
  ///
  /// This will rarely be used directly. It is used by [lerp] to
  /// create intermediate themes based on two themes created with the
  /// [DatePickerThemeData] constructor.
  const DatePickerThemeData.raw({
    required this.brightness,
    required this.backgroundColor,
    required this.viewHeaderTextStyle,
    required this.headerTextStyle,
    required this.trailingDatesTextStyle,
    required this.leadingCellTextStyle,
    required this.activeDatesTextStyle,
    required this.cellTextStyle,
    required this.rangeSelectionTextStyle,
    required this.rangeSelectionColor,
    required this.leadingDatesTextStyle,
    required this.disabledDatesTextStyle,
    required this.disabledCellTextStyle,
    required this.selectionColor,
    required this.selectionTextStyle,
    required this.startRangeSelectionColor,
    required this.endRangeSelectionColor,
    required this.headerBackgroundColor,
    required this.viewHeaderBackgroundColor,
    required this.blackoutDatesTextStyle,
    required this.todayHighlightColor,
    required this.todayTextStyle,
    required this.todayCellTextStyle,
    required this.weekendDatesTextStyle,
    required this.specialDatesTextStyle,
  });

  /// The brightness of the overall theme of the
  /// application for the date picker widget.
  ///
  /// If [brightness] is not specified, then based on the
  /// [Theme.of(context).brightness], brightness for
  /// date range picker widgets will be applied.
  ///
  /// Also refer [Brightness].
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return Scaffold(
  ///     appBar: AppBar(),
  ///     body: Center(
  ///       child: CoreTheme(
  ///         data: CoreThemeData(
  ///           dateRangePickerThemeData: DatePickerThemeData(
  ///             brightness: Brightness.light
  ///           )
  ///         ),
  ///         child: DatePicker(),
  ///       ),
  ///     )
  ///   );
  /// }
  /// ```
  final Brightness brightness;

  /// Specifies the background color of date picker widget.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return Scaffold(
  ///     appBar: AppBar(),
  ///       body: Center(
  ///         child: CoreTheme(
  ///           data: CoreThemeData(
  ///             dateRangePickerThemeData: DatePickerThemeData(
  ///               backgroundColor: Colors.grey
  ///             )
  ///           ),
  ///           child: DatePicker(),
  ///         ),
  ///       )
  ///   );
  /// }
  /// ```
  final Color backgroundColor;

  /// Specify the date picker view header text style in month view.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return Scaffold(
  ///     appBar: AppBar(),
  ///       body: Center(
  ///         child: CoreTheme(
  ///           data: CoreThemeData(
  ///             dateRangePickerThemeData: DatePickerThemeData(
  ///               viewHeaderTextStyle: TextStyle(backgroundColor:
  ///                 Colors.greenAccent)
  ///             )
  ///           ),
  ///           child: DatePicker(),
  ///         ),
  ///       )
  ///   );
  /// }
  /// ```
  final TextStyle viewHeaderTextStyle;

  /// Specify the date picker header text style.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              headerTextStyle: TextStyle(fontSize: 14)
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final TextStyle headerTextStyle;

  /// Specify the date picker trailing dates cell text style.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              trailingDatesTextStyle: TextStyle(color: Colors.red)
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final TextStyle trailingDatesTextStyle;

  /// Specify the date picker leading year, decade or century cell text style
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              leadingCellTextStyle: TextStyle(color: Colors.red,
  ///                backgroundColor: Colors.green)
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final TextStyle leadingCellTextStyle;

  /// Specify the date picker current month cells text style.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              activeDatesTextStyle: TextStyle(color: Colors.grey)
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final TextStyle activeDatesTextStyle;

  /// Specify the date picker current year, decade or century cells text style.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              cellTextStyle: TextStyle(color: Colors.blueAccent)
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final TextStyle cellTextStyle;

  /// Specify the date picker in-between selected range text style in month view when selection mode as range/multi-range selection.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              rangeSelectionTextStyle: TextStyle(decoration:
  ///                TextDecoration.lineThrough)
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final TextStyle rangeSelectionTextStyle;

  /// Specify the date picker leading dates cell text style.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              leadingDatesTextStyle: TextStyle(color: Colors.red)
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final TextStyle leadingDatesTextStyle;

  /// Specify the date picker disabled cell text style.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              disabledDatesTextStyle: TextStyle(color:Colors.tealAccent)
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final TextStyle disabledDatesTextStyle;

  /// Specify the date picker disabled year, decade or century cell text style.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              disabledCellTextStyle: TextStyle(color: Colors.yellowAccent),
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final TextStyle disabledCellTextStyle;

  /// Specify the date picker selected dates background color in
  /// month view single and multiple selection.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              selectionColor: Colors.pinkAccent
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final Color? selectionColor;

  /// Specify the date picker in-between selected range background color in month view when selection mode as range/multi-range selection.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              rangeSelectionColor: Colors.cyan
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final Color? rangeSelectionColor;

  /// Specify the date picker selected cell text style for the  single and
  /// multiple selection and also for the start and end range of single
  /// and multi-range selection.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              selectionTextStyle: TextStyle(decoration:
  ///                TextDecoration.overline)
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final TextStyle selectionTextStyle;

  /// Specify the date picker start date of selected range background color in month view when selection mode as range/multi-range selection.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              startRangeSelectionColor: Colors.green
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final Color? startRangeSelectionColor;

  /// Specify the date picker end date of selected range background color in month view when selection mode as range/multi-range selection.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              endRangeSelectionColor: Colors.green
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final Color? endRangeSelectionColor;

  /// Specify the date picker header background color.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              headerBackgroundColor: Colors.purple
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final Color headerBackgroundColor;

  /// Specify the view header background color in month view.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              viewHeaderBackgroundColor: Colors.purpleAccent
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final Color viewHeaderBackgroundColor;

  /// Specify the date picker blackout cell text style.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              blackoutDatesTextStyle: TextStyle(color:Colors.green[300])
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final TextStyle? blackoutDatesTextStyle;

  /// Specify the date picker today highlight color.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              todayHighlightColor: Colors.red
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final Color? todayHighlightColor;

  /// Specify the date picker today date month cell text style.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              todayTextStyle: TextStyle(backgroundColor: Colors.yellow)
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final TextStyle todayTextStyle;

  /// Specify the date picker today month, decade or century cell text style.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              todayCellTextStyle: TextStyle(fontWeight: FontWeight.bold)
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final TextStyle todayCellTextStyle;

  /// Specify the date picker weekend cell text style.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              weekendDatesTextStyle: TextStyle(fontWeight: FontWeight.bold,
  ///                decoration: TextDecoration.lineThrough)
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final TextStyle? weekendDatesTextStyle;

  /// Specify the date picker special dates text style in month view
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dateRangePickerThemeData: DatePickerThemeData(
  ///              specialDatesTextStyle: TextStyle(color: Colors.orange)
  ///            )
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final TextStyle specialDatesTextStyle;

  /// Creates a copy of this theme but with the given
  /// fields replaced with the new values.
  DatePickerThemeData copyWith({
    Brightness? brightness,
    TextStyle? viewHeaderTextStyle,
    Color? backgroundColor,
    TextStyle? headerTextStyle,
    TextStyle? trailingDatesTextStyle,
    TextStyle? leadingCellTextStyle,
    TextStyle? activeDatesTextStyle,
    TextStyle? cellTextStyle,
    TextStyle? rangeSelectionTextStyle,
    TextStyle? leadingDatesTextStyle,
    TextStyle? disabledDatesTextStyle,
    TextStyle? disabledCellTextStyle,
    Color? selectionColor,
    Color? rangeSelectionColor,
    TextStyle? selectionTextStyle,
    Color? startRangeSelectionColor,
    Color? endRangeSelectionColor,
    Color? headerBackgroundColor,
    Color? viewHeaderBackgroundColor,
    TextStyle? blackoutDatesTextStyle,
    Color? todayHighlightColor,
    TextStyle? todayTextStyle,
    TextStyle? todayCellTextStyle,
    TextStyle? weekendDatesTextStyle,
    TextStyle? specialDatesTextStyle,
  }) {
    return DatePickerThemeData.raw(
      brightness: brightness ?? this.brightness,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      viewHeaderTextStyle: viewHeaderTextStyle ?? this.viewHeaderTextStyle,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      trailingDatesTextStyle:
          trailingDatesTextStyle ?? this.trailingDatesTextStyle,
      leadingCellTextStyle: leadingCellTextStyle ?? this.leadingCellTextStyle,
      activeDatesTextStyle: activeDatesTextStyle ?? this.activeDatesTextStyle,
      cellTextStyle: cellTextStyle ?? this.cellTextStyle,
      rangeSelectionTextStyle:
          rangeSelectionTextStyle ?? this.rangeSelectionTextStyle,
      rangeSelectionColor: rangeSelectionColor ?? this.rangeSelectionColor,
      leadingDatesTextStyle:
          leadingDatesTextStyle ?? this.leadingDatesTextStyle,
      disabledDatesTextStyle:
          disabledDatesTextStyle ?? this.disabledDatesTextStyle,
      disabledCellTextStyle:
          disabledCellTextStyle ?? this.disabledCellTextStyle,
      selectionColor: selectionColor ?? this.selectionColor,
      selectionTextStyle: selectionTextStyle ?? this.selectionTextStyle,
      startRangeSelectionColor:
          startRangeSelectionColor ?? this.startRangeSelectionColor,
      endRangeSelectionColor:
          endRangeSelectionColor ?? this.endRangeSelectionColor,
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      viewHeaderBackgroundColor:
          viewHeaderBackgroundColor ?? this.viewHeaderBackgroundColor,
      blackoutDatesTextStyle:
          blackoutDatesTextStyle ?? this.blackoutDatesTextStyle,
      todayHighlightColor: todayHighlightColor ?? this.todayHighlightColor,
      todayTextStyle: todayTextStyle ?? this.todayTextStyle,
      todayCellTextStyle: todayCellTextStyle ?? this.todayCellTextStyle,
      weekendDatesTextStyle:
          weekendDatesTextStyle ?? this.weekendDatesTextStyle,
      specialDatesTextStyle:
          specialDatesTextStyle ?? this.specialDatesTextStyle,
    );
  }

  /// Linearly interpolate between two themes.
  static DatePickerThemeData? lerp(
      DatePickerThemeData? a, DatePickerThemeData? b, double t) {
    if (a == null && b == null) {
      return null;
    }
    return DatePickerThemeData(
      backgroundColor: Color.lerp(a!.backgroundColor, b!.backgroundColor, t),
      rangeSelectionColor:
          Color.lerp(a.rangeSelectionColor, b.rangeSelectionColor, t),
      selectionColor: Color.lerp(a.selectionColor, b.selectionColor, t),
      startRangeSelectionColor:
          Color.lerp(a.startRangeSelectionColor, b.startRangeSelectionColor, t),
      endRangeSelectionColor:
          Color.lerp(a.endRangeSelectionColor, b.endRangeSelectionColor, t),
      headerBackgroundColor:
          Color.lerp(a.headerBackgroundColor, b.headerBackgroundColor, t),
      viewHeaderBackgroundColor: Color.lerp(
          a.viewHeaderBackgroundColor, b.viewHeaderBackgroundColor, t),
      todayHighlightColor:
          Color.lerp(a.todayHighlightColor, b.todayHighlightColor, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is DatePickerThemeData &&
        other.viewHeaderTextStyle == viewHeaderTextStyle &&
        other.backgroundColor == backgroundColor &&
        other.headerTextStyle == headerTextStyle &&
        other.trailingDatesTextStyle == trailingDatesTextStyle &&
        other.leadingCellTextStyle == leadingCellTextStyle &&
        other.activeDatesTextStyle == activeDatesTextStyle &&
        other.cellTextStyle == cellTextStyle &&
        other.rangeSelectionTextStyle == rangeSelectionTextStyle &&
        other.rangeSelectionColor == rangeSelectionColor &&
        other.leadingDatesTextStyle == leadingDatesTextStyle &&
        other.disabledDatesTextStyle == disabledDatesTextStyle &&
        other.disabledCellTextStyle == disabledCellTextStyle &&
        other.selectionColor == selectionColor &&
        other.selectionTextStyle == selectionTextStyle &&
        other.startRangeSelectionColor == startRangeSelectionColor &&
        other.endRangeSelectionColor == endRangeSelectionColor &&
        other.headerBackgroundColor == headerBackgroundColor &&
        other.viewHeaderBackgroundColor == viewHeaderBackgroundColor &&
        other.blackoutDatesTextStyle == blackoutDatesTextStyle &&
        other.todayHighlightColor == todayHighlightColor &&
        other.todayTextStyle == todayTextStyle &&
        other.todayCellTextStyle == todayCellTextStyle &&
        other.weekendDatesTextStyle == weekendDatesTextStyle &&
        other.specialDatesTextStyle == specialDatesTextStyle;
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      viewHeaderTextStyle,
      backgroundColor,
      headerTextStyle,
      trailingDatesTextStyle,
      leadingCellTextStyle,
      activeDatesTextStyle,
      cellTextStyle,
      rangeSelectionTextStyle,
      rangeSelectionColor,
      leadingDatesTextStyle,
      disabledDatesTextStyle,
      disabledCellTextStyle,
      selectionColor,
      selectionTextStyle,
      startRangeSelectionColor,
      endRangeSelectionColor,
      headerBackgroundColor,
      viewHeaderBackgroundColor,
      blackoutDatesTextStyle,
      todayHighlightColor,
      todayTextStyle,
      todayCellTextStyle,
      weekendDatesTextStyle,
      specialDatesTextStyle,
    ];
    return hashList(values);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final DatePickerThemeData defaultData = DatePickerThemeData();
    properties.add(EnumProperty<Brightness>('brightness', brightness,
        defaultValue: defaultData.brightness));
    properties.add(ColorProperty('backgroundColor', backgroundColor,
        defaultValue: defaultData.backgroundColor));
    properties.add(ColorProperty('rangeSelectionColor', rangeSelectionColor,
        defaultValue: defaultData.rangeSelectionColor));
    properties.add(ColorProperty('selectionColor', selectionColor,
        defaultValue: defaultData.selectionColor));
    properties.add(ColorProperty(
        'startRangeSelectionColor', startRangeSelectionColor,
        defaultValue: defaultData.startRangeSelectionColor));
    properties.add(ColorProperty(
        'endRangeSelectionColor', endRangeSelectionColor,
        defaultValue: defaultData.endRangeSelectionColor));
    properties.add(ColorProperty('headerBackgroundColor', headerBackgroundColor,
        defaultValue: defaultData.headerBackgroundColor));
    properties.add(ColorProperty(
        'viewHeaderBackgroundColor', viewHeaderBackgroundColor,
        defaultValue: defaultData.viewHeaderBackgroundColor));
    properties.add(ColorProperty('todayHighlightColor', todayHighlightColor,
        defaultValue: defaultData.todayHighlightColor));
  }
}
