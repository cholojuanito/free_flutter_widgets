import 'hijri_datetime.dart';

const int _daysPerCentury = 36500;
const int _daysPerDecade = 3650;
const int _daysPerYear = 365;

/// Extension methods on DateTime objects
extension DateOperations on DateTime {
  /// Add the date value with duration without daylight saving value
  ///
  /// eg., if local time zone as British Summer Time, and its
  /// daylight saving enabled on 29 March, 2020 to 25 October, 2020.
  /// add one day to the date(Oct 25, 2020) using add() method in [DateTime],
  /// it return Oct 25, 2020 23.00.00 instead of Oct 26, 2020 because this method
  /// consider location and daylight saving.
  ///
  /// So check whether the current date time zone offset(+1) is equal to
  /// previous date time zone offset(+2). if both are not equal then calculate
  /// the difference (date.timeZoneOffset - currentDate.timeZoneOffset)
  /// and add the offset difference(2-1) to current date.
  DateTime addKeepTimeZoneOffset(Duration duration) {
    DateTime newDate = add(duration);
    if (timeZoneOffset != newDate.timeZoneOffset) {
      newDate = newDate.add(timeZoneOffset - newDate.timeZoneOffset);
    }

    return newDate;
  }

  /// Subtract the date value with duration without daylight saving value
  ///
  /// eg., if local time zone as British Summer Time, and its daylight saving
  /// enabled on 29 March, 2020 to 25 October, 2020.
  /// subtract one day to the date(Oct 26, 2020) using subtract() method in
  /// [DateTime], it return Oct 25, 2020 1.00.00 instead of Oct 25, 2020 00.00.00
  /// because this method consider location
  /// and daylight saving.
  ///
  /// So check whether the current date time zone offset(+2) is equal to
  /// previous date time zone offset(+1). if both are not equal then calculate
  /// the difference date.timeZoneOffset - currentDate.timeZoneOffset) and add
  /// the offset difference(1-2) to current date.
  DateTime subtractKeepTimeZoneOffset(Duration duration) {
    DateTime newDate = subtract(duration);
    if (timeZoneOffset != newDate.timeZoneOffset) {
      newDate = newDate.add(timeZoneOffset - newDate.timeZoneOffset);
    }

    return newDate;
  }

  /// Returns the previous month's start date
  DateTime getPreviousMonthDate() {
    return month == 1
        ? DateTime(year - 1, 12, 1)
        : DateTime(year, month - 1, 1);
  }

  /// Returns the next month's start date
  DateTime getNextMonthDate() {
    return month == 12
        ? DateTime(year + 1, 1, 1)
        : DateTime(year, month + 1, 1);
  }

  /// Get a valid date after the [minDate]
  /// OR before the [maxDate]
  DateTime getDateBetweenMinAndMax(DateTime minDate, DateTime maxDate) {
    if (isAfter(minDate)) {
      if (isBefore(maxDate)) {
        return this;
      } else {
        return maxDate;
      }
    } else {
      return minDate;
    }
  }

  // /// Determines if the given date is between the [minDate] and [maxDate]
  // bool isBetween(DateTime minDate, DateTime maxDate) {
  //   return isAfter(minDate) && isBefore(maxDate);
  // }

  /// Check if dates are equivalent
  bool isSameDate(DateTime other) {
    if (other == this) {
      return true;
    }

    return month == other.month && year == other.year && day == other.day;
  }

  /// Check the date in between first and last date
  bool isWithinDateRange(DateTime startDate, DateTime endDate) {
    if (startDate.isAfter(endDate)) {
      final dynamic temp = startDate;
      startDate = endDate;
      endDate = temp;
    }

    if (isSameOrBeforeDate(endDate) && isSameOrAfterDate(startDate)) {
      return true;
    }

    return false;
  }

  /// Check if the date is before or same as [other]
  bool isSameOrBeforeDate(DateTime other) {
    return isSameDate(other) || isBefore(other);
  }

  /// Check if the date is after or same as [other]
  bool isSameOrAfterDate(DateTime other) {
    return isSameDate(other) || isAfter(other);
  }

  /// Get the visible dates based on the date value and visible dates count.
  List getVisibleDates(
      List<int>? nonWorkingDays, int firstDayOfWeek, int visibleDatesCount) {
    final List datesCollection = <DateTime>[];
    final DateTime currentDate =
        getFirstDayOfWeekDate(visibleDatesCount, firstDayOfWeek);

    for (int i = 0; i < visibleDatesCount; i++) {
      final DateTime visibleDate = currentDate.addDays(i);
      if (nonWorkingDays != null &&
          nonWorkingDays.contains(visibleDate.weekday)) {
        continue;
      }

      datesCollection.add(visibleDate);
    }

    return datesCollection;
  }

  /// Add [days] to given [DateTime]
  DateTime addDays(int days) {
    return add(Duration(days: days));
  }

  /// Add [years] to given [DateTime]
  DateTime addYears(int years) {
    return add(Duration(days: years * _daysPerYear));
  }

  /// Add [decades] to given [DateTime]
  DateTime addDecades(int decades) {
    return add(Duration(days: decades * _daysPerDecade));
  }

  /// Add [centuries] to given [DateTime]
  DateTime addCenturies(int centuries) {
    return add(Duration(days: centuries * _daysPerCentury));
  }

  /// Calculate first day of week date value based original date with first day of
  /// week value.
  DateTime getFirstDayOfWeekDate(int visibleDatesCount, int firstDayOfWeek) {
    if (visibleDatesCount % 7 != 0) {
      return this;
    }

    const int numberOfWeekDays = 7;
    DateTime currentDate = this;
    if (visibleDatesCount == 42) {
      currentDate = DateTime(currentDate.year, currentDate.month, 1);
    }

    int value = -currentDate.weekday + firstDayOfWeek - numberOfWeekDays;
    if (value.abs() >= numberOfWeekDays) {
      value += numberOfWeekDays;
    }

    currentDate = addDays(value);
    return currentDate;
  }
}

/// Extension methods on HijriDateTime objects
extension HijriDateOperations on HijriDateTime {
  /// Add the date value with duration without daylight saving value
  ///
  /// eg., if local time zone as British Summer Time, and its
  /// daylight saving enabled on 29 March, 2020 to 25 October, 2020.
  /// add one day to the date(Oct 25, 2020) using add() method in [DateTime],
  /// it return Oct 25, 2020 23.00.00 instead of Oct 26, 2020 because this method
  /// consider location and daylight saving.
  ///
  /// So check whether the current date time zone offset(+1) is equal to
  /// previous date time zone offset(+2). if both are not equal then calculate
  /// the difference (date.timeZoneOffset - currentDate.timeZoneOffset)
  /// and add the offset difference(2-1) to current date.
  HijriDateTime addKeepTimeZoneOffset(Duration duration) {
    HijriDateTime newDate = add(duration);
    if (timeZoneOffset != newDate.timeZoneOffset) {
      newDate = newDate.add(timeZoneOffset - newDate.timeZoneOffset);
    }

    return newDate;
  }

  /// Subtract the date value with duration without daylight saving value
  ///
  /// eg., if local time zone as British Summer Time, and its daylight saving
  /// enabled on 29 March, 2020 to 25 October, 2020.
  /// subtract one day to the date(Oct 26, 2020) using subtract() method in
  /// [DateTime], it return Oct 25, 2020 1.00.00 instead of Oct 25, 2020 00.00.00
  /// because this method consider location
  /// and daylight saving.
  ///
  /// So check whether the current date time zone offset(+2) is equal to
  /// previous date time zone offset(+1). if both are not equal then calculate
  /// the difference date.timeZoneOffset - currentDate.timeZoneOffset) and add
  /// the offset difference(1-2) to current date.
  HijriDateTime subtractKeepTimeZoneOffset(Duration duration) {
    HijriDateTime newDate = subtract(duration);
    if (timeZoneOffset != newDate.timeZoneOffset) {
      newDate = newDate.add(timeZoneOffset - newDate.timeZoneOffset);
    }

    return newDate;
  }

  /// Returns the previous month's start date
  HijriDateTime getPreviousMonthDate() {
    return month == 1
        ? HijriDateTime(year - 1, 12, 01)
        : HijriDateTime(year, month - 1, 1);
  }

  /// Returns the next month's start date
  HijriDateTime getNextMonthDate() {
    return month == 12
        ? HijriDateTime(year + 1, 01, 01)
        : HijriDateTime(year, month + 1, 1);
  }

  /// Get a valid date after the [minDate]
  /// OR before the [maxDate]
  HijriDateTime getDateBetweenMinAndMax(
      HijriDateTime minDate, HijriDateTime maxDate) {
    if (isAfter(minDate)) {
      if (isBefore(maxDate)) {
        return this;
      } else {
        return maxDate;
      }
    } else {
      return minDate;
    }
  }

  // /// Determines if the given date is between the [minDate] and [maxDate]
  // bool isBetween(DateTime minDate, DateTime maxDate) {
  //   return isAfter(minDate) && isBefore(maxDate);
  // }

  /// Check if dates are equivalent
  bool isSameDate(HijriDateTime other) {
    if (other == this) {
      return true;
    }

    return month == other.month &&
        year == other.year &&
        day == other.day &&
        gregorianDate == other.gregorianDate;
  }

  /// Check the date in between first and last date
  bool isWithinDateRange(HijriDateTime startDate, HijriDateTime endDate) {
    if (startDate.isAfter(endDate)) {
      final HijriDateTime temp = startDate;
      startDate = endDate;
      endDate = temp;
    }

    if (isSameOrBeforeDate(endDate) && isSameOrAfterDate(startDate)) {
      return true;
    }

    return false;
  }

  /// Check if the date is before or same as [other]
  bool isSameOrBeforeDate(HijriDateTime other) {
    return isSameDate(other) || isBefore(other);
  }

  /// Check if the date is after or same as [other]
  bool isSameOrAfterDate(HijriDateTime other) {
    return isSameDate(other) || isAfter(other);
  }

  /// Get the visible dates based on the date value and visible dates count.
  List<HijriDateTime> getVisibleDates(
      List<int>? nonWorkingDays, int firstDayOfWeek, int visibleDatesCount) {
    final List<HijriDateTime> datesCollection = <HijriDateTime>[];

    final HijriDateTime currentDate =
        getFirstDayOfWeekDate(visibleDatesCount, firstDayOfWeek);

    for (int i = 0; i < visibleDatesCount; i++) {
      final HijriDateTime visibleDate = currentDate.addDays(i);
      if (nonWorkingDays != null &&
          nonWorkingDays.contains(visibleDate.weekday)) {
        continue;
      }

      datesCollection.add(visibleDate);
    }

    return datesCollection;
  }

  /// Add [days] to given [HijriDateTime]
  HijriDateTime addDays(int days) {
    return add(Duration(days: days));
  }

  /// Add [years] to given [HijriDateTime]
  HijriDateTime addYears(int years) {
    return add(Duration(days: years * _daysPerYear));
  }

  /// Add [decades] to given [HijriDateTime]
  HijriDateTime addDecades(int decades) {
    return add(Duration(days: decades * _daysPerDecade));
  }

  /// Add [centuries] to given [HijriDateTime]
  HijriDateTime addCenturies(int centuries) {
    return add(Duration(days: centuries * _daysPerCentury));
  }

  /// Calculate first day of week date value based original date with first day of
  /// week value.
  HijriDateTime getFirstDayOfWeekDate(
      int visibleDatesCount, int firstDayOfWeek) {
    if (visibleDatesCount % 7 != 0) {
      return this;
    }

    const int numberOfWeekDays = 7;
    HijriDateTime currentDate = this;
    if (visibleDatesCount == 42) {
      currentDate = HijriDateTime(currentDate.year, currentDate.month, 1);
    }

    int value = -currentDate.weekday + firstDayOfWeek - numberOfWeekDays;
    if (value.abs() >= numberOfWeekDays) {
      value += numberOfWeekDays;
    }

    currentDate = addDays(value);
    return currentDate;
  }
}
