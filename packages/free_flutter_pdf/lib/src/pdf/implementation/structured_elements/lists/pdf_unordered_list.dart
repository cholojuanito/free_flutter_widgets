part of pdf;

/// Represents the ordered list.
///
/// ```dart
/// //Create a new PDF document.
/// PdfDocument document = PdfDocument();
/// //Create a new unordered list.
/// PdfUnorderedList(
///     items: PdfListItemCollection(['Essential tools', 'Essential grid']),
///     font: PdfStandardFont(PdfFontFamily.helvetica, 16,
///         style: PdfFontStyle.italic),
///     marker: PdfUnorderedMarker(style: PdfUnorderedMarkerStyle.disk),
///     format: PdfStringFormat(lineSpacing: 20),
///     indent: 15,
///     textIndent: 10)
///   ..draw(
///       page: document.pages.add(), bounds: const Rect.fromLTWH(20, 20, 0, 0));
/// //Save the document.
/// final List<int> bytes = document.save();
/// //Dispose the document.
/// document.dispose();
/// ```
class PdfUnorderedList extends PdfList {
  //Constructor
  /// Initializes a new instance of the [PdfUnorderedList] class.
  ///
  /// ```dart
  /// //Create a new PDF document.
  /// PdfDocument document = PdfDocument();
  /// //Create a new unordered list.
  /// PdfUnorderedList(
  ///     items: PdfListItemCollection(['Essential tools', 'Essential grid']),
  ///     font: PdfStandardFont(PdfFontFamily.helvetica, 16,
  ///         style: PdfFontStyle.italic),
  ///     marker: PdfUnorderedMarker(style: PdfUnorderedMarkerStyle.disk),
  ///     format: PdfStringFormat(lineSpacing: 20),
  ///     indent: 15,
  ///     textIndent: 10)
  ///   ..draw(
  ///       page: document.pages.add(), bounds: const Rect.fromLTWH(20, 20, 0, 0));
  /// //Save the document.
  /// final List<int> bytes = document.save();
  /// //Dispose the document.
  /// document.dispose();
  /// ```
  PdfUnorderedList(
      {PdfUnorderedMarker? marker,
      PdfListItemCollection? items,
      String? text,
      PdfFont? font,
      PdfUnorderedMarkerStyle style = PdfUnorderedMarkerStyle.disk,
      PdfStringFormat? format,
      double indent = 10,
      double textIndent = 5})
      : super() {
    this.marker = marker ?? _createMarker(style);
    stringFormat = format;
    super.indent = indent;
    super.textIndent = textIndent;
    if (font != null) {
      _font = font;
    }
    if (items != null) {
      _items = items;
    } else if (text != null) {
      _items = PdfList._createItems(text);
    }
  }

  //Properties
  /// Gets or gets the marker.
  ///
  /// ```dart
  /// //Create a new PDF document.
  /// PdfDocument document = PdfDocument();
  /// //Create a new unordered list.
  /// PdfUnorderedList(
  ///     items: PdfListItemCollection(['Essential tools', 'Essential grid']),
  ///     font: PdfStandardFont(PdfFontFamily.helvetica, 16,
  ///         style: PdfFontStyle.italic),
  ///     marker: PdfUnorderedMarker(style: PdfUnorderedMarkerStyle.disk),
  ///     format: PdfStringFormat(lineSpacing: 20),
  ///     indent: 15,
  ///     textIndent: 10)
  ///   ..draw(
  ///       page: document.pages.add(), bounds: const Rect.fromLTWH(20, 20, 0, 0));
  /// //Save the document.
  /// final List<int> bytes = document.save();
  /// //Dispose the document.
  /// document.dispose();
  /// ```
  late PdfUnorderedMarker marker;

  //Static methods
  //Creates the marker.
  static PdfUnorderedMarker _createMarker(PdfUnorderedMarkerStyle style) {
    return PdfUnorderedMarker(style: style);
  }
}
