import 'package:flutter/material.dart';
import 'package:free_flutter_core/theme.dart';
import 'package:free_flutter_core/localizations.dart';

/// Height of the bookmark header bar.
const double _kPdfHeaderBarHeight = 53.0;

/// Height of the header text.
const double _kPdfHeaderTextHeight = 18.0;

/// Height of the close icon.
const double _kPdfCloseIconHeight = 24.0;

/// Width of the close icon.
const double _kPdfCloseIconWidth = 24.0;

/// Size of the close icon.
const double _kPdfCloseIconSize = 24.0;

/// Top position of the header text.
const double _kPdfHeaderTextTopPosition = 17.0;

/// Left position of the header text.
const double _kPdfHeaderTextLeftPosition = 16.0;

/// Top position of the close icon.
const double _kPdfCloseIconTopPosition = 14.0;

/// Right position of the close icon.
const double _kPdfCloseIconRightPosition = 16.0;

/// A material design bookmark toolbar.
class BookmarkToolbar extends StatefulWidget {
  /// Creates a material design bookmark toolbar.
  BookmarkToolbar(this.onCloseButtonPressed);

  /// A tap with a close button is occurred.
  ///
  /// This triggers when close button in bookmark toolbar is tapped.
  final GestureTapCallback onCloseButtonPressed;

  @override
  State<StatefulWidget> createState() => _BookmarkToolbarState();
}

/// State for [BookmarkToolbar]
class _BookmarkToolbarState extends State<BookmarkToolbar> {
  SfPdfViewerThemeData? _pdfViewerThemeData;
  SfLocalizations? _localizations;

  @override
  void didChangeDependencies() {
    _pdfViewerThemeData = SfPdfViewerTheme.of(context);
    _localizations = SfLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pdfViewerThemeData = null;
    _localizations = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kPdfHeaderBarHeight,
      margin: EdgeInsets.only(bottom: 3),
      decoration: BoxDecoration(
        color: _pdfViewerThemeData!.bookmarkViewStyle.headerBarColor,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.14),
            blurRadius: 2,
            offset: Offset(0, 0),
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.12),
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: _kPdfHeaderTextTopPosition,
            left: _kPdfHeaderTextLeftPosition,
            height: _kPdfHeaderTextHeight,
            child: Text(
              _localizations!.pdfBookmarksLabel,
              style: _pdfViewerThemeData!.bookmarkViewStyle.headerTextStyle,
            ),
          ),
          Positioned(
            top: _kPdfCloseIconTopPosition,
            right: _kPdfCloseIconRightPosition,
            height: _kPdfCloseIconHeight,
            width: _kPdfCloseIconWidth,
            child: RawMaterialButton(
              onPressed: () {
                widget.onCloseButtonPressed();
              },
              child: Icon(
                Icons.close,
                size: _kPdfCloseIconSize,
                color: _pdfViewerThemeData!.bookmarkViewStyle.closeIconColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
