part of pdf;

class _PdfAutomaticFieldInfo {
  // constructor
  _PdfAutomaticFieldInfo(PdfAutomaticField field,
      [_Point? location, double scalingX = 1, double scalingY = 1]) {
    this.field = field;
    this.location = location != null ? location : _Point.empty;
    scalingX = scalingX;
    scalingY = scalingY;
  }

  double scalingX = 1;
  double scalingY = 1;
  late PdfAutomaticField field;
  late _Point location;
}

class _PdfAutomaticFieldInfoCollection extends PdfObjectCollection {
  // constructor
  _PdfAutomaticFieldInfoCollection() : super();

  // implementaion
  int add(_PdfAutomaticFieldInfo fieldInfo) {
    _list.add(fieldInfo);
    return count - 1;
  }
}
