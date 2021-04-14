import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart'
    show
        DragStartBehavior,
        GestureArenaTeam,
        HorizontalDragGestureRecognizer,
        TapGestureRecognizer,
        VerticalDragGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../linear_gauge/axis/linear_axis_renderer.dart';
import '../../linear_gauge/pointers/linear_bar_renderer.dart';
import '../../linear_gauge/pointers/linear_shape_renderer.dart';
import '../../linear_gauge/pointers/linear_widget_renderer.dart';
import '../../linear_gauge/range/linear_gauge_range_renderer.dart';
import '../../linear_gauge/utils/enum.dart';
import '../../linear_gauge/utils/linear_gauge_helper.dart';

/// Default widget height.
/// This value is used when the parent layout height is infinite for the linear gauge.
const double kDefaultLinearGaugeHeight = 400.0;

/// Default widget width.
/// This value is used when the parent layout width is infinite for the linear gauge.
const double kDefaultLinearGaugeWidth = 300.0;

/// Linear gauge render widget class.
class LinearGaugeRenderWidget extends MultiChildRenderObjectWidget {
  /// Creates instance for [LinearGaugeRenderWidget] class.
  LinearGaugeRenderWidget(
      {Key? key,
      required this.pointerAnimations,
      required List<Widget> children})
      : super(key: key, children: children);

  /// Linear gauge pointer animations.
  final List<Animation<double>> pointerAnimations;

  RenderObject createRenderObject(BuildContext context) =>
      RenderLinearGauge(pointerAnimations: pointerAnimations);

  @override
  void updateRenderObject(
      BuildContext context, RenderLinearGauge renderObject) {
    renderObject..pointerAnimations = pointerAnimations;
    super.updateRenderObject(context, renderObject);
  }

  @override
  MultiChildRenderObjectElement createElement() =>
      LinearGaugeRenderElement(this);
}

/// Linear gauge render widget element class.
class LinearGaugeRenderElement extends MultiChildRenderObjectElement {
  /// Creates a instance for Linear gauge render widget element class.
  LinearGaugeRenderElement(MultiChildRenderObjectWidget widget) : super(widget);

  @override
  // ignore: avoid_as
  RenderLinearGauge get renderObject => super.renderObject as RenderLinearGauge;

  @override
  void insertRenderObjectChild(RenderObject child, IndexedSlot<Element?> slot) {
    super.insertRenderObjectChild(child, slot);
    if (child is RenderLinearRange) {
      renderObject.addRange(child);
    } else if (child is RenderLinearAxis) {
      renderObject.axis = child;
    } else if (child is RenderLinearBarPointer) {
      renderObject.addBarPointer(child);
    } else if (child is RenderLinearShapePointer) {
      renderObject.addShapePointer(child);
    } else if (child is RenderLinearWidgetPointer) {
      renderObject.addWidgetPointer(child);
    }
  }

  @override
  void moveRenderObjectChild(RenderObject child, IndexedSlot<Element?> oldSlot,
      IndexedSlot<Element?> newSlot) {
    super.moveRenderObjectChild(child, oldSlot, newSlot);
  }

  @override
  void removeRenderObjectChild(RenderObject child, dynamic slot) {
    super.removeRenderObjectChild(child, slot);
    if (child is RenderLinearRange) {
      renderObject.removeRange(child);
    } else if (child is RenderLinearAxis) {
      renderObject.axis = null;
    } else if (child is RenderLinearBarPointer) {
      renderObject.removeBarPointer(child);
    } else if (child is RenderLinearShapePointer) {
      renderObject.removeShapePointer(child);
    } else if (child is RenderLinearWidgetPointer) {
      renderObject.removeWidgetPointer(child);
    }
  }
}

/// Linear gauge render object class.
class RenderLinearGauge extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, MultiChildLayoutParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, MultiChildLayoutParentData>,
        DebugOverflowIndicatorMixin {
  /// Creates a render object.
  ///
  /// By default, the non-positioned children of the stack are aligned by their
  /// top left corners.
  RenderLinearGauge({required List<Animation<double>> pointerAnimations})
      : _gestureArenaTeam = GestureArenaTeam(),
        _pointerAnimations = pointerAnimations {
    _ranges = <RenderLinearRange>[];
    _barPointers = <RenderLinearBarPointer>[];
    _shapePointers = <RenderLinearShapePointer>[];
    _widgetPointers = <RenderLinearWidgetPointer>[];
    _markerPointers = <RenderBox>[];
    _verticalDragGestureRecognizer = VerticalDragGestureRecognizer()
      ..team = _gestureArenaTeam
      ..onStart = _handleDragStart
      ..onUpdate = _handleDragUpdate
      ..dragStartBehavior = DragStartBehavior.start;

    _horizontalDragGestureRecognizer = HorizontalDragGestureRecognizer()
      ..team = _gestureArenaTeam
      ..onStart = _handleDragStart
      ..onUpdate = _handleDragUpdate
      ..dragStartBehavior = DragStartBehavior.start;

    _tapGestureRecognizer = TapGestureRecognizer()..onTapDown = _handleTapDown;
  }

  final GestureArenaTeam _gestureArenaTeam;

  late TapGestureRecognizer _tapGestureRecognizer;
  late VerticalDragGestureRecognizer _verticalDragGestureRecognizer;
  late HorizontalDragGestureRecognizer _horizontalDragGestureRecognizer;

  double _axisLineActualSize = 0,
      _axisTop = 0,
      _axisWidgetThickness = 0,
      _insideWidgetElementSize = 0,
      _outsideWidgetElementSize = 0,
      _pointerStartPadding = 0,
      _pointerEndPadding = 0,
      _pointX = 0,
      _pointY = 0;

  double? _actualSizeDelta, _overflow;

  bool _isAxisInversed = false;
  bool _isHorizontalOrientation = true;
  bool _isMarkerPointerInteraction = false;
  bool _restrictHitTestPointerChange = false;

  late List<RenderLinearBarPointer> _barPointers;
  late List<RenderLinearShapePointer> _shapePointers;
  late List<RenderLinearWidgetPointer> _widgetPointers;
  late List<RenderLinearRange> _ranges;
  late List<RenderBox> _markerPointers;

  late BoxConstraints _parentConstraints;
  late BoxConstraints _childConstraints;

  late dynamic _markerRenderObject;

  /// Gets the axis assigned to [_RenderLinearGaugeRenderObject].
  RenderLinearAxis? get axis => _axis;
  RenderLinearAxis? _axis;

  /// Sets the axis for [_RenderLinearGaugeRenderObject].
  set axis(RenderLinearAxis? value) {
    if (value == _axis) {
      return;
    }

    _axis = value;
    _updateAxis();
    markNeedsLayout();
  }

  /// Gets the pointer animations assigned to [_RenderLinearGaugeRenderObject].
  List<Animation<double>> get pointerAnimations => _pointerAnimations;
  List<Animation<double>> _pointerAnimations;

  /// Sets the pointer animations for [_RenderLinearGaugeRenderObject].
  set pointerAnimations(List<Animation<double>> value) {
    if (value == _pointerAnimations) {
      return;
    }

    _removePointerAnimationListeners();
    _pointerAnimations = value;
    _addPointerAnimationListeners();
    markNeedsLayout();
  }

  /// Adds the range render object to range collection.
  void addRange(RenderLinearRange range) {
    _ranges.add(range..axis = axis);
    markNeedsLayout();
  }

  /// Removes the range render object from range collection.
  void removeRange(RenderLinearRange range) {
    _ranges.remove(range..axis = null);
    markNeedsLayout();
  }

  /// Adds the bar render object to bar pointer collection.
  void addBarPointer(RenderLinearBarPointer barPointer) {
    _barPointers.add(barPointer..axis = axis);
    markNeedsLayout();
  }

  /// Removes the bar render object from bar pointer collection.
  void removeBarPointer(RenderLinearBarPointer barPointer) {
    _barPointers.remove(barPointer..axis = null);
    markNeedsLayout();
  }

  /// Adds the shape render object to bar pointer collection.
  void addShapePointer(RenderLinearShapePointer shapePointer) {
    _shapePointers.add(shapePointer);
    markNeedsLayout();
  }

  /// Removes the shape render object from bar pointer collection.
  void removeShapePointer(RenderLinearShapePointer shapePointer) {
    _shapePointers.remove(shapePointer);
    markNeedsLayout();
  }

  /// Adds the widget render object to widget pointer collection.
  void addWidgetPointer(RenderLinearWidgetPointer shapePointer) {
    _widgetPointers.add(shapePointer);
    markNeedsLayout();
  }

  /// Removes the widget render object from widget pointer collection.
  void removeWidgetPointer(RenderLinearWidgetPointer shapePointer) {
    _widgetPointers.remove(shapePointer..pointerAnimation = null);
    markNeedsLayout();
  }

  void _updateAxis() {
    _ranges.forEach((element) {
      element..axis = axis;
    });

    _barPointers.forEach((element) {
      element..axis = axis;
    });

    if (axis != null) {
      _isHorizontalOrientation =
          _axis!.orientation == LinearGaugeOrientation.horizontal;
    }
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! MultiChildLayoutParentData) {
      child.parentData = MultiChildLayoutParentData();
    }
  }

  /// Measures the inside elements size.
  void _measureInsideElementSize(double thickness) {
    final double labelSize = axis!.getEffectiveLabelSize();
    final double tickSize = axis!.getTickSize();
    final double axisLineSize = axis!.getAxisLineThickness();
    final position = LinearGaugeHelper.getEffectiveElementPosition(
        axis!.tickPosition, axis!.isMirrored);
    final labelPosition = LinearGaugeHelper.getEffectiveLabelPosition(
        axis!.labelPosition, axis!.isMirrored);
    final bool isInsideLabel = labelPosition == LinearLabelPosition.inside;

    late double _insideElementSize;

    switch (position) {
      case LinearElementPosition.inside:
        if (isInsideLabel) {
          _insideElementSize = (_axisWidgetThickness - axisLineSize) > thickness
              ? 0
              : thickness - (_axisWidgetThickness - axisLineSize);
        } else {
          _insideElementSize = thickness - tickSize;
        }
        break;
      case LinearElementPosition.outside:
        if (isInsideLabel) {
          _insideElementSize = thickness - labelSize;
        } else {
          _insideElementSize = thickness;
        }
        break;
      case LinearElementPosition.cross:
        if (isInsideLabel) {
          _insideElementSize = (_axisWidgetThickness - axisLineSize) > thickness
              ? 0
              : thickness - (_axisWidgetThickness - axisLineSize);
        } else {
          _insideElementSize = (axis!.showLabels ? thickness : 0) -
              (axisLineSize < tickSize ? (tickSize - axisLineSize) / 2 : 0);
        }
        break;
      default:
        break;
    }

    _insideWidgetElementSize =
        math.max(_insideWidgetElementSize, _insideElementSize);
  }

  void _updateInsideElementSize(double thickness) {
    if (!axis!.showTicks && !axis!.showLabels) {
      _insideWidgetElementSize = math.max(thickness, _insideWidgetElementSize);
    } else if (thickness > _axisWidgetThickness) {
      _insideWidgetElementSize =
          math.max(thickness - _axisWidgetThickness, _insideWidgetElementSize);
    }
  }

  /// Measure the parent size based on cross element.
  void _measureCrossElementSize(double thickness) {
    final double labelSize = axis!.getEffectiveLabelSize();
    final double tickSize = axis!.getTickSize();
    final double axisSize = axis!.getAxisLineThickness();
    final position = LinearGaugeHelper.getEffectiveElementPosition(
        axis!.tickPosition, axis!.isMirrored);
    final labelPlacement = LinearGaugeHelper.getEffectiveLabelPosition(
        axis!.labelPosition, axis!.isMirrored);
    final bool isInsideLabel = labelPlacement == LinearLabelPosition.inside;

    switch (position) {
      case LinearElementPosition.inside:
        if (axisSize == 0) {
          _updateInsideElementSize(thickness);
        } else if (axisSize < thickness) {
          final double sizeDifference =
              (thickness - axisSize) / 2 - (isInsideLabel ? 0 : labelSize);
          _outsideWidgetElementSize =
              math.max(sizeDifference, _outsideWidgetElementSize);

          if (_axisWidgetThickness < thickness) {
            double axisSizeDifference = (thickness - axisSize) / 2;
            axisSizeDifference = axisSizeDifference -
                (tickSize + (isInsideLabel ? labelSize : 0));
            _insideWidgetElementSize =
                math.max(axisSizeDifference, _insideWidgetElementSize);
          }
        }
        break;
      case LinearElementPosition.outside:
        if (axisSize == 0) {
          _updateInsideElementSize(thickness);
        } else if (axisSize < thickness) {
          final double sizeDifference = (thickness - axisSize) / 2 -
              (tickSize + (isInsideLabel ? 0 : labelSize));
          _outsideWidgetElementSize =
              math.max(sizeDifference, _outsideWidgetElementSize);

          double axisSizeDifference = (thickness - axisSize) / 2;
          axisSizeDifference =
              axisSizeDifference - (isInsideLabel ? labelSize : 0);
          _insideWidgetElementSize =
              math.max(axisSizeDifference, _insideWidgetElementSize);
        }
        break;
      case LinearElementPosition.cross:
        if (axisSize == 0) {
          _updateInsideElementSize(thickness);
        } else if (tickSize > axisSize && axisSize < thickness) {
          final double sizeDifference = ((thickness - axisSize) / 2) -
              ((tickSize - axisSize) / 2) -
              (isInsideLabel ? 0 : labelSize);
          _outsideWidgetElementSize =
              math.max(sizeDifference, _outsideWidgetElementSize);

          if (_axisWidgetThickness < thickness) {
            double axisSizeDifference =
                ((thickness - axisSize) / 2) - ((tickSize - axisSize) / 2);
            axisSizeDifference =
                axisSizeDifference - (isInsideLabel ? labelSize : 0);
            _insideWidgetElementSize =
                math.max(axisSizeDifference, _insideWidgetElementSize);
          }
        } else if (axisSize < thickness) {
          final double sizeDifference =
              ((thickness - axisSize) / 2) - (isInsideLabel ? 0 : labelSize);

          _outsideWidgetElementSize =
              math.max(sizeDifference, _outsideWidgetElementSize);

          if (_axisWidgetThickness < thickness) {
            double axisSizeDifference = (thickness - axisSize) / 2;
            axisSizeDifference =
                axisSizeDifference - (isInsideLabel ? labelSize : 0);
            _insideWidgetElementSize =
                math.max(axisSizeDifference, _insideWidgetElementSize);
          }
        }
        break;
      default:
        break;
    }
  }

  /// Layout the pointer child.
  void _layoutPointerChild(
      {required RenderObject renderObject,
      required LinearElementPosition position,
      required double thickness,
      required double offset}) {
    final pointerPosition = LinearGaugeHelper.getEffectiveElementPosition(
        position, axis!.isMirrored);

    switch (pointerPosition) {
      case LinearElementPosition.inside:
        _measureInsideElementSize(thickness + offset);
        break;
      case LinearElementPosition.outside:
        _outsideWidgetElementSize =
            math.max(_outsideWidgetElementSize, thickness + offset - _axisTop);
        break;
      case LinearElementPosition.cross:
        _measureCrossElementSize(thickness);
        break;
      default:
        break;
    }
  }

  /// Position the child elements.
  void _positionChildElement(RenderObject linearGaugeChild,
      {double thickness = 0}) {
    final MultiChildLayoutParentData? childParentData =
        // ignore: avoid_as
        linearGaugeChild.parentData as MultiChildLayoutParentData?;
    final xPoint = _pointX + axis!.getChildPadding(child: linearGaugeChild);
    final yPoint = _pointY;

    if (_isHorizontalOrientation) {
      childParentData!.offset =
          Offset(xPoint - (_isAxisInversed ? thickness : 0), yPoint);
    } else {
      childParentData!.offset =
          Offset(yPoint, xPoint - (!_isAxisInversed ? thickness : 0));
    }
  }

  /// Calculates the marker pointer offset.
  double? _calculateMarkerOffset(
      {required LinearElementPosition elementPosition,
      required double offset,
      required Size size}) {
    final double markerSize =
        _isHorizontalOrientation ? size.height : size.width;
    final pointerPosition = LinearGaugeHelper.getEffectiveElementPosition(
        elementPosition, axis!.isMirrored);
    switch (pointerPosition) {
      case LinearElementPosition.inside:
        return _outsideWidgetElementSize +
            _axisTop +
            axis!.getAxisLineThickness() +
            offset +
            (_actualSizeDelta! / 2);
      case LinearElementPosition.outside:
        return (_actualSizeDelta! / 2) +
            (offset * -1) +
            (_outsideWidgetElementSize + _axisTop > markerSize
                ? _outsideWidgetElementSize + _axisTop - markerSize
                : 0);
      case LinearElementPosition.cross:
        return _outsideWidgetElementSize +
            _getCrossElementPosition(markerSize) +
            (_actualSizeDelta! / 2);
      default:
        break;
    }

    return null;
  }

  double _getCrossElementPosition(double width) {
    final double axisSize = axis!.getAxisLineThickness();
    if (axisSize == 0) return axisSize;

    if (axisSize > width) {
      return (axisSize - width) / 2 + _axisTop;
    } else if (axisSize < width) {
      return _axisTop - ((width - axisSize) / 2);
    } else {
      return _axisTop;
    }
  }

  void _updatePointerPositionOnDrag(dynamic pointer,
      {bool isDragCall = false}) {
    double animationValue = 1;

    if (!isDragCall) {
      if (pointer.pointerAnimation != null) {
        animationValue = pointer.pointerAnimation.value;
      }
    }

    final startPosition =
        (axis!.valueToPixel(pointer.oldValue ?? axis!.minimum));
    final endPosition = (axis!.valueToPixel(pointer.value)).abs();

    _pointX = startPosition + ((endPosition - startPosition) * animationValue);
    _pointY = _calculateMarkerOffset(
        elementPosition: pointer.position,
        offset: pointer.offset,
        size: Size(pointer.size.width, pointer.size.height))!;

    _positionChildElement(pointer);
  }

  void _updatePointerPosition() {
    if (_actualSizeDelta != null) {
      _positionMarkerPointers();
      markNeedsPaint();
    }
  }

  void _resetValues() {
    _axisWidgetThickness = 0;
    _insideWidgetElementSize = 0;
    _outsideWidgetElementSize = 0;

    _isAxisInversed = axis!.isAxisInversed;
    _isHorizontalOrientation =
        _axis!.orientation == LinearGaugeOrientation.horizontal;

    _pointerStartPadding = 0;
    _pointerEndPadding = 0;

    _markerPointers.clear();
    _markerPointers =
        [_shapePointers, _widgetPointers].expand((x) => x).toList();

    final width = constraints.hasBoundedWidth
        ? constraints.maxWidth
        : kDefaultLinearGaugeWidth;
    final height = constraints.hasBoundedHeight
        ? constraints.maxHeight
        : kDefaultLinearGaugeHeight;
    _parentConstraints = BoxConstraints(maxWidth: width, maxHeight: height);
  }

  /// Layout the marker pointers.
  void _layoutMarkerPointers() {
    if (_markerPointers.isNotEmpty) {
      for (final dynamic pointer in _markerPointers) {
        pointer.layout(_parentConstraints, parentUsesSize: true);

        final thickness = (_isHorizontalOrientation
            ? pointer.size.width
            : pointer.size.height);

        if (pointer.markerAlignment == LinearMarkerAlignment.start) {
          _pointerEndPadding = math.max(_pointerEndPadding, thickness);
        } else if (pointer.markerAlignment == LinearMarkerAlignment.center) {
          _pointerStartPadding = math.max(_pointerStartPadding, thickness / 2);
          _pointerEndPadding = math.max(_pointerEndPadding, thickness / 2);
        } else {
          _pointerStartPadding = math.max(_pointerStartPadding, thickness);
        }
      }
    }
  }

  void _updateAxisValues() {
    _axisWidgetThickness =
        _isHorizontalOrientation ? axis!.size.height : axis!.size.width;
    _axisTop = axis!.axisOffset;
    _axisLineActualSize =
        (axis!.valueToPixel(axis!.maximum) - axis!.valueToPixel(axis!.minimum))
            .abs();
  }

  BoxConstraints _getChildBoxConstraints() {
    final padding = axis!.getAxisLayoutPadding();
    if (_isHorizontalOrientation) {
      return BoxConstraints(
          maxWidth: _parentConstraints.maxWidth - padding,
          maxHeight: _parentConstraints.maxHeight);
    } else {
      return BoxConstraints(
          maxWidth: _parentConstraints.maxWidth,
          maxHeight: _parentConstraints.maxHeight - padding);
    }
  }

  void _updateAxisBasicRenderingDetails() {
    axis!.pointerStartPadding = _pointerStartPadding;
    axis!.pointerEndPadding = _pointerEndPadding;
    axis!.generateLabels(_parentConstraints);
    _childConstraints = _getChildBoxConstraints();
  }

  /// Layout the axis element.
  void _layoutAxis() {
    if (axis != null) {
      _updateAxisBasicRenderingDetails();
      axis!.layout(_childConstraints, parentUsesSize: true);
      _updateAxisValues();
    }
  }

  /// Layout the range elements.
  void _layoutRange() {
    if (_ranges.isNotEmpty) {
      for (final range in _ranges) {
        range.layout(_childConstraints, parentUsesSize: true);
        final rangeThickness =
            _isHorizontalOrientation ? range.size.height : range.size.width;
        final position = LinearGaugeHelper.getEffectiveElementPosition(
            range.position, range.isMirrored);

        switch (position) {
          case LinearElementPosition.inside:
            _measureInsideElementSize(rangeThickness);
            break;
          case LinearElementPosition.outside:
            _outsideWidgetElementSize =
                math.max(_outsideWidgetElementSize, rangeThickness - _axisTop);
            break;
          case LinearElementPosition.cross:
            _measureCrossElementSize(rangeThickness);
            break;
          default:
            break;
        }
      }
    }
  }

  /// Layout the bar pointers.
  void _layoutBarPointers() {
    if (_barPointers.isNotEmpty) {
      for (final barPointer in _barPointers) {
        barPointer.layout(_childConstraints, parentUsesSize: true);

        _layoutPointerChild(
            renderObject: barPointer,
            position: barPointer.position,
            thickness: barPointer.thickness,
            offset: barPointer.offset);
      }
    }
  }

  void _measureMarkerPointersSize() {
    if (_markerPointers.isNotEmpty) {
      for (final dynamic markerPointer in _markerPointers) {
        final thickness = (_isHorizontalOrientation
            ? markerPointer.size.height
            : markerPointer.size.width);

        _layoutPointerChild(
            renderObject: markerPointer,
            position: markerPointer.position,
            thickness: thickness,
            offset: markerPointer.offset);
      }
    }
  }

  Size _getParentLayoutSize() {
    /// Layout parent.
    double actualHeight, actualWidth;

    if (_isHorizontalOrientation) {
      actualHeight = constraints.hasBoundedHeight
          ? constraints.maxHeight
          : _axisWidgetThickness +
              _outsideWidgetElementSize +
              _insideWidgetElementSize;
      actualWidth = _parentConstraints.maxWidth;
    } else {
      actualHeight = _parentConstraints.maxHeight;
      actualWidth = constraints.hasBoundedWidth
          ? constraints.maxWidth
          : _axisWidgetThickness +
              _outsideWidgetElementSize +
              _insideWidgetElementSize;
    }

    _actualSizeDelta = (_isHorizontalOrientation ? actualHeight : actualWidth) -
        (_axisWidgetThickness +
            _outsideWidgetElementSize +
            _insideWidgetElementSize);

    return Size(actualWidth, actualHeight);
  }

  /// Position the linear gauge axis.
  void _positionAxis() {
    _overflow = math.max(0.0, -_actualSizeDelta!);
    if (axis != null) {
      final MultiChildLayoutParentData? childParentData =
          // ignore: avoid_as
          axis!.parentData as MultiChildLayoutParentData?;
      _pointX = axis!.getAxisPositionPadding();
      _pointY = _outsideWidgetElementSize + _actualSizeDelta! / 2;

      if (_isHorizontalOrientation) {
        childParentData!.offset = Offset(_pointX, _pointY);
      } else {
        childParentData!.offset = Offset(_pointY, _pointX);
      }
    }
  }

  /// Position the range elements.
  void _positionRanges() {
    if (_ranges.isNotEmpty) {
      for (final range in _ranges) {
        final thickness =
            _isHorizontalOrientation ? range.size.height : range.size.width;
        final rangeWidth =
            _isHorizontalOrientation ? range.size.width : range.size.height;

        _pointX = axis!.valueToPixel(range.startValue).abs();

        final position = LinearGaugeHelper.getEffectiveElementPosition(
            range.position, range.isMirrored);
        final double axisSize = axis!.showAxisTrack ? axis!.thickness : 0.0;

        switch (position) {
          case LinearElementPosition.inside:
            _pointY = _outsideWidgetElementSize +
                _axisTop +
                axisSize +
                (_actualSizeDelta! / 2);
            break;
          case LinearElementPosition.outside:
            final positionY = thickness < _outsideWidgetElementSize + _axisTop
                ? _outsideWidgetElementSize + _axisTop - thickness
                : 0;
            _pointY = positionY + (_actualSizeDelta! / 2);
            break;
          case LinearElementPosition.cross:
            _pointY = _outsideWidgetElementSize +
                (_actualSizeDelta! / 2) +
                _getCrossElementPosition(thickness);
            break;
          default:
            break;
        }

        _positionChildElement(range, thickness: rangeWidth);
      }
    }
  }

  /// Position the bar pointers.
  void _positionBarPointers() {
    if (_barPointers.isNotEmpty) {
      for (final barPointer in _barPointers) {
        _pointX = axis!.valueToPixel(axis!.minimum).abs();

        final barWidth = _isHorizontalOrientation
            ? barPointer.size.width
            : barPointer.size.height;

        final position = LinearGaugeHelper.getEffectiveElementPosition(
            barPointer.position, axis!.isMirrored);

        switch (position) {
          case LinearElementPosition.inside:
            _pointY = _outsideWidgetElementSize +
                _axisTop +
                axis!.getAxisLineThickness() +
                barPointer.offset +
                (_actualSizeDelta! / 2);
            break;
          case LinearElementPosition.outside:
            _pointY = (_actualSizeDelta! / 2) +
                (barPointer.offset * -1) +
                (_outsideWidgetElementSize + _axisTop > barPointer.thickness
                    ? _outsideWidgetElementSize +
                        _axisTop -
                        barPointer.thickness
                    : 0);
            break;
          case LinearElementPosition.cross:
            _pointY = _outsideWidgetElementSize +
                (_actualSizeDelta! / 2) +
                _getCrossElementPosition(barPointer.thickness);
            break;
          default:
            break;
        }

        _positionChildElement(barPointer, thickness: barWidth);
      }
    }
  }

  /// Position the marker pointers.
  void _positionMarkerPointers() {
    if (_markerPointers.isNotEmpty) {
      for (final dynamic pointer in _markerPointers) {
        _updatePointerPositionOnDrag(pointer);
      }
    }
  }

  void _addPointerAnimationListeners() {
    if (_pointerAnimations.isNotEmpty) {
      for (final animation in _pointerAnimations) {
        animation.addListener(_updatePointerPosition);
      }
    }
  }

  void _removePointerAnimationListeners() {
    if (_pointerAnimations.isNotEmpty) {
      for (final animation in _pointerAnimations) {
        animation.removeListener(_updatePointerPosition);
      }
    }
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _addPointerAnimationListeners();
  }

  @override
  void detach() {
    _removePointerAnimationListeners();
    super.detach();
  }

  @override
  void performLayout() {
    _resetValues();

    // Layout the widget pointers first to determine the padding size.
    _layoutMarkerPointers();
    _layoutAxis();
    _layoutRange();
    _layoutBarPointers();
    _measureMarkerPointersSize();

    size = _getParentLayoutSize();

    _positionAxis();
    _positionRanges();
    _positionBarPointers();
    _positionMarkerPointers();
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final isHit = super.defaultHitTestChildren(result, position: position);

    if (isHit && !_restrictHitTestPointerChange) {
      final child = result.path.last.target;

      if (child is RenderLinearShapePointer ||
          child is RenderLinearWidgetPointer) {
        _isMarkerPointerInteraction = true;
        _markerRenderObject = child;
      } else {
        _isMarkerPointerInteraction = false;
      }
    }

    return isHit;
  }

  ///Get the value from position.
  double _getValueFromPosition(Offset localPosition) {
    final double actualAxisPadding = axis!.getChildPadding();

    double visualPosition;

    if (_isHorizontalOrientation) {
      visualPosition =
          (localPosition.dx - actualAxisPadding) / _axisLineActualSize;
    } else {
      visualPosition =
          (localPosition.dy - actualAxisPadding) / _axisLineActualSize;
    }

    return axis!.factorToValue(visualPosition.clamp(0.0, 1.0));
  }

  /// Handles the drag update callback.
  void _handleDragUpdate(DragUpdateDetails details) {
    final _currentValue = _getValueFromPosition(details.localPosition);
    if (_markerRenderObject.onValueChanged != null &&
        _markerRenderObject.value != _currentValue) {
      _markerRenderObject.oldValue = _currentValue;
      _markerRenderObject.onValueChanged(_currentValue);
      _updatePointerPositionOnDrag(_markerRenderObject, isDragCall: true);
      markNeedsPaint();
    }
  }

  void _handleDragStart(DragStartDetails details) {}

  void _handleTapDown(TapDownDetails details) {}

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent && _isMarkerPointerInteraction) {
      _restrictHitTestPointerChange = true;
      _tapGestureRecognizer.addPointer(event);
      _horizontalDragGestureRecognizer.addPointer(event);
      _verticalDragGestureRecognizer.addPointer(event);
    } else if (event is PointerUpEvent || event is PointerCancelEvent) {
      _restrictHitTestPointerChange = false;
    }

    super.handleEvent(event, entry);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.pushClipRect(
        needsCompositing, offset, Rect.fromLTWH(0, 0, size.width, size.height),
        (context, offset) {
      defaultPaint(context, offset);
      // There's no point in drawing the children if we're empty.
      if (size.isEmpty) {
        return;
      }

      assert(() {
        // Only set this if it's null to save work. It gets reset to null if the
        // _direction changes.
        final List<DiagnosticsNode> debugOverflowHints = <DiagnosticsNode>[
          ErrorDescription(
              'The edge of the $runtimeType that is overflowing has been marked '
              'in the rendering with a yellow and black striped pattern. This is '
              'usually caused by the contents being too big for the $runtimeType.'),
        ];

        // Simulate a child rect that overflows by the right amount. This child
        // rect is never used for drawing, just for determining the overflow
        // location and amount.
        Rect overflowChildRect;

        if (_isHorizontalOrientation) {
          overflowChildRect =
              Rect.fromLTWH(0.0, 0.0, 0.0, size.height + _overflow!);
        } else {
          overflowChildRect =
              Rect.fromLTWH(0.0, 0.0, size.width + _overflow!, 0.0);
        }

        paintOverflowIndicator(
            context, offset, Offset.zero & size, overflowChildRect,
            overflowHints: debugOverflowHints);
        return true;
      }());
    });
  }
}
