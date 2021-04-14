import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:free_flutter_pdf/pdf.dart';
import 'package:free_flutter_pdfviewer/src/control/pdftextline.dart';

/// TextSelectionHelper for storing information of text selection.
class TextSelectionHelper {
  /// It will be true,if text selection is started.
  bool selectionEnabled = false;

  /// It will be true,if mouse pointer text selection for web is started.
  bool mouseSelectionEnabled = false;

  /// Glyph which is first at selected text of the selection.
  TextGlyph? firstSelectedGlyph;

  /// Page number in which text selection is started.
  int? viewId;

  /// Cursor page number in which mouse hover is happening.
  int? cursorPageNumber;

  /// Represents the global region of text selection.
  Rect? globalSelectedRegion;

  /// Copied text of text selection.
  String? copiedText;

  /// X position of start bubble.
  double? startBubbleX;

  /// Y position of start bubble.
  double? startBubbleY;

  /// X position of end bubble.
  double? endBubbleX;

  /// Y position of end bubble.
  double? endBubbleY;

  /// heightPercentage of pdf page
  double? heightPercentage;

  /// TextLine from Pdf library.
  List<TextLine>? textLines;

  /// TextLine from Pdf library used while mouse cursor hovering.
  List<TextLine>? cursorTextLines;

  /// Line of the start bubble.
  TextLine? startBubbleLine;

  /// Line of the end bubble.
  TextLine? endBubbleLine;

  /// Entry history of text selection
  LocalHistoryEntry? historyEntry;

  /// Checks whether the cursor is in viewport or not.
  bool isCursorExit = false;

  /// Checks whether the cursor reached top of the viewport or not.
  bool isCursorReachedTop = false;

  /// Initial scroll offset before scrolling while selection perform.
  double initialScrollOffset = 0;

  /// Final scroll offset after scrolling while selection perform.
  double finalScrollOffset = 0;

  /// Checks whether the tap selection is enabled or not.
  bool enableTapSelection = false;

  /// Gets the selected text lines.
  List<PdfTextLine> selectedTextLines = <PdfTextLine>[];
}

/// Determines different page navigation.
enum Navigation {
  /// Performs page navigation to specific page
  jumpToPage,

  /// Navigates to first page
  firstPage,

  /// Navigates to next page
  nextPage,

  /// Navigates to last page
  lastPage,

  /// Navigates to previous page
  previousPage
}
