import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'range_slider_theme.dart';
import 'slider_theme.dart'
    as slider; // Avoids conflicting import from Flutter Material
import 'barcodes_theme.dart';
import 'calendar_theme.dart';
import 'charts_theme.dart';
import 'data_table_theme.dart'
    as data_table; // Avoids conflicting import from Flutter Material
import 'data_paginator_theme.dart';
import 'date_picker_theme.dart';
import 'gauges_theme.dart';
import 'maps_theme.dart';
import 'pdfviewer_theme.dart';
import 'range_selector_theme.dart';

/// Applies a theme to descendant Syncfusion widgets.
///
/// If [CoreTheme] is not specified, then based on the
/// [Theme.of(context).brightness], brightness for
/// Syncfusion widgets will be applied.
///
/// ```dart
/// Widget build(BuildContext context) {
///   return Scaffold(
///     body: Center(
///       child: CoreTheme(
///         data: CoreThemeData(
///           chartThemeData: ChartThemeData(
///             backgroundColor: Colors.grey,
///             brightness: Brightness.dark
///           )
///         ),
///         child: CartesianChart(
///         )
///       ),
///     )
///   );
/// }
/// ```
class CoreTheme extends StatelessWidget {
  /// Creating an argument constructor of CoreTheme class.
  const CoreTheme({
    Key? key,
    this.data,
    required this.child,
  }) : super(key: key);

  /// Specifies a widget that can hold single child.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return Scaffold(
  ///     body: Center(
  ///       child: CoreTheme(
  ///         data: CoreThemeData(
  ///           chartThemeData: ChartThemeData(
  ///             backgroundColor: Colors.grey,
  ///             brightness: Brightness.dark
  ///           )
  ///         ),
  ///         child: CartesianChart(
  ///         )
  ///       ),
  ///     )
  ///   );
  /// }
  /// ```
  final Widget child;

  /// Specifies the color and typography values for descendant widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return Scaffold(
  ///     body: Center(
  ///       child: CoreTheme(
  ///         data: CoreThemeData(
  ///           chartThemeData: ChartThemeData(
  ///             backgroundColor: Colors.grey,
  ///             brightness: Brightness.dark
  ///           )
  ///         ),
  ///         child: CartesianChart(
  ///         )
  ///       ),
  ///     )
  ///   );
  /// }
  /// ```
  final CoreThemeData? data;

  //ignore: unused_field
  static final CoreThemeData _kFallbackTheme = CoreThemeData.fallback();

  /// The data from the closest [CoreTheme] instance that encloses the given
  /// context.
  ///
  /// Defaults to [CoreThemeData.fallback] if there is no [CoreTheme] in the given
  /// build context.
  ///
  static CoreThemeData of(BuildContext context) {
    final _CoreInheritedTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_CoreInheritedTheme>();
    return inheritedTheme?.data ??
        (Theme.of(context).brightness == Brightness.light
            ? CoreThemeData.light()
            : CoreThemeData.dark());
  }

  @override
  Widget build(BuildContext context) {
    return _CoreInheritedTheme(data: data, child: child);
  }
}

class _CoreInheritedTheme extends InheritedTheme {
  const _CoreInheritedTheme({Key? key, this.data, required Widget child})
      : super(key: key, child: child);

  final CoreThemeData? data;

  @override
  bool updateShouldNotify(_CoreInheritedTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final _CoreInheritedTheme? ancestorTheme =
        context.findAncestorWidgetOfExactType<_CoreInheritedTheme>();
    return identical(this, ancestorTheme)
        ? child
        : CoreTheme(data: data, child: child);
  }
}

/// Holds the color and typography values for light and dark themes. Use
///  this class to configure a [CoreTheme] widget.
///
/// To obtain the current theme, use [CoreTheme.of].
///
/// ```dart
/// Widget build(BuildContext context) {
///   return Scaffold(
///     body: Center(
///       child: CoreTheme(
///         data: CoreThemeData(
///           chartThemeData: ChartThemeData(
///             backgroundColor: Colors.grey,
///             brightness: Brightness.dark
///           )
///         ),
///         child: CartesianChart(
///         )
///       ),
///     )
///   );
/// }
/// ```
class CoreThemeData with Diagnosticable {
  /// Creating an argument constructor of CoreThemeData class.
  factory CoreThemeData(
      {Brightness? brightness,
      PdfViewerThemeData? pdfViewerThemeData,
      ChartThemeData? chartThemeData,
      CalendarThemeData? calendarThemeData,
      data_table.DataTableThemeData? dataTableThemeData,
      DataPaginatorThemeData? dataPaginatorThemeData,
      DatePickerThemeData? datePickerThemeData,
      BarcodeThemeData? barcodeThemeData,
      GaugeThemeData? gaugeThemeData,
      slider.SliderThemeData? sliderThemeData,
      RangeSliderThemeData? rangeSliderThemeData,
      RangeSelectorThemeData? rangeSelectorThemeData,
      MapThemeData? mapThemeData}) {
    brightness ??= Brightness.light;
    pdfViewerThemeData =
        pdfViewerThemeData ?? PdfViewerThemeData(brightness: brightness);
    chartThemeData = chartThemeData ?? ChartThemeData(brightness: brightness);
    calendarThemeData =
        calendarThemeData ?? CalendarThemeData(brightness: brightness);
    dataTableThemeData = dataTableThemeData ??
        data_table.DataTableThemeData(brightness: brightness);
    datePickerThemeData =
        datePickerThemeData ?? DatePickerThemeData(brightness: brightness);
    barcodeThemeData =
        barcodeThemeData ?? BarcodeThemeData(brightness: brightness);
    gaugeThemeData = gaugeThemeData ?? GaugeThemeData(brightness: brightness);
    sliderThemeData =
        sliderThemeData ?? slider.SliderThemeData(brightness: brightness);
    rangeSelectorThemeData = rangeSelectorThemeData ??
        RangeSelectorThemeData(brightness: brightness);
    rangeSliderThemeData =
        rangeSliderThemeData ?? RangeSliderThemeData(brightness: brightness);
    mapThemeData = mapThemeData ?? MapThemeData(brightness: brightness);
    dataPaginatorThemeData = dataPaginatorThemeData ??
        DataPaginatorThemeData(brightness: brightness);
    return CoreThemeData.raw(
        brightness: brightness,
        pdfViewerThemeData: pdfViewerThemeData,
        chartThemeData: chartThemeData,
        calendarThemeData: calendarThemeData,
        dataTableThemeData: dataTableThemeData,
        dataPaginatorThemeData: dataPaginatorThemeData,
        datePickerThemeData: datePickerThemeData,
        barcodeThemeData: barcodeThemeData,
        gaugeThemeData: gaugeThemeData,
        sliderThemeData: sliderThemeData,
        rangeSelectorThemeData: rangeSelectorThemeData,
        rangeSliderThemeData: rangeSliderThemeData,
        mapThemeData: mapThemeData);
  }

  /// Create a [CoreThemeData] given a set of exact values. All the values must be
  /// specified.
  ///
  /// This will rarely be used directly. It is used by [lerp] to
  /// create intermediate themes based on two themes created with the
  /// [CoreThemeData] constructor.
  ///
  const CoreThemeData.raw(
      {required this.brightness,
      required this.pdfViewerThemeData,
      required this.chartThemeData,
      required this.calendarThemeData,
      required this.dataTableThemeData,
      required this.datePickerThemeData,
      required this.barcodeThemeData,
      required this.gaugeThemeData,
      required this.sliderThemeData,
      required this.rangeSelectorThemeData,
      required this.rangeSliderThemeData,
      required this.mapThemeData,
      required this.dataPaginatorThemeData});

  /// This method returns the light theme when no theme has been specified.
  factory CoreThemeData.light() => CoreThemeData(brightness: Brightness.light);

  /// This method is used to return the dark theme.
  factory CoreThemeData.dark() => CoreThemeData(brightness: Brightness.dark);

  /// The default color theme. Same as [CoreThemeData.light].
  ///
  /// This is used by [CoreTheme.of] when no theme has been specified.
  factory CoreThemeData.fallback() => CoreThemeData.light();

  /// The brightness of the overall theme of the
  /// application for the Syncusion widgets.
  ///
  /// If [brightness] is not specified, then based on the
  /// [Theme.of(context).brightness], brightness for
  /// Syncfusion widgets will be applied.
  ///
  /// Also refer [Brightness].
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            brightness: Brightness.dark
  ///          ),
  ///          child: CartesianChart(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final Brightness brightness;

  /// Defines the default configuration of [SfPdfViewer] widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            pdfViewerThemeData: PdfViewerThemeData()
  ///          ),
  ///      child: SfPdfViewer.asset(
  ///           'assets/flutter-succinctly.pdf',
  ///         ),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final PdfViewerThemeData pdfViewerThemeData;

  /// Defines the default configuration of chart widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            chartThemeData: ChartThemeData()
  ///          ),
  ///          child: CartesianChart(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final ChartThemeData chartThemeData;

  /// Defines the default configuration of datagrid widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            dataTableThemeData: data_table.DataTableThemeData()
  ///          ),
  ///          child: SfDataGrid(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final data_table.DataTableThemeData dataTableThemeData;

  /// Defines the default configuration of datepicker widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            datePickerThemeData: DatePickerThemeData()
  ///          ),
  ///          child: DatePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final DatePickerThemeData datePickerThemeData;

  /// Defines the default configuration of calendar widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            calendarThemeData: CalendarThemeData()
  ///          ),
  ///          child: SfCalendar(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final CalendarThemeData calendarThemeData;

  /// Defines the default configuration of barcode widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            barcodeThemeData: BarcodeThemeData()
  ///          ),
  ///          child: SfBarcodeGenerator(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final BarcodeThemeData barcodeThemeData;

  /// Defines the default configuration of gauge widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            gaugeThemeData: GaugeThemeData()
  ///          ),
  ///          child: SfRadialGauge(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final GaugeThemeData gaugeThemeData;

  /// Defines the default configuration of range selector widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            rangeSelectorThemeData: RangeSelectorThemeData()
  ///          ),
  ///          child: SfRangeSelector(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final RangeSelectorThemeData rangeSelectorThemeData;

  /// Defines the default configuration of range slider widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            rangeSliderThemeData: RangeSliderThemeData()
  ///          ),
  ///          child: SfRangeSlider(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final RangeSliderThemeData rangeSliderThemeData;

  /// Defines the default configuration of slider widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            sliderThemeData: slider.SliderThemeData()
  ///          ),
  ///          child: SfSlider(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final slider.SliderThemeData sliderThemeData;

  /// Defines the default configuration of maps widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            mapThemeData: MapThemeData()
  ///          ),
  ///          child: SfMaps(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final MapThemeData mapThemeData;

  ///ToDO
  final DataPaginatorThemeData dataPaginatorThemeData;

  /// Creates a copy of this theme but with the given
  /// fields replaced with the new values.
  CoreThemeData copyWith(
      {Brightness? brightness,
      PdfViewerThemeData? pdfViewerThemeData,
      ChartThemeData? chartThemeData,
      CalendarThemeData? calendarThemeData,
      data_table.DataTableThemeData? dataTableThemeData,
      DatePickerThemeData? datePickerThemeData,
      BarcodeThemeData? barcodeThemeData,
      GaugeThemeData? gaugeThemeData,
      slider.SliderThemeData? sliderThemeData,
      RangeSelectorThemeData? rangeSelectorThemeData,
      RangeSliderThemeData? rangeSliderThemeData,
      MapThemeData? mapThemeData,
      DataPaginatorThemeData? dataPaginatorThemeData}) {
    return CoreThemeData.raw(
        brightness: brightness ?? this.brightness,
        pdfViewerThemeData: pdfViewerThemeData ?? this.pdfViewerThemeData,
        chartThemeData: chartThemeData ?? this.chartThemeData,
        calendarThemeData: calendarThemeData ?? this.calendarThemeData,
        dataTableThemeData: dataTableThemeData ?? this.dataTableThemeData,
        dataPaginatorThemeData:
            dataPaginatorThemeData ?? this.dataPaginatorThemeData,
        datePickerThemeData: datePickerThemeData ?? this.datePickerThemeData,
        barcodeThemeData: barcodeThemeData ?? this.barcodeThemeData,
        gaugeThemeData: gaugeThemeData ?? this.gaugeThemeData,
        sliderThemeData: sliderThemeData ?? this.sliderThemeData,
        rangeSelectorThemeData:
            rangeSelectorThemeData ?? this.rangeSelectorThemeData,
        rangeSliderThemeData: rangeSliderThemeData ?? this.rangeSliderThemeData,
        mapThemeData: mapThemeData ?? this.mapThemeData);
  }

  /// Linearly interpolate between two themes.
  static CoreThemeData lerp(CoreThemeData? a, CoreThemeData? b, double t) {
    assert(a != null);
    assert(b != null);

    return CoreThemeData.raw(
        brightness: t < 0.5 ? a!.brightness : b!.brightness,
        pdfViewerThemeData: PdfViewerThemeData.lerp(
            a!.pdfViewerThemeData, b!.pdfViewerThemeData, t)!,
        chartThemeData:
            ChartThemeData.lerp(a.chartThemeData, b.chartThemeData, t)!,
        calendarThemeData: CalendarThemeData.lerp(
            a.calendarThemeData, b.calendarThemeData, t)!,
        dataTableThemeData: data_table.DataTableThemeData.lerp(
            a.dataTableThemeData, b.dataTableThemeData, t)!,
        dataPaginatorThemeData: DataPaginatorThemeData.lerp(
            a.dataPaginatorThemeData, b.dataPaginatorThemeData, t)!,
        datePickerThemeData: DatePickerThemeData.lerp(
            a.datePickerThemeData, b.datePickerThemeData, t)!,
        barcodeThemeData:
            BarcodeThemeData.lerp(a.barcodeThemeData, b.barcodeThemeData, t)!,
        gaugeThemeData:
            GaugeThemeData.lerp(a.gaugeThemeData, b.gaugeThemeData, t)!,
        sliderThemeData: slider.SliderThemeData.lerp(
            a.sliderThemeData, b.sliderThemeData, t)!,
        rangeSelectorThemeData: RangeSelectorThemeData.lerp(
            a.rangeSelectorThemeData, b.rangeSelectorThemeData, t)!,
        rangeSliderThemeData: RangeSliderThemeData.lerp(
            a.rangeSliderThemeData, b.rangeSliderThemeData, t)!,
        mapThemeData: MapThemeData.lerp(a.mapThemeData, b.mapThemeData, t)!);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is CoreThemeData &&
        other.brightness == brightness &&
        other.pdfViewerThemeData == pdfViewerThemeData &&
        other.chartThemeData == chartThemeData &&
        other.calendarThemeData == calendarThemeData &&
        other.dataTableThemeData == dataTableThemeData &&
        other.dataPaginatorThemeData == dataPaginatorThemeData &&
        other.datePickerThemeData == datePickerThemeData &&
        other.barcodeThemeData == barcodeThemeData &&
        other.gaugeThemeData == gaugeThemeData &&
        other.sliderThemeData == sliderThemeData &&
        other.rangeSelectorThemeData == rangeSelectorThemeData &&
        other.rangeSliderThemeData == rangeSliderThemeData &&
        other.mapThemeData == mapThemeData;
  }

  @override
  int get hashCode {
    final List<Object> values = <Object>[
      brightness,
      pdfViewerThemeData,
      chartThemeData,
      calendarThemeData,
      dataTableThemeData,
      dataPaginatorThemeData,
      datePickerThemeData,
      barcodeThemeData,
      gaugeThemeData,
      sliderThemeData,
      rangeSelectorThemeData,
      rangeSliderThemeData,
      mapThemeData
    ];
    return hashList(values);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final CoreThemeData defaultData = CoreThemeData.fallback();
    properties.add(EnumProperty<Brightness>('brightness', brightness,
        defaultValue: defaultData.brightness));
    properties.add(DiagnosticsProperty<PdfViewerThemeData>(
        'pdfViewerThemeData', pdfViewerThemeData,
        defaultValue: defaultData.pdfViewerThemeData));
    properties.add(DiagnosticsProperty<ChartThemeData>(
        'chartThemeData', chartThemeData,
        defaultValue: defaultData.chartThemeData));
    properties.add(DiagnosticsProperty<CalendarThemeData>(
        'calendarThemeData', calendarThemeData,
        defaultValue: defaultData.calendarThemeData));
    properties.add(DiagnosticsProperty<data_table.DataTableThemeData>(
        'dataTableThemeData', dataTableThemeData,
        defaultValue: defaultData.dataTableThemeData));
    properties.add(DiagnosticsProperty<DataPaginatorThemeData>(
        'dataPaginatorThemeData', dataPaginatorThemeData,
        defaultValue: defaultData.dataPaginatorThemeData));
    properties.add(DiagnosticsProperty<DatePickerThemeData>(
        'datePickerThemeData', datePickerThemeData,
        defaultValue: defaultData.datePickerThemeData));
    properties.add(DiagnosticsProperty<BarcodeThemeData>(
        'barcodeThemeData', barcodeThemeData,
        defaultValue: defaultData.barcodeThemeData));
    properties.add(DiagnosticsProperty<GaugeThemeData>(
        'gaugeThemeData', gaugeThemeData,
        defaultValue: defaultData.gaugeThemeData));
    properties.add(DiagnosticsProperty<RangeSelectorThemeData>(
        'rangeSelectorThemeData', rangeSelectorThemeData,
        defaultValue: defaultData.rangeSelectorThemeData));
    properties.add(DiagnosticsProperty<RangeSliderThemeData>(
        'rangeSliderThemeData', rangeSliderThemeData,
        defaultValue: defaultData.rangeSliderThemeData));
    properties.add(DiagnosticsProperty<slider.SliderThemeData>(
        'sliderThemeData', sliderThemeData,
        defaultValue: defaultData.sliderThemeData));
    properties.add(DiagnosticsProperty<MapThemeData>(
        'mapThemeData', mapThemeData,
        defaultValue: defaultData.mapThemeData));
  }
}
