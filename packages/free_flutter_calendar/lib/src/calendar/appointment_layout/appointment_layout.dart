import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:free_flutter_core/core.dart';
import 'package:free_flutter_core/localizations.dart';
import 'package:free_flutter_core/theme.dart';

import '../appointment_engine/appointment_helper.dart';
import '../appointment_engine/month_appointment_helper.dart';
import '../common/calendar_view_helper.dart';
import '../common/date_time_engine.dart';
import '../common/enums.dart';
import '../common/event_args.dart';
import '../resource_view/calendar_resource.dart';
import '../settings/time_slot_view_settings.dart';
import '../sfcalendar.dart';

/// Used to holds the appointment views in calendar widgets.
class AppointmentLayout extends StatefulWidget {
  /// Constructor to create the appointment layout that holds the appointment
  /// views in calendar widget.
  AppointmentLayout(
      this.calendar,
      this.view,
      this.visibleDates,
      this.visibleAppointments,
      this.timeIntervalHeight,
      this.calendarTheme,
      this.isRTL,
      this.appointmentHoverPosition,
      this.resourceCollection,
      this.resourceItemHeight,
      this.textScaleFactor,
      this.isMobilePlatform,
      this.width,
      this.height,
      this.localizations,
      this.updateCalendarState,
      {Key? key})
      : super(key: key);

  /// Holds the calendar instance used the get the properties of calendar.
  final SfCalendar calendar;

  /// Defines the current calendar view of the calendar widget.
  final CalendarView view;

  /// Holds the visible dates of the appointments view.
  final List<DateTime> visibleDates;

  /// Defines the time interval height of calendar and it used on day, week,
  /// workweek and timeline calendar views.
  final double timeIntervalHeight;

  /// Used to get the calendar state details.
  final UpdateCalendarState updateCalendarState;

  /// Defines the direction of the calendar widget is RTL or not.
  final bool isRTL;

  /// Holds the theme data of the calendar widget.
  final SfCalendarThemeData calendarTheme;

  /// Used to hold the appointment layout hovering position.
  final ValueNotifier<Offset?> appointmentHoverPosition;

  /// Holds the resource details of the calendar widget.
  final List<CalendarResource>? resourceCollection;

  /// Defines the resource item height of the calendar widget.
  final double? resourceItemHeight;

  /// Defines the scale factor of the calendar widget.
  final double textScaleFactor;

  /// Defines the current platform is mobile platform or not.
  final bool isMobilePlatform;

  /// Defines the width of the appointment layout widget.
  final double width;

  /// Defines the height of the appointment layout widget.
  final double height;

  /// Holds the localization data of the calendar widget.
  final SfLocalizations localizations;

  /// Holds the visible appointment collection of the calendar widget.
  final ValueNotifier<List<CalendarAppointment>?> visibleAppointments;

  /// Return the appointment view based on x and y position.
  AppointmentView? getAppointmentViewOnPoint(double x, double y) {
    // ignore: avoid_as
    final GlobalKey appointmentLayoutKey = key as GlobalKey;
    final _AppointmentLayoutState state =
        // ignore: avoid_as
        appointmentLayoutKey.currentState as _AppointmentLayoutState;
    return state._getAppointmentViewOnPoint(x, y);
  }

  @override
  _AppointmentLayoutState createState() => _AppointmentLayoutState();
}

class _AppointmentLayoutState extends State<AppointmentLayout> {
  /// It holds the appointment views for the visible appointments.
  List<AppointmentView> _appointmentCollection = <AppointmentView>[];

  /// It holds the appointment list based on its visible index value.
  Map<int, List<AppointmentView>> _indexAppointments =
      <int, List<AppointmentView>>{};

  /// It holds the more appointment index appointment counts based on its index.
  Map<int, RRect> _monthAppointmentCountViews = <int, RRect>{};

  /// It holds the children of the widget, it holds empty when
  /// appointment builder is null.
  List<Widget> _children = <Widget>[];

  final UpdateCalendarStateDetails _updateCalendarStateDetails =
      UpdateCalendarStateDetails();
  TextPainter _textPainter = TextPainter();

  @override
  void initState() {
    widget.updateCalendarState(_updateCalendarStateDetails);
    _updateAppointmentDetails();
    widget.visibleAppointments.addListener(_updateVisibleAppointment);
    super.initState();
  }

  @override
  void didUpdateWidget(AppointmentLayout oldWidget) {
    bool isAppointmentDetailsUpdated = false;
    if (widget.visibleDates != oldWidget.visibleDates ||
        widget.timeIntervalHeight != oldWidget.timeIntervalHeight ||
        widget.calendar != oldWidget.calendar ||
        widget.width != oldWidget.width ||
        widget.height != oldWidget.height ||
        (CalendarViewHelper.isTimelineView(widget.view) &&
            (widget.resourceCollection != oldWidget.resourceCollection ||
                widget.resourceItemHeight != oldWidget.resourceItemHeight))) {
      isAppointmentDetailsUpdated = true;
      _updateAppointmentDetails();
    }

    if (widget.visibleAppointments != oldWidget.visibleAppointments) {
      oldWidget.visibleAppointments.removeListener(_updateVisibleAppointment);
      widget.visibleAppointments.addListener(_updateVisibleAppointment);
      if (!CalendarViewHelper.isCollectionEqual(
              widget.visibleAppointments.value,
              oldWidget.visibleAppointments.value) &&
          !isAppointmentDetailsUpdated) {
        _updateAppointmentDetails();
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.visibleAppointments.removeListener(_updateVisibleAppointment);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Create the widgets when appointment builder is not null.
    if (_children.isEmpty && widget.calendar.appointmentBuilder != null) {
      for (int i = 0; i < _appointmentCollection.length; i++) {
        final AppointmentView appointmentView = _appointmentCollection[i];

        /// Check the appointment view have appointment, if not then the
        /// appointment view is not valid or it will be used for reusing view.
        if (appointmentView.appointment == null ||
            appointmentView.appointmentRect == null) {
          continue;
        }

        final DateTime date = DateTime(
            appointmentView.appointment!.actualStartTime.year,
            appointmentView.appointment!.actualStartTime.month,
            appointmentView.appointment!.actualStartTime.day);
        final Widget child = widget.calendar.appointmentBuilder!(
            context,
            CalendarAppointmentDetails(
                date,
                List.unmodifiable([
                  appointmentView.appointment!.data ??
                      appointmentView.appointment!
                ]),
                Rect.fromLTWH(
                    appointmentView.appointmentRect!.left,
                    appointmentView.appointmentRect!.top,
                    appointmentView.appointmentRect!.width,
                    appointmentView.appointmentRect!.height),
                isMoreAppointmentRegion: false));

        _children.add(RepaintBoundary(child: child));
      }

      if (_monthAppointmentCountViews.isNotEmpty) {
        final List<int> keys = _monthAppointmentCountViews.keys.toList();

        /// Get the more appointment index(more appointment index map holds more
        /// appointment needed cell index and it bound)
        for (int i = 0; i < keys.length; i++) {
          final int index = keys[i];
          final List<CalendarAppointment> moreAppointments =
              <CalendarAppointment>[];
          final List<AppointmentView> moreAppointmentViews =
              _indexAppointments[index]!;

          /// Get the appointments of the more appointment cell index from more
          /// appointment views.
          for (int j = 0; j < moreAppointmentViews.length; j++) {
            final AppointmentView currentAppointment = moreAppointmentViews[j];
            moreAppointments.add(currentAppointment.appointment!);
          }

          final DateTime date = widget.visibleDates[index];
          final RRect moreRegionRect = _monthAppointmentCountViews[index]!;
          final Widget child = widget.calendar.appointmentBuilder!(
              context,
              CalendarAppointmentDetails(
                  date,
                  List.unmodifiable(CalendarViewHelper.getCustomAppointments(
                      moreAppointments)),
                  Rect.fromLTWH(moreRegionRect.left, moreRegionRect.top,
                      moreRegionRect.width, moreRegionRect.height),
                  isMoreAppointmentRegion: true));

          /// Throw exception when builder return widget is null.
          _children.add(RepaintBoundary(child: child));
        }
      }
    }

    return _AppointmentRenderWidget(
        widget.calendar,
        widget.view,
        widget.visibleDates,
        widget.visibleAppointments.value,
        widget.timeIntervalHeight,
        widget.calendarTheme,
        widget.isRTL,
        widget.appointmentHoverPosition,
        widget.resourceCollection,
        widget.resourceItemHeight,
        widget.textScaleFactor,
        widget.isMobilePlatform,
        widget.width,
        widget.height,
        widget.localizations,
        _appointmentCollection,
        _indexAppointments,
        _monthAppointmentCountViews,
        widgets: _children);
  }

  AppointmentView? _getAppointmentViewOnPoint(double x, double y) {
    if (_appointmentCollection.isEmpty) {
      return null;
    }

    AppointmentView? selectedAppointmentView;
    for (int i = 0; i < _appointmentCollection.length; i++) {
      final AppointmentView appointmentView = _appointmentCollection[i];
      if (appointmentView.appointment != null &&
          appointmentView.appointmentRect != null &&
          appointmentView.appointmentRect!.left <= x &&
          appointmentView.appointmentRect!.right >= x &&
          appointmentView.appointmentRect!.top <= y &&
          appointmentView.appointmentRect!.bottom >= y) {
        selectedAppointmentView = appointmentView;
        break;
      }
    }

    if (selectedAppointmentView == null &&
        widget.view == CalendarView.month &&
        widget.calendar.monthViewSettings.appointmentDisplayMode ==
            MonthAppointmentDisplayMode.appointment) {
      final List<int> keys = _monthAppointmentCountViews.keys.toList();
      for (int i = 0; i < keys.length; i++) {
        final RRect? rect = _monthAppointmentCountViews[keys[i]]!;

        if (rect != null &&
            rect.left <= x &&
            rect.right >= x &&
            rect.top <= y &&
            rect.bottom >= y) {
          selectedAppointmentView = AppointmentView()..appointmentRect = rect;
          break;
        }
      }
    }

    return selectedAppointmentView;
  }

  void _updateVisibleAppointment() {
    widget.updateCalendarState(_updateCalendarStateDetails);
    if (!mounted) {
      return;
    }

    setState(() {
      _updateAppointmentDetails();
    });
  }

  /// Remove the appointments before the calendar time slot start date and
  /// after the calendar time slot  end date.
  List<CalendarAppointment> _getValidAppointments(
      List<CalendarAppointment> visibleAppointments) {
    if (visibleAppointments.isEmpty ||
        widget.view == CalendarView.month ||
        widget.view == CalendarView.timelineMonth) {
      return visibleAppointments;
    }

    final List<CalendarAppointment> appointments = <CalendarAppointment>[];
    final int viewStartHour =
        widget.calendar.timeSlotViewSettings.startHour.toInt();
    final int viewStartMinutes = (viewStartHour * 60) +
        ((widget.calendar.timeSlotViewSettings.startHour - viewStartHour) * 60)
            .toInt();
    final int viewEndHour =
        widget.calendar.timeSlotViewSettings.endHour.toInt();
    final int viewEndMinutes = (viewEndHour * 60) +
        ((widget.calendar.timeSlotViewSettings.endHour - viewEndHour) * 60)
            .toInt();

    for (int i = 0; i < visibleAppointments.length; i++) {
      final CalendarAppointment appointment = visibleAppointments[i];

      /// Skip the span appointment because span appointment will placed
      /// in between the valid hours(between time slot start and end hour).
      if (!isSameDate(appointment.actualEndTime, appointment.actualStartTime)) {
        /// Check the span appointment is start after time slot end hour and
        /// end before time slot start hour then skip the rendering.
        if (isSameDate(appointment.actualEndTime,
            appointment.actualStartTime.add(Duration(days: 1)))) {
          final int appointmentStartMinutes =
              (appointment.actualStartTime.hour * 60) +
                  appointment.actualStartTime.minute;
          final int appointmentEndMinutes =
              (appointment.actualEndTime.hour * 60) +
                  appointment.actualEndTime.minute;
          if (appointmentStartMinutes >= viewEndMinutes &&
              appointmentEndMinutes <= viewStartMinutes) {
            continue;
          }
        }

        appointments.add(appointment);
        continue;
      }
      final int appointmentStartMinutes =
          (appointment.actualStartTime.hour * 60) +
              appointment.actualStartTime.minute;
      final int appointmentEndMinutes = (appointment.actualEndTime.hour * 60) +
          appointment.actualEndTime.minute;

      /// Check the appointment before time slot start hour then skip the
      /// appointment rendering.
      if (appointmentStartMinutes < viewStartMinutes &&
          appointmentEndMinutes <= viewStartMinutes) {
        continue;
      }

      /// Check the appointment after time slot end hour then skip the
      /// appointment rendering.
      if (appointmentStartMinutes >= viewEndMinutes &&
          appointmentEndMinutes > viewEndMinutes) {
        continue;
      }

      appointments.add(appointment);
    }

    return appointments;
  }

  void _updateAppointmentDetails() {
    _monthAppointmentCountViews = <int, RRect>{};
    _indexAppointments = <int, List<AppointmentView>>{};
    widget.updateCalendarState(_updateCalendarStateDetails);
    AppointmentHelper.resetAppointmentView(_appointmentCollection);
    _children.clear();
    if (widget.visibleDates !=
        _updateCalendarStateDetails.currentViewVisibleDates) {
      return;
    }

    final List<CalendarAppointment> visibleAppointments =
        _getValidAppointments(widget.visibleAppointments.value!);
    switch (widget.view) {
      case CalendarView.month:
        {
          _updateMonthAppointmentDetails(visibleAppointments);
        }
        break;
      case CalendarView.day:
      case CalendarView.week:
      case CalendarView.workWeek:
        {
          _updateDayAppointmentDetails(visibleAppointments);
        }
        break;
      case CalendarView.timelineDay:
      case CalendarView.timelineWeek:
      case CalendarView.timelineWorkWeek:
        {
          _updateTimelineAppointmentDetails(visibleAppointments);
        }
        break;
      case CalendarView.timelineMonth:
        {
          _updateTimelineMonthAppointmentDetails(visibleAppointments);
        }
        break;
      case CalendarView.schedule:
        return;
    }
  }

  void _updateMonthAppointmentDetails(
      List<CalendarAppointment> visibleAppointments) {
    final double cellWidth = widget.width / DateTime.daysPerWeek;
    final double cellHeight =
        widget.height / widget.calendar.monthViewSettings.numberOfWeeksInView;
    if (widget.calendar.monthCellBuilder != null ||
        widget.calendar.monthViewSettings.appointmentDisplayMode !=
            MonthAppointmentDisplayMode.appointment) {
      return;
    }

    double xPosition = 0;
    double yPosition = 0;
    final int count = widget.visibleDates.length;
    DateTime visibleStartDate =
        AppointmentHelper.convertToStartTime(widget.visibleDates[0]);
    DateTime visibleEndDate =
        AppointmentHelper.convertToEndTime(widget.visibleDates[count - 1]);
    int visibleStartIndex = 0;
    int visibleEndIndex =
        (widget.calendar.monthViewSettings.numberOfWeeksInView *
                DateTime.daysPerWeek) -
            1;
    final bool showTrailingLeadingDates =
        CalendarViewHelper.isLeadingAndTrailingDatesVisible(
            widget.calendar.monthViewSettings.numberOfWeeksInView,
            widget.calendar.monthViewSettings.showTrailingAndLeadingDates);
    if (!showTrailingLeadingDates) {
      final DateTime currentMonthDate = widget.visibleDates[count ~/ 2];
      visibleStartDate = AppointmentHelper.convertToStartTime(
          AppointmentHelper.getMonthStartDate(currentMonthDate));
      visibleEndDate = AppointmentHelper.convertToEndTime(
          AppointmentHelper.getMonthEndDate(currentMonthDate));
      visibleStartIndex =
          DateTimeHelper.getIndex(widget.visibleDates, visibleStartDate);
      visibleEndIndex =
          DateTimeHelper.getIndex(widget.visibleDates, visibleEndDate);
    }

    MonthAppointmentHelper.updateAppointmentDetails(
        visibleAppointments,
        _appointmentCollection,
        widget.visibleDates,
        _indexAppointments,
        visibleStartIndex,
        visibleEndIndex);
    final TextStyle style =
        widget.calendar.todayTextStyle ?? widget.calendarTheme.todayTextStyle;
    final TextSpan dateText =
        TextSpan(text: DateTime.now().day.toString(), style: style);
    _textPainter = _updateTextPainter(
        dateText, _textPainter, widget.isRTL, widget.textScaleFactor);

    /// cell padding and start position calculated by month date cell
    /// rendering padding and size.
    /// Cell padding value includes month cell text top padding(5) and circle
    /// top(4) and bottom(4) padding
    const double cellPadding = 13;

    /// Today circle radius as circle radius added after the text height.
    const double todayCircleRadius = 5;
    final double startPosition =
        cellPadding + _textPainter.preferredLineHeight + todayCircleRadius;
    final int maximumDisplayCount =
        widget.calendar.monthViewSettings.appointmentDisplayCount;
    final double appointmentHeight =
        (cellHeight - startPosition) / maximumDisplayCount;
    // right side padding used to add padding on appointment view right side
    // in month view
    final double cellEndPadding = widget.calendar.cellEndPadding;
    for (int i = 0; i < _appointmentCollection.length; i++) {
      final AppointmentView appointmentView = _appointmentCollection[i];
      if (appointmentView.canReuse || appointmentView.appointment == null) {
        continue;
      }

      if (appointmentView.position < maximumDisplayCount ||
          (appointmentView.position == maximumDisplayCount &&
              appointmentView.maxPositions == maximumDisplayCount)) {
        final double appointmentWidth =
            (appointmentView.endIndex - appointmentView.startIndex + 1) *
                cellWidth;

        if (widget.isRTL) {
          xPosition =
              (6 - (appointmentView.startIndex % DateTime.daysPerWeek)) *
                  cellWidth;
          xPosition -= appointmentWidth - cellWidth;
        } else {
          xPosition =
              (appointmentView.startIndex % DateTime.daysPerWeek) * cellWidth;
        }

        yPosition =
            (appointmentView.startIndex ~/ DateTime.daysPerWeek) * cellHeight;
        if (appointmentView.position <= maximumDisplayCount) {
          yPosition = yPosition +
              startPosition +
              (appointmentHeight * (appointmentView.position - 1));
        } else {
          yPosition = yPosition +
              startPosition +
              (appointmentHeight * (maximumDisplayCount - 1));
        }

        final Radius cornerRadius = Radius.circular(
            (appointmentHeight * 0.1) > 2 ? 2 : (appointmentHeight * 0.1));
        final RRect rect = RRect.fromRectAndRadius(
            Rect.fromLTWH(
                widget.isRTL ? xPosition + cellEndPadding : xPosition,
                yPosition,
                appointmentWidth - cellEndPadding > 0
                    ? appointmentWidth - cellEndPadding
                    : 0,
                appointmentHeight > 1 ? appointmentHeight - 1 : 0),
            cornerRadius);

        appointmentView.appointmentRect = rect;
      }
    }

    final List<int> keys = _indexAppointments.keys.toList();
    for (int i = 0; i < keys.length; i++) {
      final int index = keys[i];
      final int maxPosition = _indexAppointments[index]!
          .reduce(
              (AppointmentView currentAppView, AppointmentView nextAppView) =>
                  currentAppView.maxPositions > nextAppView.maxPositions
                      ? currentAppView
                      : nextAppView)
          .maxPositions;
      if (maxPosition <= maximumDisplayCount) {
        continue;
      }
      if (widget.isRTL) {
        xPosition = (6 - (index % DateTime.daysPerWeek)) * cellWidth;
      } else {
        xPosition = (index % DateTime.daysPerWeek) * cellWidth;
      }

      yPosition = ((index ~/ DateTime.daysPerWeek) * cellHeight) +
          cellHeight -
          appointmentHeight;

      final RRect moreRegionRect = RRect.fromRectAndRadius(
          Rect.fromLTWH(
              widget.isRTL ? xPosition + cellEndPadding : xPosition,
              yPosition,
              cellWidth - cellEndPadding > 0 ? cellWidth - cellEndPadding : 0,
              appointmentHeight - 1),
          const Radius.circular(0));

      _monthAppointmentCountViews[index] = moreRegionRect;
    }
  }

  void _updateDayAppointmentDetails(
      List<CalendarAppointment> visibleAppointments) {
    final double timeLabelWidth = CalendarViewHelper.getTimeLabelWidth(
        widget.calendar.timeSlotViewSettings.timeRulerSize, widget.view);
    final double width = widget.width - timeLabelWidth;
    AppointmentHelper.setAppointmentPositionAndMaxPosition(
        _appointmentCollection,
        widget.calendar,
        widget.view,
        visibleAppointments,
        false,
        widget.timeIntervalHeight);
    final double cellWidth = width / widget.visibleDates.length;
    final double cellHeight = widget.timeIntervalHeight;
    double xPosition = timeLabelWidth;
    final double cellEndPadding = widget.calendar.cellEndPadding;

    final int timeInterval = CalendarViewHelper.getTimeInterval(
        widget.calendar.timeSlotViewSettings);
    final int viewStartHour =
        widget.calendar.timeSlotViewSettings.startHour.toInt();
    final double viewStartMinutes =
        (widget.calendar.timeSlotViewSettings.startHour - viewStartHour) * 60;

    for (int i = 0; i < _appointmentCollection.length; i++) {
      final AppointmentView appointmentView = _appointmentCollection[i];
      if (appointmentView.canReuse || appointmentView.appointment == null) {
        continue;
      }

      final CalendarAppointment appointment = appointmentView.appointment!;
      int column = -1;
      final int count = widget.visibleDates.length;

      for (int j = 0; j < count; j++) {
        final DateTime _date = widget.visibleDates[j];
        if (isSameDate(_date, appointment.actualStartTime)) {
          column = widget.isRTL ? widget.visibleDates.length - 1 - j : j;
          break;
        }
      }

      if (column == -1 ||
          appointment.isSpanned ||
          (appointment.endTime.difference(appointment.startTime).inDays > 0) ||
          appointment.isAllDay) {
        continue;
      }

      final int totalHours = appointment.actualStartTime.hour - viewStartHour;
      final double mins = appointment.actualStartTime.minute - viewStartMinutes;
      final int totalMins = ((totalHours * 60) + mins).toInt();

      final double appointmentWidth =
          (cellWidth - cellEndPadding) / appointmentView.maxPositions;
      if (widget.isRTL) {
        xPosition = column * cellWidth +
            (appointmentView.position * appointmentWidth) +
            cellEndPadding;
      } else {
        xPosition = column * cellWidth +
            (appointmentView.position * appointmentWidth) +
            timeLabelWidth;
      }

      Duration difference =
          appointment.actualEndTime.difference(appointment.actualStartTime);
      final double minuteHeight = cellHeight / timeInterval;
      double yPosition = totalMins * minuteHeight;

      double height = difference.inMinutes * minuteHeight;
      if (widget.calendar.timeSlotViewSettings.minimumAppointmentDuration !=
              null &&
          widget.calendar.timeSlotViewSettings.minimumAppointmentDuration!
                  .inMinutes >
              0) {
        if (difference <
                widget.calendar.timeSlotViewSettings
                    .minimumAppointmentDuration! &&
            difference.inMinutes * minuteHeight <
                widget.calendar.timeSlotViewSettings.timeIntervalHeight) {
          difference =
              widget.calendar.timeSlotViewSettings.minimumAppointmentDuration!;
          height = difference.inMinutes * minuteHeight;
          //// Check the minimum appointment duration height does not greater than time interval height.
          if (height >
              widget.calendar.timeSlotViewSettings.timeIntervalHeight) {
            height = widget.calendar.timeSlotViewSettings.timeIntervalHeight;
          }
        }
      }

      if (yPosition + height <= 0) {
        /// Skip the appointment rendering while the whole appointment placed
        /// before calendar start time.(Eg., appointment start and end date as
        /// 4 AM to 6 AM and the calendar start time is 8 AM then skip the
        /// rendering).
        continue;
      } else if (yPosition > widget.height) {
        /// Skip the appointment rendering while the whole appointment placed
        /// after calendar end time.(Eg., appointment start and end date as
        /// 8 PM to 9 PM and the calendar end time is 6 PM then skip the
        /// rendering).
        continue;
      } else if (yPosition + height > widget.height) {
        /// Change the height when appointment end time greater than calendar
        /// time slot end time(Eg., calendar end time is 4 PM and appointment
        /// end time is 6 PM then it takes more space and it hides span icon
        /// when the appointment is spanned)
        height = widget.height - yPosition;
      } else if (yPosition < 0) {
        /// Change the start position and height when appointment start time
        /// before the calendar start time and appointment end time after the
        /// calendar start time.(Eg., appointment start and end date as
        /// 6 AM to 9 AM and the calendar start time is 8 AM then calculate the
        /// new size from 8 AM to 9 AM, if we does not calculate the new size
        /// then the appointment text drawn on hidden place).
        height += yPosition;
        yPosition = 0;
      }

      final Radius cornerRadius =
          Radius.circular((height * 0.1) > 2 ? 2 : (height * 0.1));
      final RRect rect = RRect.fromRectAndRadius(
          Rect.fromLTWH(
              xPosition,
              yPosition,
              appointmentWidth > 1 ? appointmentWidth - 1 : 0,
              height > 1 ? height - 1 : 0),
          cornerRadius);
      appointmentView.appointmentRect = rect;
    }
  }

  void _updateTimelineMonthAppointmentDetails(
      List<CalendarAppointment> visibleAppointments) {
    final bool isResourceEnabled = CalendarViewHelper.isResourceEnabled(
        widget.calendar.dataSource, widget.view);

    /// Filters the appointment for each resource from the visible appointment
    /// collection, and assign appointment views for all the collections.
    if (isResourceEnabled) {
      for (int i = 0; i < widget.calendar.dataSource!.resources!.length; i++) {
        final CalendarResource resource =
            widget.calendar.dataSource!.resources![i];

        /// Filters the appointment for each resource from the visible
        /// appointment collection.
        final List<CalendarAppointment> appointmentForEachResource =
            visibleAppointments
                .where((app) =>
                    app.resourceIds != null &&
                    app.resourceIds!.isNotEmpty &&
                    app.resourceIds!.contains(resource.id))
                .toList();
        AppointmentHelper.setAppointmentPositionAndMaxPosition(
            _appointmentCollection,
            widget.calendar,
            widget.view,
            appointmentForEachResource,
            false,
            widget.timeIntervalHeight,
            i);
      }
    } else {
      AppointmentHelper.setAppointmentPositionAndMaxPosition(
          _appointmentCollection,
          widget.calendar,
          widget.view,
          visibleAppointments,
          false,
          widget.timeIntervalHeight);
    }

    final double viewWidth = widget.width / widget.visibleDates.length;
    final double cellWidth = widget.timeIntervalHeight;
    double xPosition = 0;
    double yPosition = 0;
    final double cellEndPadding = widget.calendar.cellEndPadding;
    final double slotHeight =
        isResourceEnabled ? widget.resourceItemHeight! : widget.height;
    for (int i = 0; i < _appointmentCollection.length; i++) {
      final AppointmentView appointmentView = _appointmentCollection[i];
      if (appointmentView.canReuse || appointmentView.appointment == null) {
        continue;
      }

      final CalendarAppointment appointment = appointmentView.appointment!;
      int column = -1;

      final DateTime startTime = appointment.actualStartTime;
      int index =
          DateTimeHelper.getVisibleDateIndex(widget.visibleDates, startTime);
      if (index == -1 && startTime.isBefore(widget.visibleDates[0])) {
        index = 0;
      }

      column = widget.isRTL ? widget.visibleDates.length - 1 - index : index;

      /// For timeline day, week and work week view each column represents a
      /// time slots for timeline month each column represent a day, and as
      /// rendering wise the column here represents the day hence the `-1`
      /// added in the above calculation not required for timeline month view,
      /// hence to rectify this we have added +1.
      if (widget.isRTL) {
        column += 1;
      }

      double appointmentHeight = _getTimelineAppointmentHeight(
          widget.calendar.timeSlotViewSettings, widget.view);
      if (appointmentHeight * appointmentView.maxPositions > slotHeight) {
        appointmentHeight = slotHeight / appointmentView.maxPositions;
      }

      xPosition = column * viewWidth;
      yPosition = appointmentHeight * appointmentView.position;
      if (isResourceEnabled &&
          appointment.resourceIds != null &&
          appointment.resourceIds!.isNotEmpty) {
        /// To render the appointment on specific resource slot, we have got the
        /// appointment's resource index  and calculated y position based on
        /// this.
        yPosition += appointmentView.resourceIndex * widget.resourceItemHeight!;
      }

      final DateTime endTime = appointment.actualEndTime;
      final Duration difference = endTime.difference(startTime);

      /// The width for the appointment UI, calculated based on the date
      /// difference between the start and end time of the appointment.
      double width = (difference.inDays + 1) * cellWidth;

      /// For span appointment less than 23 hours the difference will fall
      /// as 0 hence to render the appointment on the next day, added one
      /// the width for next day.
      if (difference.inDays == 0 && endTime.day != startTime.day) {
        width += cellWidth;
      }

      width = width - cellEndPadding;
      final Radius cornerRadius = Radius.circular(
          (appointmentHeight * 0.1) > 2 ? 2 : (appointmentHeight * 0.1));
      final RRect rect = RRect.fromRectAndRadius(
          Rect.fromLTWH(
              widget.isRTL ? xPosition - width : xPosition,
              yPosition,
              width > 0 ? width : 0,
              appointmentHeight > 1 ? appointmentHeight - 1 : 0),
          cornerRadius);
      appointmentView.appointmentRect = rect;
    }
  }

  void _updateTimelineAppointmentDetails(
      List<CalendarAppointment> visibleAppointments) {
    final bool isResourceEnabled = CalendarViewHelper.isResourceEnabled(
        widget.calendar.dataSource, widget.view);

    /// Filters the appointment for each resource from the visible appointment
    /// collection, and assign appointment views for all the collections.
    if (isResourceEnabled) {
      for (int i = 0; i < widget.calendar.dataSource!.resources!.length; i++) {
        final CalendarResource resource =
            widget.calendar.dataSource!.resources![i];

        /// Filters the appointment for each resource from the visible
        /// appointment collection.
        final List<CalendarAppointment> appointmentForEachResource =
            visibleAppointments
                .where((app) =>
                    app.resourceIds != null &&
                    app.resourceIds!.isNotEmpty &&
                    app.resourceIds!.contains(resource.id))
                .toList();
        AppointmentHelper.setAppointmentPositionAndMaxPosition(
            _appointmentCollection,
            widget.calendar,
            widget.view,
            appointmentForEachResource,
            false,
            widget.timeIntervalHeight,
            i);
      }
    } else {
      AppointmentHelper.setAppointmentPositionAndMaxPosition(
          _appointmentCollection,
          widget.calendar,
          widget.view,
          visibleAppointments,
          false,
          widget.timeIntervalHeight);
    }

    final double viewWidth = widget.width / widget.visibleDates.length;
    final double cellWidth = widget.timeIntervalHeight;
    double xPosition = 0;
    double yPosition = 0;
    final int count = widget.visibleDates.length;
    final int timeInterval = CalendarViewHelper.getTimeInterval(
        widget.calendar.timeSlotViewSettings);
    final double cellEndPadding = widget.calendar.cellEndPadding;
    final int viewStartHour =
        widget.calendar.timeSlotViewSettings.startHour.toInt();
    final double viewStartMinutes =
        (widget.calendar.timeSlotViewSettings.startHour - viewStartHour) * 60;
    for (int i = 0; i < _appointmentCollection.length; i++) {
      final AppointmentView appointmentView = _appointmentCollection[i];
      if (appointmentView.canReuse || appointmentView.appointment == null) {
        continue;
      }

      final CalendarAppointment appointment = appointmentView.appointment!;
      int column = -1;

      DateTime startTime = appointment.actualStartTime;
      for (int j = 0; j < count; j++) {
        final DateTime date = widget.visibleDates[j];
        if (isSameDate(date, startTime)) {
          column = j;
          break;
        } else if (startTime.isBefore(date)) {
          column = j;
          startTime = DateTime(date.year, date.month, date.day, 0, 0, 0);
          break;
        }
      }

      if (column == -1 &&
          appointment.actualStartTime.isBefore(widget.visibleDates[0])) {
        column = 0;
      }

      DateTime endTime = appointment.actualEndTime;
      int endColumn = -1;
      for (int j = 0; j < count; j++) {
        DateTime date = widget.visibleDates[j];
        if (isSameDate(date, endTime)) {
          endColumn = j;
          break;
        } else if (endTime.isBefore(date)) {
          endColumn = j - 1;
          if (endColumn != -1) {
            date = widget.visibleDates[endColumn];
            endTime = DateTime(date.year, date.month, date.day, 59, 59, 0);
          }
          break;
        }
      }

      if (endColumn == -1 &&
          appointment.actualEndTime
              .isAfter(widget.visibleDates[widget.visibleDates.length - 1])) {
        endColumn = widget.visibleDates.length - 1;
      }

      if (column == -1 || endColumn == -1) {
        continue;
      }

      int totalMinutes = (((startTime.hour - viewStartHour) * 60) +
              (startTime.minute - viewStartMinutes))
          .toInt();

      final double minuteHeight = cellWidth / timeInterval;

      double appointmentHeight = _getTimelineAppointmentHeight(
          widget.calendar.timeSlotViewSettings, widget.view);
      final double slotHeight =
          isResourceEnabled ? widget.resourceItemHeight! : widget.height;
      if (appointmentHeight * appointmentView.maxPositions > slotHeight) {
        appointmentHeight = slotHeight / appointmentView.maxPositions;
      }

      xPosition = column * viewWidth;
      double timePosition = totalMinutes * minuteHeight;
      if (timePosition < 0) {
        timePosition = 0;
      } else if (timePosition > viewWidth) {
        timePosition = viewWidth;
      }

      xPosition += timePosition;
      yPosition = appointmentHeight * appointmentView.position;
      if (isResourceEnabled &&
          appointment.resourceIds != null &&
          appointment.resourceIds!.isNotEmpty) {
        /// To render the appointment on specific resource slot, we have got the
        /// appointment's resource index  and calculated y position based on
        /// this.
        yPosition += appointmentView.resourceIndex * widget.resourceItemHeight!;
      }

      totalMinutes = (((endTime.hour - viewStartHour) * 60) +
              (endTime.minute - viewStartMinutes))
          .toInt();
      double endXPosition = endColumn * viewWidth;
      timePosition = totalMinutes * minuteHeight;
      if (timePosition < 0) {
        timePosition = 0;
      } else if (timePosition > viewWidth) {
        timePosition = viewWidth;
      }

      endXPosition += timePosition;
      double width = endXPosition - xPosition;
      xPosition = widget.isRTL ? widget.width - xPosition : xPosition;

      if (widget.calendar.timeSlotViewSettings.minimumAppointmentDuration !=
              null &&
          widget.calendar.timeSlotViewSettings.minimumAppointmentDuration! >
              appointment.actualEndTime
                  .difference(appointment.actualStartTime)) {
        final double minWidth =
            AppointmentHelper.getAppointmentHeightFromDuration(
                widget.calendar.timeSlotViewSettings.minimumAppointmentDuration,
                widget.calendar,
                widget.timeIntervalHeight);
        width = width > minWidth ? width : minWidth;
      }

      width = width - cellEndPadding;
      final Radius cornerRadius = Radius.circular(
          (appointmentHeight * 0.1) > 2 ? 2 : (appointmentHeight * 0.1));
      final RRect rect = RRect.fromRectAndRadius(
          Rect.fromLTWH(
              widget.isRTL ? xPosition - width : xPosition,
              yPosition,
              width > 0 ? width : 0,
              appointmentHeight > 1 ? appointmentHeight - 1 : 0),
          cornerRadius);
      appointmentView.appointmentRect = rect;
    }
  }

  /// Returns the  timeline appointment height based on the settings value.
  double _getTimelineAppointmentHeight(
      TimeSlotViewSettings settings, CalendarView view) {
    if (settings.timelineAppointmentHeight != -1) {
      return settings.timelineAppointmentHeight;
    }

    if (view == CalendarView.timelineMonth) {
      return 20;
    }

    return 60;
  }
}

class _AppointmentRenderWidget extends MultiChildRenderObjectWidget {
  _AppointmentRenderWidget(
      this.calendar,
      this.view,
      this.visibleDates,
      this.visibleAppointments,
      this.timeIntervalHeight,
      this.calendarTheme,
      this.isRTL,
      this.appointmentHoverPosition,
      this.resourceCollection,
      this.resourceItemHeight,
      this.textScaleFactor,
      this.isMobilePlatform,
      this.width,
      this.height,
      this.localizations,
      this.appointmentCollection,
      this.indexAppointments,
      this.monthAppointmentCountViews,
      {List<Widget> widgets = const <Widget>[]})
      : super(children: widgets);

  final SfCalendar calendar;
  final CalendarView view;
  final List<DateTime> visibleDates;
  final double timeIntervalHeight;
  final bool isRTL;
  final SfCalendarThemeData calendarTheme;
  final ValueNotifier<Offset?> appointmentHoverPosition;
  final List<CalendarResource>? resourceCollection;
  final double? resourceItemHeight;
  final double textScaleFactor;
  final bool isMobilePlatform;
  final double width;
  final double height;
  final SfLocalizations localizations;
  final List<CalendarAppointment>? visibleAppointments;
  final List<AppointmentView> appointmentCollection;
  final Map<int, List<AppointmentView>> indexAppointments;
  final Map<int, RRect> monthAppointmentCountViews;

  @override
  _AppointmentRenderObject createRenderObject(BuildContext context) {
    return _AppointmentRenderObject(
        calendar,
        view,
        visibleDates,
        visibleAppointments,
        timeIntervalHeight,
        calendarTheme,
        isRTL,
        appointmentHoverPosition,
        resourceCollection,
        resourceItemHeight,
        textScaleFactor,
        isMobilePlatform,
        width,
        height,
        localizations,
        appointmentCollection,
        indexAppointments,
        monthAppointmentCountViews);
  }

  @override
  void updateRenderObject(
      BuildContext context, _AppointmentRenderObject renderObject) {
    renderObject
      ..calendar = calendar
      ..view = view
      ..visibleDates = visibleDates
      ..visibleAppointments = visibleAppointments
      ..timeIntervalHeight = timeIntervalHeight
      ..calendarTheme = calendarTheme
      ..isRTL = isRTL
      ..appointmentHoverPosition = appointmentHoverPosition
      ..resourceCollection = resourceCollection
      ..resourceItemHeight = resourceItemHeight
      ..textScaleFactor = textScaleFactor
      ..isMobilePlatform = isMobilePlatform
      ..width = width
      ..height = height
      ..localizations = localizations
      ..appointmentCollection = appointmentCollection
      ..indexAppointments = indexAppointments
      ..monthAppointmentCountViews = monthAppointmentCountViews;
  }
}

class _AppointmentRenderObject extends CustomCalendarRenderObject {
  _AppointmentRenderObject(
      this._calendar,
      this._view,
      this._visibleDates,
      this._visibleAppointments,
      this._timeIntervalHeight,
      this._calendarTheme,
      this._isRTL,
      this._appointmentHoverPosition,
      this._resourceCollection,
      this._resourceItemHeight,
      this._textScaleFactor,
      this.isMobilePlatform,
      this._width,
      this._height,
      this._localizations,
      this.appointmentCollection,
      this.indexAppointments,
      this.monthAppointmentCountViews);

  List<CalendarAppointment>? _visibleAppointments;

  List<CalendarAppointment>? get visibleAppointments => _visibleAppointments;

  set visibleAppointments(List<CalendarAppointment>? value) {
    if (CalendarViewHelper.isCollectionEqual(_visibleAppointments, value)) {
      return;
    }

    _visibleAppointments = value;
    if (childCount == 0) {
      markNeedsPaint();
    } else {
      markNeedsLayout();
    }
  }

  ValueNotifier<Offset?> _appointmentHoverPosition;

  ValueNotifier<Offset?> get appointmentHoverPosition =>
      _appointmentHoverPosition;

  set appointmentHoverPosition(ValueNotifier<Offset?> value) {
    if (_appointmentHoverPosition == value) {
      return;
    }

    _appointmentHoverPosition.removeListener(markNeedsPaint);
    _appointmentHoverPosition = value;
    _appointmentHoverPosition.addListener(markNeedsPaint);
  }

  double _timeIntervalHeight;

  double get timeIntervalHeight => _timeIntervalHeight;

  set timeIntervalHeight(double value) {
    if (_timeIntervalHeight == value) {
      return;
    }

    _timeIntervalHeight = value;
    markNeedsLayout();
  }

  double _width;

  double get width => _width;

  set width(double value) {
    if (_width == value) {
      return;
    }

    _width = value;
    markNeedsLayout();
  }

  double _height;

  double get height => _height;

  set height(double value) {
    if (_height == value) {
      return;
    }

    _height = value;
    markNeedsLayout();
  }

  SfLocalizations _localizations;

  SfLocalizations get localizations => _localizations;

  set localizations(SfLocalizations value) {
    if (_localizations == value) {
      return;
    }

    _localizations = value;
    if (childCount != 0) {
      return;
    }

    markNeedsPaint();
  }

  double _textScaleFactor;

  double get textScaleFactor => _textScaleFactor;

  set textScaleFactor(double value) {
    if (_textScaleFactor == value) {
      return;
    }

    _textScaleFactor = value;
    markNeedsPaint();
  }

  SfCalendarThemeData _calendarTheme;

  SfCalendarThemeData get calendarTheme => _calendarTheme;

  set calendarTheme(SfCalendarThemeData value) {
    if (_calendarTheme == value) {
      return;
    }

    _calendarTheme = value;
    if (childCount != 0) {
      return;
    }

    markNeedsPaint();
  }

  List<DateTime> _visibleDates;

  List<DateTime> get visibleDates => _visibleDates;

  set visibleDates(List<DateTime> value) {
    if (_visibleDates == value) {
      return;
    }

    _visibleDates = value;
    if (childCount == 0) {
      markNeedsPaint();
    } else {
      markNeedsLayout();
    }
  }

  bool _isRTL;

  bool get isRTL => _isRTL;

  set isRTL(bool value) {
    if (_isRTL == value) {
      return;
    }

    _isRTL = value;
    markNeedsPaint();
  }

  double? _resourceItemHeight;

  double? get resourceItemHeight => _resourceItemHeight;

  set resourceItemHeight(double? value) {
    if (_resourceItemHeight == value) {
      return;
    }

    _resourceItemHeight = value;
    markNeedsLayout();
  }

  List<CalendarResource>? _resourceCollection;

  List<CalendarResource>? get resourceCollection => _resourceCollection;

  set resourceCollection(List<CalendarResource>? value) {
    if (_resourceCollection == value) {
      return;
    }

    _resourceCollection = value;
    markNeedsLayout();
  }

  CalendarView _view;

  CalendarView get view => _view;

  set view(CalendarView value) {
    if (_view == value) {
      return;
    }

    _view = value;
    markNeedsLayout();
  }

  SfCalendar _calendar;

  SfCalendar get calendar => _calendar;

  set calendar(SfCalendar value) {
    if (_calendar == value) {
      return;
    }

    _calendar = value;
    markNeedsLayout();
  }

  /// attach will called when the render object rendered in view.
  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _appointmentHoverPosition.addListener(markNeedsPaint);
  }

  /// detach will called when the render object removed from view.
  @override
  void detach() {
    _appointmentHoverPosition.removeListener(markNeedsPaint);
    super.detach();
  }

  bool isMobilePlatform;
  List<AppointmentView> appointmentCollection = <AppointmentView>[];
  Map<int, List<AppointmentView>> indexAppointments =
      <int, List<AppointmentView>>{};
  Map<int, RRect> monthAppointmentCountViews = <int, RRect>{};

  Paint _appointmentPainter = Paint();
  TextPainter _textPainter = TextPainter();

  @override
  bool get isRepaintBoundary => true;

  @override
  List<CustomPainterSemantics> Function(Size size) get semanticsBuilder =>
      _getSemanticsBuilder;

  List<CustomPainterSemantics> _getSemanticsBuilder(Size size) {
    final List<CustomPainterSemantics> semanticsBuilder =
        <CustomPainterSemantics>[];
    if (appointmentCollection.isEmpty) {
      return semanticsBuilder;
    }

    for (int i = 0; i < appointmentCollection.length; i++) {
      final AppointmentView appointmentView = appointmentCollection[i];
      if (appointmentView.appointment == null ||
          appointmentView.appointmentRect == null) {
        continue;
      }

      final Rect rect = appointmentView.appointmentRect!.outerRect;
      if (rect.height <= 0 || rect.width <= 0) {
        continue;
      }

      semanticsBuilder.add(CustomPainterSemantics(
        rect: rect,
        properties: SemanticsProperties(
          label: CalendarViewHelper.getAppointmentSemanticsText(
              appointmentView.appointment!),
          textDirection: TextDirection.ltr,
        ),
      ));
    }

    if (view != CalendarView.month ||
        calendar.monthViewSettings.appointmentDisplayMode !=
            MonthAppointmentDisplayMode.appointment) {
      return semanticsBuilder;
    }

    final List<int> keys = monthAppointmentCountViews.keys.toList();
    for (int i = 0; i < keys.length; i++) {
      final RRect moreRegionRect = monthAppointmentCountViews[keys[i]]!;
      final Rect rect = moreRegionRect.outerRect;
      if (rect.height <= 0 || rect.width <= 0) {
        continue;
      }

      semanticsBuilder.add(CustomPainterSemantics(
        rect: rect,
        properties: SemanticsProperties(
          label: 'More',
          textDirection: TextDirection.ltr,
        ),
      ));
    }

    return semanticsBuilder;
  }

  @override
  void performLayout() {
    final Size widgetSize = constraints.biggest;
    size = Size(widgetSize.width.isInfinite ? width : widgetSize.width,
        widgetSize.height.isInfinite ? height : widgetSize.height);
    RenderBox? child = firstChild;
    for (int i = 0; i < appointmentCollection.length; i++) {
      final AppointmentView appointmentView = appointmentCollection[i];
      if (appointmentView.appointment == null ||
          child == null ||
          appointmentView.appointmentRect == null) {
        continue;
      }

      child.layout(constraints.copyWith(
          minHeight: appointmentView.appointmentRect!.height,
          maxHeight: appointmentView.appointmentRect!.height,
          minWidth: appointmentView.appointmentRect!.width,
          maxWidth: appointmentView.appointmentRect!.width));
      child = childAfter(child);
    }

    if (view != CalendarView.month ||
        calendar.monthViewSettings.appointmentDisplayMode !=
            MonthAppointmentDisplayMode.appointment) {
      return;
    }

    final List<int> keys = monthAppointmentCountViews.keys.toList();
    for (int i = 0; i < keys.length; i++) {
      if (child == null) {
        continue;
      }

      final RRect moreRegionRect = monthAppointmentCountViews[keys[i]]!;
      child.layout(constraints.copyWith(
          minHeight: moreRegionRect.height,
          maxHeight: moreRegionRect.height,
          minWidth: moreRegionRect.width,
          maxWidth: moreRegionRect.width));
      child = childAfter(child);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;
    final bool isNeedDefaultPaint = childCount == 0;
    if (isNeedDefaultPaint) {
      _drawCustomAppointmentView(context.canvas);
    } else {
      for (int i = 0; i < appointmentCollection.length; i++) {
        final AppointmentView appointmentView = appointmentCollection[i];
        if (appointmentView.appointment == null ||
            child == null ||
            appointmentView.appointmentRect == null) {
          continue;
        }

        child.paint(
            context,
            Offset(appointmentView.appointmentRect!.left,
                appointmentView.appointmentRect!.top));
        _updateAppointmentHovering(
            appointmentView.appointmentRect!, context.canvas);

        child = childAfter(child);
      }

      if (view != CalendarView.month ||
          calendar.monthViewSettings.appointmentDisplayMode !=
              MonthAppointmentDisplayMode.appointment) {
        return;
      }

      final List<int> keys = monthAppointmentCountViews.keys.toList();
      for (int i = 0; i < keys.length; i++) {
        if (child == null) {
          continue;
        }

        final RRect moreRegionRect = monthAppointmentCountViews[keys[i]]!;
        child.paint(context, Offset(moreRegionRect.left, moreRegionRect.top));
        _updateAppointmentHovering(moreRegionRect, context.canvas);

        child = childAfter(child);
      }
    }
  }

  void _drawCustomAppointmentView(Canvas canvas) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    _appointmentPainter.isAntiAlias = true;
    switch (view) {
      case CalendarView.month:
        {
          _drawMonthAppointment(canvas, size, _appointmentPainter);
        }
        break;
      case CalendarView.day:
      case CalendarView.week:
      case CalendarView.workWeek:
        {
          _drawDayAppointments(canvas, size, _appointmentPainter);
        }
        break;
      case CalendarView.timelineDay:
      case CalendarView.timelineWeek:
      case CalendarView.timelineWorkWeek:
      case CalendarView.timelineMonth:
        {
          _drawTimelineAppointments(canvas, size, _appointmentPainter);
        }
        break;
      case CalendarView.schedule:
        return;
    }
  }

  void _drawMonthAppointment(Canvas canvas, Size size, Paint paint) {
    final double cellWidth = size.width / DateTime.daysPerWeek;
    final double cellHeight =
        size.height / calendar.monthViewSettings.numberOfWeeksInView;
    if (calendar.monthCellBuilder != null) {
      return;
    }

    switch (calendar.monthViewSettings.appointmentDisplayMode) {
      case MonthAppointmentDisplayMode.none:
        return;
      case MonthAppointmentDisplayMode.appointment:
        _drawMonthAppointmentView(canvas, size, cellWidth, cellHeight, paint);
        break;
      case MonthAppointmentDisplayMode.indicator:
        _drawMonthAppointmentIndicator(canvas, cellWidth, cellHeight, paint);
    }
  }

  void _drawMonthAppointmentView(Canvas canvas, Size size, double cellWidth,
      double cellHeight, Paint paint) {
    double xPosition = 0;
    final int count = visibleDates.length;
    DateTime visibleStartDate =
        AppointmentHelper.convertToStartTime(visibleDates[0]);
    DateTime visibleEndDate =
        AppointmentHelper.convertToEndTime(visibleDates[count - 1]);
    final bool showTrailingLeadingDates =
        CalendarViewHelper.isLeadingAndTrailingDatesVisible(
            calendar.monthViewSettings.numberOfWeeksInView,
            calendar.monthViewSettings.showTrailingAndLeadingDates);
    if (!showTrailingLeadingDates) {
      final DateTime currentMonthDate = visibleDates[count ~/ 2];
      visibleStartDate = AppointmentHelper.convertToStartTime(
          AppointmentHelper.getMonthStartDate(currentMonthDate));
      visibleEndDate = AppointmentHelper.convertToEndTime(
          AppointmentHelper.getMonthEndDate(currentMonthDate));
    }

    final int maximumDisplayCount =
        calendar.monthViewSettings.appointmentDisplayCount;
    double textSize = -1;
    // right side padding used to add padding on appointment view right side
    // in month view
    final bool useMobilePlatformUI =
        CalendarViewHelper.isMobileLayoutUI(size.width, isMobilePlatform);
    for (int i = 0; i < appointmentCollection.length; i++) {
      final AppointmentView appointmentView = appointmentCollection[i];
      if (appointmentView.canReuse ||
          appointmentView.appointment == null ||
          appointmentView.appointmentRect == null) {
        continue;
      }

      final RRect appointmentRect = appointmentView.appointmentRect!;
      if (appointmentView.position < maximumDisplayCount ||
          (appointmentView.position == maximumDisplayCount &&
              appointmentView.maxPositions == maximumDisplayCount)) {
        final CalendarAppointment appointment = appointmentView.appointment!;
        final bool canAddSpanIcon = AppointmentHelper.canAddSpanIcon(
            visibleDates, appointment, view,
            visibleStartDate: visibleStartDate,
            visibleEndDate: visibleEndDate,
            showTrailingLeadingDates: showTrailingLeadingDates);

        paint.color = appointment.color;
        TextStyle style = calendar.appointmentTextStyle;
        TextSpan span = TextSpan(text: appointment.subject, style: style);
        _textPainter =
            _updateTextPainter(span, _textPainter, isRTL, _textScaleFactor);

        if (textSize == -1) {
          //// left and right side padding value 2 subtracted in appointment width
          double maxTextWidth = appointmentRect.width - 2;
          maxTextWidth = maxTextWidth > 0 ? maxTextWidth : 0;
          for (double j = style.fontSize! - 1; j > 0; j--) {
            _textPainter.layout(minWidth: 0, maxWidth: maxTextWidth);
            if (_textPainter.height >= appointmentRect.height) {
              style = style.copyWith(fontSize: j);
              span = TextSpan(text: appointment.subject, style: style);
              _textPainter = _updateTextPainter(
                  span, _textPainter, isRTL, _textScaleFactor);
            } else {
              textSize = j + 1;
              break;
            }
          }
        } else {
          span = TextSpan(
              text: appointment.subject,
              style: style.copyWith(fontSize: textSize));
          _textPainter =
              _updateTextPainter(span, _textPainter, isRTL, _textScaleFactor);
        }

        canvas.drawRRect(appointmentRect, paint);

        final bool isRecurrenceAppointment =
            appointment.recurrenceRule != null &&
                appointment.recurrenceRule!.isNotEmpty;

        /// left and right side padding value subtracted in appointment width
        /// Recurrence icon width also subtracted in appointment text width
        /// when it recurrence appointment.
        final double textWidth =
            appointmentRect.width - (isRecurrenceAppointment ? textSize : 1);
        _textPainter.layout(
            minWidth: 0, maxWidth: textWidth > 0 ? textWidth : 0);
        xPosition = appointmentRect.left;
        final double yPosition = appointmentRect.top +
            ((appointmentRect.height - _textPainter.height) / 2);
        if (isRTL && !canAddSpanIcon) {
          xPosition += appointmentRect.width - _textPainter.width - 2;
        }

        if (canAddSpanIcon) {
          xPosition += (appointmentRect.width - _textPainter.width) / 2;
        }

        _textPainter.paint(canvas, Offset(xPosition + 2, yPosition));

        if (isRecurrenceAppointment) {
          _drawRecurrenceIconForMonth(
              canvas,
              size,
              style,
              textSize,
              appointmentRect,
              appointmentRect.tlRadius,
              paint,
              useMobilePlatformUI);
        }

        if (canAddSpanIcon) {
          final int appStartIndex = MonthAppointmentHelper.getDateIndex(
              appointment.exactStartTime, visibleDates);
          final int appEndIndex = MonthAppointmentHelper.getDateIndex(
              appointment.exactEndTime, visibleDates);
          if (appStartIndex == appointmentView.startIndex &&
              appEndIndex == appointmentView.endIndex) {
            continue;
          }

          if (appStartIndex != appointmentView.startIndex &&
              appEndIndex != appointmentView.endIndex) {
            _drawForwardSpanIconForMonth(
                canvas,
                size,
                style,
                textSize,
                appointmentRect,
                appointmentRect.tlRadius,
                paint,
                useMobilePlatformUI);
            _drawBackwardSpanIconForMonth(canvas, style, textSize,
                appointmentRect, appointmentRect.tlRadius, paint);
          } else if (appEndIndex != appointmentView.endIndex) {
            _drawForwardSpanIconForMonth(
                canvas,
                size,
                style,
                textSize,
                appointmentRect,
                appointmentRect.tlRadius,
                paint,
                useMobilePlatformUI);
          } else {
            _drawBackwardSpanIconForMonth(canvas, style, textSize,
                appointmentRect, appointmentRect.tlRadius, paint);
          }
        }

        _updateAppointmentHovering(appointmentRect, canvas);
      }
    }

    const double padding = 2;
    const double startPadding = 5;
    double? radius;

    final List<int> keys = monthAppointmentCountViews.keys.toList();
    for (int i = 0; i < keys.length; i++) {
      final int index = keys[i];
      final RRect moreRegionRect = monthAppointmentCountViews[index]!;
      if (radius == null) {
        radius = moreRegionRect.height * 0.12;
        if (radius > 3) {
          radius = 3;
        }
      }
      double startXPosition = isRTL
          ? moreRegionRect.right - startPadding
          : moreRegionRect.left + startPadding;
      paint.color = Colors.grey[600]!;
      for (int j = 0; j < 3; j++) {
        canvas.drawCircle(
            Offset(startXPosition,
                moreRegionRect.top + (moreRegionRect.height / 2)),
            radius,
            paint);
        if (isRTL) {
          startXPosition -= padding + (2 * radius);
        } else {
          startXPosition += padding + (2 * radius);
        }
      }

      _updateAppointmentHovering(moreRegionRect, canvas);
    }
  }

  void _drawForwardSpanIconForMonth(
      Canvas canvas,
      Size size,
      TextStyle style,
      double textSize,
      RRect rect,
      Radius cornerRadius,
      Paint paint,
      bool useMobilePlatformUI) {
    final TextSpan icon = AppointmentHelper.getSpanIcon(
        style.color!, textSize, isRTL ? false : true);
    _textPainter.text = icon;
    _textPainter.layout(
        minWidth: 0, maxWidth: rect.width + 1 > 0 ? rect.width + 1 : 0);

    final double yPosition =
        AppointmentHelper.getYPositionForSpanIcon(icon, _textPainter, rect);
    final double rightPadding = useMobilePlatformUI ? 0 : 2;
    final double xPosition = isRTL
        ? rect.left + rightPadding
        : rect.right - _textPainter.width - rightPadding;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTRB(xPosition, rect.top, xPosition + _textPainter.width,
                rect.bottom),
            cornerRadius),
        paint);
    _textPainter.paint(canvas, Offset(xPosition, yPosition));
  }

  void _drawBackwardSpanIconForMonth(Canvas canvas, TextStyle style,
      double textSize, RRect rect, Radius cornerRadius, Paint paint) {
    final TextSpan icon = AppointmentHelper.getSpanIcon(
        style.color!, textSize, isRTL ? true : false);
    _textPainter.text = icon;
    _textPainter.layout(
        minWidth: 0, maxWidth: rect.width + 1 > 0 ? rect.width + 1 : 0);

    final double yPosition =
        AppointmentHelper.getYPositionForSpanIcon(icon, _textPainter, rect);
    final double rightPadding = 2;
    final double xPosition =
        isRTL ? rect.right - textSize - rightPadding : rect.left + rightPadding;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTRB(
                xPosition, rect.top, xPosition + textSize, rect.bottom),
            cornerRadius),
        paint);
    _textPainter.paint(canvas, Offset(xPosition, yPosition));
  }

  void _drawRecurrenceIconForMonth(
      Canvas canvas,
      Size size,
      TextStyle style,
      double textSize,
      RRect rect,
      Radius cornerRadius,
      Paint paint,
      bool useMobilePlatformUI) {
    final TextSpan icon =
        AppointmentHelper.getRecurrenceIcon(style.color!, textSize);
    _textPainter.text = icon;
    _textPainter.layout(
        minWidth: 0, maxWidth: rect.width + 1 > 0 ? rect.width + 1 : 0);
    final double yPosition =
        rect.top + ((rect.height - _textPainter.height) / 2);
    final double rightPadding = useMobilePlatformUI ? 0 : 2;
    final double recurrenceStartPosition = isRTL
        ? rect.left + rightPadding
        : rect.right - _textPainter.width - rightPadding;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTRB(recurrenceStartPosition, yPosition,
                recurrenceStartPosition + _textPainter.width, rect.bottom),
            cornerRadius),
        paint);
    _textPainter.paint(canvas, Offset(recurrenceStartPosition, yPosition));
  }

  void _drawMonthAppointmentIndicator(
      Canvas canvas, double cellWidth, double cellHeight, Paint paint) {
    double xPosition = 0;
    double yPosition = 0;
    const double radius = 2.5;
    const double diameter = radius * 2;
    final double bottomPadding =
        cellHeight * 0.2 < radius ? radius : cellHeight * 0.2;
    final int visibleDatesCount = visibleDates.length;
    final int currentMonth = visibleDates[visibleDatesCount ~/ 2].month;
    final bool showTrailingLeadingDates =
        CalendarViewHelper.isLeadingAndTrailingDatesVisible(
            calendar.monthViewSettings.numberOfWeeksInView,
            calendar.monthViewSettings.showTrailingAndLeadingDates);

    for (int i = 0; i < visibleDatesCount; i++) {
      final DateTime currentVisibleDate = visibleDates[i];
      if (!showTrailingLeadingDates &&
          currentVisibleDate.month != currentMonth) {
        continue;
      }

      final List<CalendarAppointment> appointmentLists =
          _getSpecificDateVisibleAppointment(currentVisibleDate);
      appointmentLists.sort(
          (CalendarAppointment app1, CalendarAppointment app2) =>
              app1.actualStartTime.compareTo(app2.actualStartTime));
      appointmentLists.sort(
          (CalendarAppointment app1, CalendarAppointment app2) =>
              AppointmentHelper.orderAppointmentsAscending(
                  app1.isAllDay, app2.isAllDay));
      appointmentLists.sort(
          (CalendarAppointment app1, CalendarAppointment app2) =>
              AppointmentHelper.orderAppointmentsAscending(
                  app1.isSpanned, app2.isSpanned));
      final int count = appointmentLists.length <=
              calendar.monthViewSettings.appointmentDisplayCount
          ? appointmentLists.length
          : calendar.monthViewSettings.appointmentDisplayCount;
      const double indicatorPadding = 2;
      final double indicatorWidth =
          count * diameter + (count - 1) * indicatorPadding;
      if (indicatorWidth > cellWidth) {
        xPosition = indicatorPadding + radius;
      } else {
        final double difference = cellWidth - indicatorWidth;
        xPosition = (difference / 2) + radius;
      }

      double startXPosition = 0;
      if (isRTL) {
        startXPosition = (6 - (i % DateTime.daysPerWeek).toInt()) * cellWidth;
      } else {
        startXPosition = ((i % DateTime.daysPerWeek).toInt()) * cellWidth;
      }

      xPosition += startXPosition;
      yPosition = (((i / DateTime.daysPerWeek) + 1).toInt()) * cellHeight;
      for (int j = 0; j < count; j++) {
        paint.color = appointmentLists[j].color;
        canvas.drawCircle(
            Offset(xPosition, yPosition - bottomPadding), radius, paint);
        xPosition += diameter + indicatorPadding;
        if (startXPosition + cellWidth < xPosition + diameter) {
          break;
        }
      }
    }
  }

  /// Returns the specific date appointment collection by filtering the
  /// appointments from passed visible appointment collection.
  List<CalendarAppointment> _getSpecificDateVisibleAppointment(DateTime? date) {
    final List<CalendarAppointment> appointmentCollection =
        <CalendarAppointment>[];
    if (date == null || visibleAppointments == null) {
      return appointmentCollection;
    }

    final DateTime startDate = AppointmentHelper.convertToStartTime(date);
    final DateTime endDate = AppointmentHelper.convertToEndTime(date);

    for (int j = 0; j < visibleAppointments!.length; j++) {
      final CalendarAppointment appointment = visibleAppointments![j];
      if (AppointmentHelper.isAppointmentWithinVisibleDateRange(
          appointment, startDate, endDate)) {
        appointmentCollection.add(appointment);
      }
    }

    return appointmentCollection;
  }

  void _updateAppointmentHovering(RRect rect, Canvas canvas) {
    final Offset? hoverPosition = appointmentHoverPosition.value;
    if (hoverPosition == null) {
      return;
    }

    if (rect.left < hoverPosition.dx &&
        rect.right > hoverPosition.dx &&
        rect.top < hoverPosition.dy &&
        rect.bottom > hoverPosition.dy) {
      _appointmentPainter.color =
          calendarTheme.selectionBorderColor!.withOpacity(0.4);
      _appointmentPainter.strokeWidth = 2;
      _appointmentPainter.style = PaintingStyle.stroke;
      canvas.drawRect(rect.outerRect, _appointmentPainter);
      _appointmentPainter.style = PaintingStyle.fill;
    }
  }

  void _drawDayAppointments(Canvas canvas, Size size, Paint paint) {
    const int textStartPadding = 3;

    final bool useMobilePlatformUI =
        CalendarViewHelper.isMobileLayoutUI(size.width, isMobilePlatform);
    for (int i = 0; i < appointmentCollection.length; i++) {
      final AppointmentView appointmentView = appointmentCollection[i];
      if (appointmentView.canReuse ||
          appointmentView.appointmentRect == null ||
          appointmentView.appointment == null) {
        continue;
      }

      final CalendarAppointment appointment = appointmentView.appointment!;
      paint.color = appointment.color;
      final RRect appointmentRect = appointmentView.appointmentRect!;
      canvas.drawRRect(appointmentRect, paint);

      double xPosition = appointmentRect.left;
      double yPosition = appointmentRect.top;
      final bool canAddSpanIcon =
          AppointmentHelper.canAddSpanIcon(visibleDates, appointment, view);
      bool canAddForwardIcon = false;
      if (canAddSpanIcon) {
        if (CalendarViewHelper.isSameTimeSlot(
                appointment.exactStartTime, appointment.actualStartTime) &&
            !CalendarViewHelper.isSameTimeSlot(
                appointment.exactEndTime, appointment.actualEndTime)) {
          canAddForwardIcon = true;
        } else if (!CalendarViewHelper.isSameTimeSlot(
                appointment.exactStartTime, appointment.actualStartTime) &&
            CalendarViewHelper.isSameTimeSlot(
                appointment.exactEndTime, appointment.actualEndTime)) {
          yPosition += _getTextSize(appointmentRect,
              (calendar.appointmentTextStyle.fontSize! * textScaleFactor));
        }
      }

      final TextSpan span = TextSpan(
        text: appointment.subject,
        style: calendar.appointmentTextStyle,
      );

      _textPainter =
          _updateTextPainter(span, _textPainter, isRTL, _textScaleFactor);

      final double totalHeight = appointmentRect.height - textStartPadding;
      _updatePainterMaxLines(totalHeight);

      //// left and right side padding value 2 subtracted in appointment width
      double maxTextWidth = appointmentRect.width - textStartPadding;
      maxTextWidth = maxTextWidth > 0 ? maxTextWidth : 0;
      _textPainter.layout(minWidth: 0, maxWidth: maxTextWidth);

      /// minIntrinsicWidth property in text painter used to get the
      /// minimum text width of the text.
      /// eg., The text as 'Meeting' and it rendered in two lines and
      /// first line has 'Meet' text and second line has 'ing' text then it
      /// return second lines width.
      /// We are using the minIntrinsicWidth to restrict the text rendering
      /// when the appointment view bound does not hold single letter.
      final double textWidth = appointmentRect.width - textStartPadding;
      if (textWidth < _textPainter.minIntrinsicWidth &&
          textWidth < _textPainter.width &&
          textWidth <
              (calendar.appointmentTextStyle.fontSize ?? 15) *
                  textScaleFactor) {
        _updateAppointmentHovering(appointmentRect, canvas);

        continue;
      }

      if ((_textPainter.maxLines == 1 || _textPainter.maxLines == null) &&
          _textPainter.height > totalHeight) {
        _updateAppointmentHovering(appointmentRect, canvas);
        continue;
      }

      if (isRTL) {
        xPosition +=
            appointmentRect.width - textStartPadding - _textPainter.width;
      }

      _textPainter.paint(canvas,
          Offset(xPosition + textStartPadding, yPosition + textStartPadding));
      if (appointment.recurrenceRule != null &&
          appointment.recurrenceRule!.isNotEmpty) {
        _addRecurrenceIconForDay(
            canvas,
            size,
            appointmentRect,
            appointmentRect.width,
            textStartPadding,
            paint,
            appointmentRect.tlRadius,
            useMobilePlatformUI);
      }

      if (canAddSpanIcon) {
        if (canAddForwardIcon) {
          _addForwardSpanIconForDay(
              canvas, appointmentRect, size, appointmentRect.tlRadius, paint);
        } else {
          _addBackwardSpanIconForDay(
              canvas, appointmentRect, size, appointmentRect.tlRadius, paint);
        }
      }

      _updateAppointmentHovering(appointmentRect, canvas);
    }
  }

  void _addBackwardSpanIconForDay(
      Canvas canvas, RRect rect, Size size, Radius cornerRadius, Paint paint) {
    canvas.save();
    const double bottomPadding = 2;
    final double textSize =
        _getTextSize(rect, calendar.appointmentTextStyle.fontSize!);
    final TextSpan icon = AppointmentHelper.getSpanIcon(
        calendar.appointmentTextStyle.color!, textSize, false);
    _textPainter =
        _updateTextPainter(icon, _textPainter, isRTL, _textScaleFactor);
    _textPainter.layout(minWidth: 0, maxWidth: rect.width);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTRB(
                rect.left, rect.top, rect.right, rect.top + _textPainter.width),
            cornerRadius),
        paint);

    final double xPosition = _getXPositionForSpanIconForDay(icon, rect);

    final double yPosition = rect.top + bottomPadding;
    canvas.translate(xPosition, yPosition);
    final radians = 90 * math.pi / 180;
    canvas.rotate(radians);
    _textPainter.paint(canvas, Offset(0, 0));
    canvas.restore();
  }

  double _getXPositionForSpanIconForDay(TextSpan icon, RRect rect) {
    /// There is a space around the font, hence to get the start position we
    /// must calculate the icon start position, apart from the space, and the
    /// value 1.5 used since the space on top and bottom of icon is not even,
    /// hence to rectify this tha value 1.5 used, and tested with multiple
    /// device.
    final double iconStartPosition =
        (_textPainter.height - (icon.style!.fontSize! * textScaleFactor)) / 1.5;
    return rect.left +
        (rect.width - _textPainter.height) / 2 +
        _textPainter.height +
        iconStartPosition;
  }

  void _addForwardSpanIconForDay(
      Canvas canvas, RRect rect, Size size, Radius cornerRadius, Paint paint) {
    canvas.save();
    const double bottomPadding = 2;
    final double textSize =
        _getTextSize(rect, calendar.appointmentTextStyle.fontSize!);
    final TextSpan icon = AppointmentHelper.getSpanIcon(
        calendar.appointmentTextStyle.color!, textSize, true);
    _textPainter =
        _updateTextPainter(icon, _textPainter, isRTL, _textScaleFactor);
    _textPainter.layout(minWidth: 0, maxWidth: rect.width);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTRB(rect.left, rect.bottom - _textPainter.width,
                rect.right, rect.bottom),
            cornerRadius),
        paint);

    final double xPosition = _getXPositionForSpanIconForDay(icon, rect);
    final double yPosition =
        rect.bottom - (textSize * textScaleFactor) - bottomPadding;
    canvas.translate(xPosition, yPosition);
    final radians = 90 * math.pi / 180;
    canvas.rotate(radians);
    _textPainter.paint(canvas, Offset(0, 0));
    canvas.restore();
  }

  void _updatePainterMaxLines(double height) {
    /// [preferredLineHeight] is used to get the line height based on text
    /// style and text. floor the calculated value to set the minimum line
    /// count to painter max lines property.
    final int maxLines = (height / _textPainter.preferredLineHeight).floor();
    if (maxLines <= 0) {
      return;
    }

    _textPainter.maxLines = maxLines;
  }

  void _addRecurrenceIconForDay(
      Canvas canvas,
      Size size,
      RRect rect,
      double appointmentWidth,
      int textPadding,
      Paint paint,
      Radius cornerRadius,
      bool useMobilePlatformUI) {
    final double xPadding = useMobilePlatformUI ? 1 : 2;
    const double bottomPadding = 2;
    double textSize = calendar.appointmentTextStyle.fontSize!;
    if (rect.width < textSize || rect.height < textSize) {
      textSize = rect.width > rect.height ? rect.height : rect.width;
    }

    final TextSpan icon = AppointmentHelper.getRecurrenceIcon(
        calendar.appointmentTextStyle.color!, textSize);
    _textPainter.text = icon;
    double maxTextWidth = appointmentWidth - textPadding - 2;
    maxTextWidth = maxTextWidth > 0 ? maxTextWidth : 0;
    _textPainter.layout(minWidth: 0, maxWidth: maxTextWidth);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTRB(
                isRTL
                    ? rect.left + textSize + xPadding
                    : rect.right - textSize - xPadding,
                rect.bottom - bottomPadding - textSize,
                isRTL ? rect.left : rect.right,
                rect.bottom),
            cornerRadius),
        paint);
    _textPainter.paint(
        canvas,
        Offset(isRTL ? rect.left + xPadding : rect.right - textSize - xPadding,
            rect.bottom - bottomPadding - textSize));
  }

  void _drawTimelineAppointments(Canvas canvas, Size size, Paint paint) {
    const int textStartPadding = 3;
    final bool useMobilePlatformUI =
        CalendarViewHelper.isMobileLayoutUI(size.width, isMobilePlatform);
    for (int i = 0; i < appointmentCollection.length; i++) {
      final AppointmentView appointmentView = appointmentCollection[i];
      if (appointmentView.canReuse ||
          appointmentView.appointmentRect == null ||
          appointmentView.appointment == null) {
        continue;
      }

      final CalendarAppointment appointment = appointmentView.appointment!;
      paint.color = appointment.color;
      final RRect appointmentRect = appointmentView.appointmentRect!;
      canvas.drawRRect(appointmentRect, paint);
      final bool canAddSpanIcon =
          AppointmentHelper.canAddSpanIcon(visibleDates, appointment, view);
      bool canAddForwardIcon = false;
      bool canAddBackwardIcon = false;

      double xPosition = isRTL ? appointmentRect.right : appointmentRect.left;
      double maxWidth = appointmentRect.width - textStartPadding;
      maxWidth = maxWidth > 0 ? maxWidth : 0;

      if (canAddSpanIcon) {
        final DateTime appStartTime = appointment.exactStartTime;
        final DateTime appEndTime = appointment.exactEndTime;
        final DateTime viewStartDate =
            AppointmentHelper.convertToStartTime(visibleDates[0]);
        final DateTime viewEndDate = AppointmentHelper.convertToEndTime(
            visibleDates[visibleDates.length - 1]);
        double? iconSize = _getTextSize(appointmentRect,
                (calendar.appointmentTextStyle.fontSize! * textScaleFactor)) +
            textStartPadding;
        if (AppointmentHelper.canAddForwardSpanIcon(
            appStartTime, appEndTime, viewStartDate, viewEndDate)) {
          canAddForwardIcon = true;
          iconSize = null;
        } else if (AppointmentHelper.canAddBackwardSpanIcon(
            appStartTime, appEndTime, viewStartDate, viewEndDate)) {
          canAddBackwardIcon = true;
        } else {
          canAddForwardIcon = true;
          canAddBackwardIcon = true;
        }

        if (iconSize != null) {
          if (isRTL) {
            xPosition -= iconSize;
          } else {
            xPosition += iconSize;
          }
        }
      }

      final TextSpan span = TextSpan(
        text: _getTimelineAppointmentText(appointment, canAddSpanIcon),
        style: calendar.appointmentTextStyle,
      );

      _textPainter =
          _updateTextPainter(span, _textPainter, isRTL, _textScaleFactor);
      final double totalHeight = appointmentRect.height - textStartPadding - 2;
      _updatePainterMaxLines(totalHeight);

      /// In RTL, when the text wraps into multiple line the tine width is
      /// smaller than the expected when we use the
      /// 'TextWidthBasis.longestLine]` which renders the subject text out of
      /// the appointment rect, hence to overcome this we have added checked
      /// this condition and set the text width basis.
      if (view == CalendarView.timelineMonth) {
        _textPainter.textWidthBasis = TextWidthBasis.parent;
      }

      //// left and right side padding value 2 subtracted in appointment width
      _textPainter.layout(minWidth: 0, maxWidth: maxWidth);
      if ((_textPainter.maxLines == null || _textPainter.maxLines == 1) &&
          _textPainter.height > totalHeight) {
        _updateAppointmentHovering(appointmentRect, canvas);
        continue;
      }

      if (isRTL) {
        if (canAddSpanIcon) {
          xPosition -= textStartPadding;
        }

        xPosition -= _textPainter.width + textStartPadding + 2;
      }

      _textPainter.paint(
          canvas,
          Offset(xPosition + textStartPadding,
              appointmentRect.top + textStartPadding));
      if (appointment.recurrenceRule != null &&
          appointment.recurrenceRule!.isNotEmpty) {
        _addRecurrenceIconForTimeline(canvas, size, appointmentRect, maxWidth,
            appointmentRect.tlRadius, paint, useMobilePlatformUI);
      }

      if (canAddSpanIcon) {
        if (canAddForwardIcon && canAddBackwardIcon) {
          _addForwardSpanIconForTimeline(canvas, size, appointmentRect,
              maxWidth, appointmentRect.tlRadius, paint, isMobilePlatform);
          _addBackwardSpanIconForTimeline(canvas, size, appointmentRect,
              maxWidth, appointmentRect.tlRadius, paint, isMobilePlatform);
        } else if (canAddForwardIcon) {
          _addForwardSpanIconForTimeline(canvas, size, appointmentRect,
              maxWidth, appointmentRect.tlRadius, paint, isMobilePlatform);
        } else {
          _addBackwardSpanIconForTimeline(canvas, size, appointmentRect,
              maxWidth, appointmentRect.tlRadius, paint, isMobilePlatform);
        }
      }

      _updateAppointmentHovering(appointmentRect, canvas);
    }
  }

  /// To display the different text on spanning appointment for timeline day
  /// view, for other views we just display the subject of the appointment and
  /// for timeline day view  we display the current date, and total dates of the
  ///  spanning appointment.
  String _getTimelineAppointmentText(
      CalendarAppointment appointment, bool canAddSpanIcon) {
    if (view != CalendarView.timelineDay || !canAddSpanIcon) {
      return appointment.subject;
    }

    return AppointmentHelper.getSpanAppointmentText(
        appointment, visibleDates[0], _localizations);
  }

  double _getTextSize(RRect rect, double textSize) {
    if (rect.width < textSize || rect.height < textSize) {
      return rect.width > rect.height ? rect.height : rect.width;
    }

    return textSize;
  }

  double _getYPositionForSpanIconInTimeline(
      TextSpan icon, RRect rect, double xPadding, bool isMobilePlatform) {
    /// There is a space around the font, hence to get the start position we
    /// must calculate the icon start position, apart from the space, and the
    /// value 2 used since the space on top and bottom of icon is not even,
    /// hence to rectify this tha value 2 used, and tested with multiple
    /// device.
    final double iconStartPosition =
        (_textPainter.height - (icon.style!.fontSize! * textScaleFactor) / 2) /
            2;
    return rect.top - iconStartPosition + (isMobilePlatform ? 1 : xPadding);
  }

  void _addForwardSpanIconForTimeline(
      Canvas canvas,
      Size size,
      RRect rect,
      double maxWidth,
      Radius cornerRadius,
      Paint paint,
      bool isMobilePlatform) {
    final double xPadding = 2;
    final double textSize =
        _getTextSize(rect, calendar.appointmentTextStyle.fontSize!);

    final TextSpan icon = AppointmentHelper.getSpanIcon(
        calendar.appointmentTextStyle.color!, textSize, isRTL ? false : true);
    _textPainter =
        _updateTextPainter(icon, _textPainter, isRTL, _textScaleFactor);
    _textPainter.layout(minWidth: 0, maxWidth: maxWidth);
    final double xPosition = isRTL
        ? rect.left + xPadding
        : rect.right - _textPainter.width - xPadding;

    final double yPosition = _getYPositionForSpanIconInTimeline(
        icon, rect, xPadding, isMobilePlatform);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTRB(xPosition, rect.top + 1,
                isRTL ? rect.left : rect.right, rect.bottom),
            cornerRadius),
        paint);
    _textPainter.paint(canvas, Offset(xPosition, yPosition));
  }

  void _addBackwardSpanIconForTimeline(
      Canvas canvas,
      Size size,
      RRect rect,
      double maxWidth,
      Radius cornerRadius,
      Paint paint,
      bool isMobilePlatform) {
    final double xPadding = 2;
    final double textSize =
        _getTextSize(rect, calendar.appointmentTextStyle.fontSize!);

    final TextSpan icon = AppointmentHelper.getSpanIcon(
        calendar.appointmentTextStyle.color!, textSize, isRTL ? true : false);
    _textPainter =
        _updateTextPainter(icon, _textPainter, isRTL, _textScaleFactor);
    _textPainter.layout(minWidth: 0, maxWidth: maxWidth);
    final double xPosition = isRTL
        ? rect.right - _textPainter.width - xPadding
        : rect.left + xPadding;

    final double yPosition = _getYPositionForSpanIconInTimeline(
        icon, rect, xPadding, isMobilePlatform);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTRB(xPosition, rect.top + 1,
                isRTL ? rect.right : rect.left, rect.bottom),
            cornerRadius),
        paint);
    _textPainter.paint(canvas, Offset(xPosition, yPosition));
  }

  void _addRecurrenceIconForTimeline(
      Canvas canvas,
      Size size,
      RRect rect,
      double maxWidth,
      Radius cornerRadius,
      Paint paint,
      bool useMobilePlatformUI) {
    final double xPadding = useMobilePlatformUI ? 1 : 2;
    const double bottomPadding = 2;
    final double textSize =
        _getTextSize(rect, calendar.appointmentTextStyle.fontSize!);

    final TextSpan icon = AppointmentHelper.getRecurrenceIcon(
        calendar.appointmentTextStyle.color!, textSize);
    _textPainter.text = icon;
    _textPainter.layout(minWidth: 0, maxWidth: maxWidth);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTRB(
                isRTL ? rect.left + xPadding : rect.right - textSize - xPadding,
                rect.bottom - bottomPadding - textSize,
                isRTL ? rect.left : rect.right,
                rect.bottom),
            cornerRadius),
        paint);
    _textPainter.paint(
        canvas,
        Offset(isRTL ? rect.left + xPadding : rect.right - textSize - xPadding,
            rect.bottom - bottomPadding - textSize));
  }
}

TextPainter _updateTextPainter(TextSpan span, TextPainter textPainter,
    bool isRTL, double textScaleFactor) {
  textPainter.text = span;
  textPainter.maxLines = 1;
  textPainter.textDirection = TextDirection.ltr;
  textPainter.textAlign = isRTL ? TextAlign.right : TextAlign.left;
  textPainter.textWidthBasis = TextWidthBasis.longestLine;
  textPainter.textScaleFactor = textScaleFactor;
  return textPainter;
}
