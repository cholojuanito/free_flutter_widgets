import 'package:flutter/foundation.dart';
import 'package:free_flutter_core/core.dart';
import 'date_picker_manager.dart';
import 'hijri_date_picker_manager.dart';

/// Holds the static helper methods of the date picker.
class DatePickerHelper {
  /// Return the index value based on RTL.
  static int getRtlIndex(int count, int index) {
    return count - index - 1;
  }

  /// Calculate the visible dates count based on picker view
  static int getViewDatesCount(
      DatePickerViewType pickerView, int numberOfWeeks, bool isHijri) {
    if (pickerView == DatePickerViewType.month) {
      if (isHijri) {
        /// 6 used to render the  default number of weeks, since, Hijri type
        /// doesn't support number of weeks in view.
        return DateTime.daysPerWeek * 6;
      } else {
        return DateTime.daysPerWeek * numberOfWeeks;
      }
    }

    return 0;
  }

  /// Checks both the ranges are equal or not.
  static bool isRangeEquals(dynamic? range1, dynamic? range2) {
    if ((range1 == null && range2 != null) ||
        (range2 == null && range1 != null)) {
      return false;
    }

    if (range1 == range2 ||
        (range1.startDate.isSameDate(range2.startDate) &&
            range1.endDate.isSameDate(range2.endDate))) {
      return true;
    }

    return false;
  }

  /// Checks both the range collections are equal or not.
  static bool isDateRangesEquals(
      List<dynamic>? rangeCollection1, List<dynamic>? rangeCollection2) {
    if (rangeCollection1 == rangeCollection2) {
      return true;
    }

    if ((rangeCollection1 == null &&
            rangeCollection2 != null &&
            rangeCollection2.isEmpty) ||
        (rangeCollection2 == null &&
            rangeCollection1 != null &&
            rangeCollection1.isEmpty)) {
      return true;
    }

    if ((rangeCollection1 == null && rangeCollection2 != null) ||
        (rangeCollection2 == null && rangeCollection1 != null) ||
        (rangeCollection1?.length != rangeCollection2?.length)) {
      return false;
    }

    for (int i = 0; i < rangeCollection1!.length; i++) {
      if (!isRangeEquals(rangeCollection1[i], rangeCollection2![i])) {
        return false;
      }
    }

    return true;
  }

  /// Calculate the next view visible start date based on picker view.
  static dynamic getNextViewStartDate(DatePickerViewType pickerView,
      int numberOfWeeksInView, dynamic date, bool isRtl, bool isHijri) {
    if (isRtl) {
      return getPreviousViewStartDate(
          pickerView, numberOfWeeksInView, date, false, isHijri);
    }

    switch (pickerView) {
      case DatePickerViewType.month:
        {
          return isHijri || numberOfWeeksInView == 6
              ? date.getNextMonthDate()
              : date.addDays(numberOfWeeksInView * DateTime.daysPerWeek);
        }
      case DatePickerViewType.year:
        {
          return getNextYearDate(date, 1, isHijri);
        }
      case DatePickerViewType.decade:
        {
          return getNextYearDate(date, 10, isHijri);
        }
      case DatePickerViewType.century:
        {
          return getNextYearDate(date, 100, isHijri);
        }
    }
  }

  /// Calculate the previous view visible start date based on calendar view.
  static dynamic getPreviousViewStartDate(DatePickerViewType pickerView,
      int numberOfWeeksInView, dynamic date, bool isRtl, bool isHijri) {
    if (isRtl) {
      return getNextViewStartDate(
          pickerView, numberOfWeeksInView, date, false, isHijri);
    }

    switch (pickerView) {
      case DatePickerViewType.month:
        {
          return isHijri || numberOfWeeksInView == 6
              ? date.getPreviousMonthDate()
              : date.addDays(-numberOfWeeksInView * DateTime.daysPerWeek);
        }
      case DatePickerViewType.year:
        {
          return getPreviousYearDate(date, 1, isHijri);
        }
      case DatePickerViewType.decade:
        {
          return getPreviousYearDate(date, 10, isHijri);
        }
      case DatePickerViewType.century:
        {
          return getPreviousYearDate(date, 100, isHijri);
        }
    }
  }

  /// Return the next view date of year view based on it offset value.
  /// offset value as 1 for year view, 10 for decade view and 100 for
  /// century view.
  static dynamic getNextYearDate(dynamic date, int offset, bool isHijri) {
    return getDate(((date.year ~/ offset) * offset) + offset, 1, 1, isHijri);
  }

  /// Return the previous view date of year view based on it offset value.
  /// offset value as 1 for year view, 10 for decade view and 100 for
  /// century view.
  static dynamic getPreviousYearDate(dynamic date, int offset, bool isHijri) {
    return getDate(((date.year ~/ offset) * offset) - offset, 1, 1, isHijri);
  }

  /// Return the month start date.
  static dynamic getMonthStartDate(dynamic date, bool isHijri) {
    return getDate(date.year, date.month, 1, isHijri);
  }

  /// Return the month end date.
  static dynamic getMonthEndDate(dynamic date) {
    return date.addDays(date.getNextMonthDate(), -1);
  }

  /// Return the index of the date in collection.
  static int isDateIndexInCollection(List<dynamic>? dates, dynamic? date) {
    if (dates == null || date == null) {
      return -1;
    }

    for (int i = 0; i < dates.length; i++) {
      final dynamic visibleDate = dates[i];
      if (date.isSameDate(visibleDate)) {
        return i;
      }
    }

    return -1;
  }

  /// Checks both the date collection are equal or not.
  static bool isDateCollectionEquals(
      List<dynamic>? datesCollection1, List<dynamic>? datesCollection2) {
    if (datesCollection1 == datesCollection2) {
      return true;
    }

    if ((datesCollection1 == null &&
            datesCollection2 != null &&
            datesCollection2.isEmpty) ||
        (datesCollection2 == null &&
            datesCollection1 != null &&
            datesCollection1.isEmpty)) {
      return false;
    }

    if ((datesCollection1 == null && datesCollection2 != null) ||
        (datesCollection2 == null && datesCollection1 != null) ||
        (datesCollection1?.length != datesCollection2?.length)) {
      return false;
    }

    for (int i = 0; i < datesCollection1!.length; i++) {
      if (!datesCollection2![i].isSameDate(datesCollection1[i])) {
        return false;
      }
    }

    return true;
  }

  /// Check the date as enable date or disable date based on min date, max date
  /// and enable past dates values.
  static bool isEnabledDate(dynamic? startDate, dynamic? endDate,
      bool enablePastDates, dynamic? date, bool isHijri) {
    return date.isWithinDateRange(startDate, endDate) &&
        (enablePastDates ||
            (!enablePastDates &&
                date.isWithinDateRange(getToday(isHijri), endDate)));
  }

  /// Check the date as current month date.
  static bool isDateAsCurrentMonthDate(dynamic visibleDate, int rowCount,
      bool showLeadingAndTrialingDates, dynamic date, bool isHijri) {
    if ((rowCount == 6 && !showLeadingAndTrialingDates || isHijri) &&
        date.month != visibleDate.month) {
      return false;
    }

    return true;
  }

  /// Return the updated left and top value based cell width and height and
  /// total width and height.
  static Map<String, double> getTopAndLeftValues(bool isRtl, double left,
      double top, double cellWidth, double cellHeight, double width) {
    final Map<String, double> topAndLeft = <String, double>{
      'left': left,
      'top': top
    };
    if (isRtl) {
      if (left.round() == cellWidth.round()) {
        left = 0;
      } else {
        left -= cellWidth;
      }
      if (left < 0) {
        left = width - cellWidth;
        top += cellHeight;
      }
    } else {
      left += cellWidth;
      if (left + 1 >= width) {
        top += cellHeight;
        left = 0;
      }
    }
    topAndLeft['left'] = left;
    topAndLeft['top'] = top;

    return topAndLeft;
  }

  /// Check the date placed in dates collection based on visible dates.
  static bool isDateWithinVisibleDates(
      List<dynamic> visibleDates, List<dynamic>? dates, dynamic date) {
    if (dates == null || dates.isEmpty) {
      return false;
    }

    final dynamic visibleStartDate = visibleDates[0];
    final dynamic visibleEndDate = visibleDates[visibleDates.length - 1];
    for (final dynamic currentDate in dates) {
      if (!currentDate.isWithinDateRange(visibleStartDate, visibleEndDate)) {
        continue;
      }

      if (date.isSameDate(currentDate)) {
        return true;
      }
    }

    return false;
  }

  /// Check the date week day placed in week end day collection.
  static bool isWeekend(List<int>? weekendIndex, dynamic date) {
    if (weekendIndex == null || weekendIndex.isEmpty) {
      return false;
    }

    return weekendIndex.contains(date.weekday);
  }

  /// Check the left side view have valid dates based on widget direction.
  static bool canMoveToPreviousViewRtl(
      DatePickerViewType view,
      int numberOfWeeksInView,
      dynamic minDate,
      dynamic maxDate,
      List<dynamic> visibleDates,
      bool isRtl,
      bool enableMultiView,
      bool isHijri) {
    if (isRtl) {
      return canMoveToNextView(view, numberOfWeeksInView, maxDate, visibleDates,
          enableMultiView, isHijri);
    } else {
      return canMoveToPreviousView(view, numberOfWeeksInView, minDate,
          visibleDates, enableMultiView, isHijri);
    }
  }

  /// Check the right side view have valid dates based on widget direction.
  static bool canMoveToNextViewRtl(
      DatePickerViewType view,
      int numberOfWeeksInView,
      dynamic minDate,
      dynamic maxDate,
      List<dynamic> visibleDates,
      bool isRtl,
      bool enableMultiView,
      bool isHijri) {
    if (isRtl) {
      return canMoveToPreviousView(view, numberOfWeeksInView, minDate,
          visibleDates, enableMultiView, isHijri);
    } else {
      return canMoveToNextView(view, numberOfWeeksInView, maxDate, visibleDates,
          enableMultiView, isHijri);
    }
  }

  /// Check the previous view have enabled dates or not.
  static bool canMoveToPreviousView(
      DatePickerViewType view,
      int numberOfWeeksInView,
      dynamic minDate,
      List<dynamic> visibleDates,
      bool enableMultiView,
      bool isHijri) {
    switch (view) {
      case DatePickerViewType.month:
        {
          if (numberOfWeeksInView != 6 && !isHijri) {
            DateTime prevViewDate = visibleDates[0];
            prevViewDate = prevViewDate.addDays(-1);
            if (!prevViewDate.isSameOrAfterDate(minDate)) {
              return false;
            }
          } else {
            final dynamic currentDate =
                visibleDates[visibleDates.length ~/ (enableMultiView ? 4 : 2)];
            final dynamic previousDate = currentDate.getPreviousMonthDate();
            if (((previousDate.month < minDate.month &&
                    previousDate.year == minDate.year) ||
                previousDate.year < minDate.year)) {
              return false;
            }
          }
        }
        break;
      case DatePickerViewType.year:
      case DatePickerViewType.decade:
      case DatePickerViewType.century:
        {
          final int currentYear =
              visibleDates[visibleDates.length ~/ (enableMultiView ? 4 : 2)]
                  .year;
          final int minYear = minDate.year;

          final int offset = getOffset(view);
          if (((currentYear ~/ offset) * offset) - offset <
              ((minYear ~/ offset) * offset)) {
            return false;
          }
        }
    }

    return true;
  }

  /// Return the year view offset based on picker view(year, decade, century).
  static int getOffset(dynamic view) {
    final DatePickerViewType pickerView = getPickerView(view);
    switch (pickerView) {
      case DatePickerViewType.month:
        break;
      case DatePickerViewType.year:
        return 1;
      case DatePickerViewType.decade:
        return 10;
      case DatePickerViewType.century:
        return 100;
    }
    return 0;
  }

  /// Get the visible dates based on the date value and visible dates count.
  static List getVisibleYearDates(
      dynamic date, DatePickerViewType view, bool isHijri) {
    List datesCollection;
    if (isHijri) {
      datesCollection = <HijriDateTime>[];
    } else {
      datesCollection = <DateTime>[];
    }

    dynamic currentDate;
    const int daysCount = 12;
    switch (view) {
      case DatePickerViewType.month:
        break;
      case DatePickerViewType.year:
        {
          for (int i = 1; i <= daysCount; i++) {
            currentDate = getDate(date.year, i, 1, isHijri);
            datesCollection.add(currentDate);
          }
        }
        break;
      case DatePickerViewType.decade:
        {
          final int year = (date.year ~/ 10) * 10;

          for (int i = 0; i < daysCount; i++) {
            currentDate = getDate(year + i, 1, 1, isHijri);
            datesCollection.add(currentDate);
          }
        }
        break;
      case DatePickerViewType.century:
        {
          final int year = (date.year ~/ 100) * 100;
          for (int i = 0; i < daysCount; i++) {
            currentDate = getDate(year + (i * 10), 1, 1, isHijri);

            datesCollection.add(currentDate);
          }
        }
    }

    return datesCollection;
  }

  /// Check the next view have enabled dates or not.
  static bool canMoveToNextView(
      DatePickerViewType view,
      int numberOfWeeksInView,
      dynamic maxDate,
      List<dynamic> visibleDates,
      bool enableMultiView,
      bool isHijri) {
    switch (view) {
      case DatePickerViewType.month:
        {
          if (!isHijri && numberOfWeeksInView != 6) {
            DateTime nextViewDate = visibleDates[visibleDates.length - 1];
            nextViewDate = nextViewDate.addDays(1);
            if (!nextViewDate.isSameOrBeforeDate(maxDate)) {
              return false;
            }
          } else {
            final dynamic currentDate =
                visibleDates[visibleDates.length ~/ (enableMultiView ? 4 : 2)];
            final dynamic nextDate = currentDate.getNextMonthDate();
            if (((nextDate.month > maxDate.month &&
                    nextDate.year == maxDate.year) ||
                nextDate.year > maxDate.year)) {
              return false;
            }
          }
        }
        break;
      case DatePickerViewType.year:
      case DatePickerViewType.decade:
      case DatePickerViewType.century:
        {
          final int currentYear =
              visibleDates[visibleDates.length ~/ (enableMultiView ? 4 : 2)]
                  .year;
          final int maxYear = maxDate.year;
          final int offset = getOffset(view);
          if (((currentYear ~/ offset) * offset) + offset >
              ((maxYear ~/ offset) * offset)) {
            return false;
          }
        }
    }
    return true;
  }

  /// Return the copy of the list.
  static List<dynamic>? cloneList(List<dynamic>? value) {
    if (value == null || value.isEmpty) {
      return value;
    }

    return value.sublist(0);
  }

  /// Determine the current platform is mobile platform(android or iOS).
  static bool isMobileLayout(TargetPlatform platform) {
    if (kIsWeb) {
      return false;
    }

    return platform == TargetPlatform.android || platform == TargetPlatform.iOS;
  }

  /// Returns the corresponding hijri month date, for the date passed with the
  /// given month format and localization.
  static String getHijriMonthText(
      dynamic date, Localization localizations, String format) {
    if (date.month == 1) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortMuharramLabel;
      }
      return localizations.muharramLabel;
    } else if (date.month == 2) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortSafarLabel;
      }
      return localizations.safarLabel;
    } else if (date.month == 3) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortRabi1Label;
      }
      return localizations.rabi1Label;
    } else if (date.month == 4) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortRabi2Label;
      }
      return localizations.rabi2Label;
    } else if (date.month == 5) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortJumada1Label;
      }
      return localizations.jumada1Label;
    } else if (date.month == 6) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortJumada2Label;
      }
      return localizations.jumada2Label;
    } else if (date.month == 7) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortRajabLabel;
      }
      return localizations.rajabLabel;
    } else if (date.month == 8) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortShaabanLabel;
      }

      return localizations.shaabanLabel;
    } else if (date.month == 9) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortRamadanLabel;
      }

      return localizations.ramadanLabel;
    } else if (date.month == 10) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortShawwalLabel;
      }
      return localizations.shawwalLabel;
    } else if (date.month == 11) {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortDhualqiLabel;
      }
      return localizations.dhualqiLabel;
    } else {
      if (format == 'M' || format == 'MM') {
        return date.month.toString();
      } else if (format == 'MMM') {
        return localizations.shortDhualhiLabel;
      }
      return localizations.dhualhiLabel;
    }
  }

  /// Returns teh [DatePickerViewType] value based on the given value.
  static DatePickerViewType getPickerView(dynamic view) {
    if (view is DatePickerViewType) {
      return view;
    }

    switch (view) {
      case HijriDatePickerView.month:
        {
          return DatePickerViewType.month;
        }
      case HijriDatePickerView.year:
        {
          return DatePickerViewType.year;
        }
      case HijriDatePickerView.decade:
        {
          return DatePickerViewType.decade;
        }
    }

    return DatePickerViewType.month;
  }

  /// Returns teh [HijriDatePickerView] value based on the given value.
  static HijriDatePickerView getHijriPickerView(dynamic view) {
    if (view is HijriDatePickerView) {
      return view;
    }

    switch (view) {
      case DatePickerViewType.month:
        {
          return HijriDatePickerView.month;
        }
      case DatePickerViewType.year:
        {
          return HijriDatePickerView.year;
        }
      case DatePickerViewType.decade:
        {
          return HijriDatePickerView.decade;
        }
      case DatePickerViewType.century:
        {
          return HijriDatePickerView.decade;
        }
    }

    return HijriDatePickerView.month;
  }

  /// Returns the number of weeks in view for the picker.
  static int getNumberOfWeeksInView(dynamic monthViewSettings, bool isHijri) {
    if (isHijri) {
      return 6;
    }

    return monthViewSettings.numberOfWeeksInView;
  }

  /// Determines whether the leading and trailing dates can be shown or not.
  static bool canShowLeadingAndTrailingDates(
      dynamic monthViewSettings, bool isHijri) {
    if (isHijri) {
      return false;
    }

    return monthViewSettings.showTrailingAndLeadingDates;
  }

  /// Returns the today date value.
  static dynamic getToday(bool isHijri) {
    if (isHijri) {
      return HijriDateTime.now();
    }

    return DateTime.now();
  }

  /// Returns the required date with the given parameter values.
  static dynamic getDate(int year, int month, int day, bool isHijri) {
    if (isHijri) {
      return HijriDateTime(year, month, day);
    }

    return DateTime(year, month, day);
  }

  /// Check both the dates are placed on same year, decade, century cell.
  /// Eg., In year view, 20-01-2020 and 21-01-2020 dates are not equal but
  /// both the dates are placed in same year cell.
  /// Note: This method not applicable for month view.
  static bool isSameCellDates(
      dynamic? date, dynamic? currentDate, dynamic view) {
    if (date == null || currentDate == null) {
      return false;
    }

    final DatePickerViewType pickerView = getPickerView(view);
    if (pickerView == DatePickerViewType.month) {
      return false;
    }

    if (pickerView == DatePickerViewType.year) {
      return date.month == currentDate.month && date.year == currentDate.year;
    } else if (pickerView == DatePickerViewType.decade) {
      return date.year == currentDate.year;
    } else if (pickerView == DatePickerViewType.century) {
      return date.year ~/ 10 == currentDate.year ~/ 10;
    }

    return false;
  }

  /// Check the year cell index date as leading date or not.
  /// Eg., Decade view holds 12 cells(2020 - 2031) and it have leading decade
  /// view dates(2030 and 2031). The below method used to identify the date
  /// as leading date or not.
  /// Note: This method not applicable for month view.
  static bool isLeadingCellDate(
      int index, int viewStartIndex, List<dynamic> visibleDates, dynamic view) {
    final DatePickerViewType pickerView = getPickerView(view);
    if (pickerView == DatePickerViewType.month ||
        pickerView == DatePickerViewType.year) {
      return false;
    }

    final dynamic currentDate = visibleDates[index];
    final dynamic viewStartDate = visibleDates[viewStartIndex];

    if (pickerView == DatePickerViewType.decade) {
      return currentDate.year ~/ 10 != viewStartDate.year ~/ 10;
    } else if (pickerView == DatePickerViewType.century) {
      return currentDate.year ~/ 100 != viewStartDate.year ~/ 100;
    }

    return false;
  }

  /// Check the date is enabled or not based on min and max date value.
  /// If picker max date as 20-12-2020 and selected date value as 21-12-2020
  /// then the year view need to highlight selection because year view only
  /// consider the month value(max month as 12).
  /// Note: This method not applicable for month view.
  static bool isBetweenMinMaxDateCell(dynamic? date, dynamic? minDate,
      dynamic? maxDate, bool enablePastDates, dynamic view, bool isHijri) {
    if (date == null || minDate == null || maxDate == null) {
      return true;
    }

    final DatePickerViewType pickerView = getPickerView(view);
    if (pickerView == DatePickerViewType.month) {
      return false;
    }

    final dynamic today = getToday(isHijri);
    if (pickerView == DatePickerViewType.year) {
      return ((date.month >= minDate.month && date.year == minDate.year) ||
              date.year > minDate.year) &&
          ((date.month <= maxDate.month && date.year == maxDate.year) ||
              date.year < maxDate.year) &&
          (enablePastDates ||
              (!enablePastDates &&
                  ((date.month >= today.month && date.year == today.year) ||
                      date.year > today.year)));
    } else if (pickerView == DatePickerViewType.decade) {
      return date.year >= minDate.year &&
          date.year <= maxDate.year &&
          (enablePastDates || (!enablePastDates && date.year >= today.year));
    } else if (pickerView == DatePickerViewType.century) {
      final int currentYear = date.year ~/ 10;
      return currentYear >= (minDate.year ~/ 10) &&
          currentYear <= (maxDate.year ~/ 10) &&
          (enablePastDates ||
              (!enablePastDates && currentYear >= today.year ~/ 10));
    }

    return false;
  }

  /// Return the last date of the month, year and decade based on view.
  /// Eg., If picker view is year and the date value as 20-01-2020 then
  /// it return the last date of the month(31-01-2020).
  /// Note: This method not applicable for month view.
  static dynamic getLastDate(dynamic? date, dynamic? view, bool isHijri) {
    final DatePickerViewType pickerView = getPickerView(view);
    if (pickerView == DatePickerViewType.month) {
      return date;
    }

    if (pickerView == DatePickerViewType.year) {
      final dynamic currentDate =
          getDate(date.year, date.month + 1, 1, isHijri);
      return currentDate.addDays(-1);
    } else if (pickerView == DatePickerViewType.decade) {
      final dynamic currentDate = getDate(date.year + 1, 1, 1, isHijri);
      return currentDate.addDays(-1);
    } else if (pickerView == DatePickerViewType.century) {
      final dynamic currentDate =
          getDate(((date.year ~/ 10) * 10) + 10, 1, 1, isHijri);
      return currentDate.addDays(-1);
    }

    return date;
  }

  /// Return index of the date value in dates collection.
  /// Return -1 when the date does not exist in dates collection.
  static int getDateCellIndex(List<dynamic> dates, dynamic? date, dynamic view,
      {int viewStartIndex = -1, int viewEndIndex = -1}) {
    if (date == null) {
      return -1;
    }

    final DatePickerViewType pickerView = getPickerView(view);
    viewStartIndex = viewStartIndex == -1 ? 0 : viewStartIndex;
    viewEndIndex = viewEndIndex == -1 ? dates.length - 1 : viewEndIndex;
    for (int i = viewStartIndex; i <= viewEndIndex; i++) {
      final dynamic currentDate = dates[i];
      if (isSameCellDates(date, currentDate, pickerView)) {
        return i;
      }
    }

    return -1;
  }
}

/// args to update the required properties from picker state to it's children's
class PickerStateArgs {
  /// Holds the current view display date.
  dynamic currentDate;

  /// Holds the current view visible dates.
  List<dynamic> currentViewVisibleDates = <dynamic>[];

  /// Holds the current selected date.
  dynamic selectedDate;

  /// Holds the current selected dates.
  List<dynamic>? selectedDates;

  /// Holds the current selected range.
  dynamic selectedRange;

  /// Holds the current selected ranges.
  List<dynamic>? selectedRanges;

  /// Holds the current picker view.
  DatePickerViewType view = DatePickerViewType.month;

  /// clone this picker state args with new instance
  PickerStateArgs clone() {
    return PickerStateArgs()
      ..currentViewVisibleDates = currentViewVisibleDates
      ..currentDate = currentDate
      ..view = view
      ..selectedDate = selectedDate
      ..selectedDates = selectedDates
      ..selectedRange = selectedRange
      ..selectedRanges = selectedRanges;
  }
}
