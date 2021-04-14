import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core_theme.dart';

/// Applies a theme to descendant Free Flutter barcode widgets.
///
/// To obtain the current theme, use [BarcodeTheme.of].
///
/// ```dart
/// Widget build(BuildContext context) {
///   return Scaffold(
///     body: BarcodeTheme(
///       data: BarcodeThemeData(
///         brightness: Brightness.light
///       ),
///       child: BarcodeGenerator(
///         value: 'https://flutter.dev',
///         symbology: QRCode() ,
///       )
///     ),
///   );
/// }
/// ```
///
/// See also:
///
/// * [CoreTheme](https://pub.dev/documentation/free_flutter_core/latest/theme/CoreTheme-class.html)
/// and [CoreThemeData](https://pub.dev/documentation/free_flutter_core/latest/theme/CoreThemeData-class.html),
/// for customizing the visual appearance of the barcode widgets.
///
class BarcodeTheme extends InheritedTheme {
  /// Initialize the class of BarcodeTheme
  const BarcodeTheme({Key? key, required this.data, required this.child})
      : super(key: key, child: child);

  /// Specifies the color and typography values for descendant barcode widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return Scaffold(
  ///     body: BarcodeTheme(
  ///       data: BarcodeThemeData(
  ///         brightness: Brightness.light
  ///       ),
  ///       child: SfBarcodeGenerator(
  ///         value: 'www.sycfusion.com',
  ///         symbology: QRCode() ,
  ///       )
  ///     ),
  ///   );
  /// }
  /// ```

  final BarcodeThemeData data;

  /// Specifies a widget that can hold single child.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return Scaffold(
  ///     body: BarcodeTheme(
  ///       data: BarcodeThemeData(
  ///         brightness: Brightness.light
  ///       ),
  ///       child: SfBarcodeGenerator(
  ///         value: 'www.sycfusion.com',
  ///         symbology: QRCode() ,
  ///       )
  ///     ),
  ///   );
  /// }
  /// ```
  @override
  final Widget child;

  /// The data from the closest [BarcodeTheme] instance
  /// that encloses the given context.
  ///
  /// Defaults to [BarcodeTheme.barcodeThemeData]
  /// if there is no [BarcodeTheme] in the given build context.
  static BarcodeThemeData of(BuildContext context) {
    final BarcodeTheme? barcodeTheme =
        context.dependOnInheritedWidgetOfExactType<BarcodeTheme>();
    return barcodeTheme?.data ?? CoreTheme.of(context).barcodeThemeData;
  }

  @override
  bool updateShouldNotify(BarcodeTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final BarcodeTheme? ancestorTheme =
        context.findAncestorWidgetOfExactType<BarcodeTheme>();
    return identical(this, ancestorTheme)
        ? child
        : BarcodeTheme(data: data, child: child);
  }
}

/// Holds the color and typography values for a [BarcodeTheme].
/// Applies a theme to descendant Syncfusion barcode widgets.
///
/// To obtain the current theme, use [BarcodeTheme.of].
///
/// ```dart
/// Widget build(BuildContext context) {
///   return Scaffold(
///     body: BarcodeTheme(
///       data: BarcodeThemeData(
///         brightness: Brightness.light
///       ),
///       child: BarcodeGenerator(
///         value: 'https://flutter.dev',
///         symbology: QRCode() ,
///       )
///     ),
///   );
/// }
/// ```
///
/// See also:
///
/// * [CoreTheme](https://pub.dev/documentation/free_flutter_core/latest/theme/CoreTheme-class.html)
/// and [CoreThemeData](https://pub.dev/documentation/free_flutter_core/latest/theme/CoreThemeData-class.html),
/// for customizing the visual appearance of the barcode widgets.
///
class BarcodeThemeData with Diagnosticable {
  /// Initialize the SfBarcode theme data
  factory BarcodeThemeData({
    Brightness? brightness,
    Color? backgroundColor,
    Color? barColor,
    Color? textColor,
  }) {
    brightness = brightness ?? Brightness.light;
    final bool isLight = brightness == Brightness.light;
    backgroundColor ??= Colors.transparent;
    barColor ??= isLight ? const Color(0xFF212121) : const Color(0xFFE0E0E0);
    textColor ??= isLight ? const Color(0xFF212121) : const Color(0xFFE0E0E0);

    return BarcodeThemeData.raw(
        brightness: brightness,
        backgroundColor: backgroundColor,
        barColor: barColor,
        textColor: textColor);
  }

  /// Create a [BarcodeThemeData] given a set of exact values.
  /// All the values must be specified.
  ///
  /// This will rarely be used directly. It is used by [lerp] to
  /// create intermediate themes based on two themes created with the
  /// [BarcodeThemeData] constructor.
  const BarcodeThemeData.raw({
    required this.brightness,
    required this.backgroundColor,
    required this.barColor,
    required this.textColor,
  });

  /// The brightness of the overall theme of the
  /// application for the barcode widgets.
  ///
  /// If [brightness] is not specified, then based on the
  /// [Theme.of(context).brightness], brightness for
  /// barcode widgets will be applied.
  ///
  /// Also refer [Brightness].
  ///
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            barcodeThemeData: BarcodeThemeData(
  ///              brightness: Brightness.dark
  ///              ),
  ///            ),
  ///          child: BarcodeGenerator(
  ///            value: 'https://flutter.dev,
  ///            symbology: QRCode() ,
  ///            showValue: true,
  ///          ),
  ///        ),
  ///      )
  ///   );
  ///}
  /// ```
  final Brightness brightness;

  /// Specifies the background color of barcode widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            barcodeThemeData: BarcodeThemeData(
  ///              backgroundColor: Colors.yellow
  ///              ),
  ///            ),
  ///          child: SfBarcodeGenerator(
  ///            value: 'www.sycfusion.com',
  ///            symbology: QRCode() ,
  ///            showValue: true,
  ///          ),
  ///        ),
  ///      )
  ///   );
  ///}
  /// ```
  final Color backgroundColor;

  /// Specifies the color for barcodes.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            barcodeThemeData: BarcodeThemeData(
  ///              barColor: Colors.green
  ///              ),
  ///            ),
  ///          child: SfBarcodeGenerator(
  ///            value: 'www.sycfusion.com',
  ///            symbology: QRCode() ,
  ///            showValue: true,
  ///          ),
  ///        ),
  ///      )
  ///   );
  ///}
  /// ```
  final Color barColor;

  /// Specifies the color for barcode text.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: CoreTheme(
  ///          data: CoreThemeData(
  ///            barcodeThemeData: BarcodeThemeData(
  ///              textColor: Colors.blue
  ///              ),
  ///            ),
  ///          child: SfBarcodeGenerator(
  ///            value: 'www.sycfusion.com',
  ///            symbology: QRCode() ,
  ///            showValue: true,
  ///          ),
  ///        ),
  ///      )
  ///   );
  ///}
  /// ```
  final Color textColor;

  /// Creates a copy of this barcode theme data object with the matching fields
  /// replaced with the non-null parameter values.
  BarcodeThemeData copyWith({
    Brightness? brightness,
    Color? backgroundColor,
    Color? barColor,
    Color? textColor,
  }) {
    return BarcodeThemeData.raw(
      brightness: brightness ?? this.brightness,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      barColor: barColor ?? this.barColor,
      textColor: textColor ?? this.textColor,
    );
  }

  /// Returns the barcode theme data
  static BarcodeThemeData? lerp(
      BarcodeThemeData? a, BarcodeThemeData? b, double t) {
    if (a == null && b == null) {
      return null;
    }
    return BarcodeThemeData(
      backgroundColor: Color.lerp(a!.backgroundColor, b!.backgroundColor, t),
      barColor: Color.lerp(a.barColor, b.barColor, t),
      textColor: Color.lerp(a.textColor, b.textColor, t),
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

    return other is BarcodeThemeData &&
        other.backgroundColor == backgroundColor &&
        other.barColor == barColor &&
        other.textColor == textColor;
  }

  @override
  int get hashCode {
    final List<Object> values = <Object>[backgroundColor, barColor, textColor];
    return hashList(values);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final BarcodeThemeData defaultData = BarcodeThemeData();
    properties.add(EnumProperty<Brightness>('brightness', brightness,
        defaultValue: defaultData.brightness));
    properties.add(ColorProperty('backgroundColor', backgroundColor,
        defaultValue: defaultData.backgroundColor));
    properties.add(ColorProperty('barColor', barColor,
        defaultValue: defaultData.barColor));
    properties.add(ColorProperty('textColor', textColor,
        defaultValue: defaultData.textColor));
  }
}
