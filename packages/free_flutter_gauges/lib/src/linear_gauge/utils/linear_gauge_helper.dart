import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../linear_gauge/utils/enum.dart';

/// This class provide the start and end curve paths.
class LinearGaugeHelper {
  static RRect _getHorizontalStartCurve(Rect rect, double radius) {
    return RRect.fromRectAndCorners(rect,
        topLeft: Radius.circular(radius), bottomLeft: Radius.circular(radius));
  }

  static RRect _getHorizontalEndCurvePath(Rect rect, double radius) {
    return RRect.fromRectAndCorners(rect,
        topRight: Radius.circular(radius),
        bottomRight: Radius.circular(radius));
  }

  static RRect _getVerticalStartCurve(Rect rect, double radius) {
    return RRect.fromRectAndCorners(rect,
        topLeft: Radius.circular(radius), topRight: Radius.circular(radius));
  }

  static RRect _getVerticalEndCurvePath(Rect rect, double radius) {
    return RRect.fromRectAndCorners(rect,
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius));
  }

  /// Returns the start curve path.
  static RRect getStartCurve(
      {required bool isHorizontal,
      required bool isAxisInversed,
      required Rect rect,
      required double radius}) {
    if (isHorizontal) {
      return (!isAxisInversed
          ? _getHorizontalStartCurve(rect, radius)
          : _getHorizontalEndCurvePath(rect, radius));
    } else {
      return (!isAxisInversed
          ? _getVerticalEndCurvePath(rect, radius)
          : _getVerticalStartCurve(rect, radius));
    }
  }

  /// Returns the end curve path.
  static RRect getEndCurve(
      {required bool isHorizontal,
      required bool isAxisInversed,
      required Rect rect,
      required double radius}) {
    if (isHorizontal) {
      return (!isAxisInversed
          ? _getHorizontalEndCurvePath(rect, radius)
          : _getHorizontalStartCurve(rect, radius));
    } else {
      return (!isAxisInversed
          ? _getVerticalStartCurve(rect, radius)
          : _getVerticalEndCurvePath(rect, radius));
    }
  }

  /// Returns the effective element position.
  static LinearElementPosition getEffectiveElementPosition(
      LinearElementPosition position, bool isMirrored) {
    if (isMirrored) {
      return (position == LinearElementPosition.inside)
          ? LinearElementPosition.outside
          : (position == LinearElementPosition.outside)
              ? LinearElementPosition.inside
              : LinearElementPosition.cross;
    }

    return position;
  }

  /// Returns the effective label position.
  static LinearLabelPosition getEffectiveLabelPosition(
      LinearLabelPosition labelPlacement, bool isMirrored) {
    if (isMirrored) {
      labelPlacement = (labelPlacement == LinearLabelPosition.inside)
          ? LinearLabelPosition.outside
          : LinearLabelPosition.inside;
    }

    return labelPlacement;
  }

  /// Returns the curve animation function based on the animation type
  static Curve getCurveAnimation(LinearAnimationType type) {
    Curve curve = Curves.linear;
    switch (type) {
      case LinearAnimationType.bounceOut:
        curve = Curves.bounceOut;
        break;
      case LinearAnimationType.ease:
        curve = Curves.ease;
        break;
      case LinearAnimationType.easeInCirc:
        curve = Curves.easeInCirc;
        break;
      case LinearAnimationType.easeOutBack:
        curve = Curves.easeOutBack;
        break;
      case LinearAnimationType.elasticOut:
        curve = Curves.elasticOut;
        break;
      case LinearAnimationType.linear:
        curve = Curves.linear;
        break;
      case LinearAnimationType.slowMiddle:
        curve = Curves.slowMiddle;
        break;
      default:
        break;
    }
    return curve;
  }
}
