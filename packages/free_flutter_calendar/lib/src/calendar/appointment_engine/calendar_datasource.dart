import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:free_flutter_calendar/src/calendar/appointment_engine/appointment_helper.dart';
import 'package:free_flutter_calendar/src/calendar/common/calendar_view_helper.dart';
import 'package:free_flutter_datepicker/datepicker.dart'
    show IterableDiagnostics;

import '../../../calendar.dart';
import '../common/enums.dart';
import '../resource_view/calendar_resource.dart';

/// An object that maintains the data source for [SfCalendar].
///
/// Allows to map the custom appointments to the [Appointment] and set the
/// appointments collection to the [SfCalendar] to render the appointments
/// on view.
///
/// Allows to add and remove an [Appointment] from the collection and also
/// allows to reset the appointment collection for [SfCalendar].
///
/// ```dart
///Widget build(BuildContext context) {
///   return Container(
///      child: SfCalendar(
///        view: CalendarView.day,
///        dataSource: _getCalendarDataSource(),
///      ),
///    );
///  }
///
/// class MeetingDataSource extends CalendarDataSource {
///  MeetingDataSource(List<_Meeting> source) {
///    appointments = source;
///  }
///
///  @override
///  DateTime getStartTime(int index) {
///    return appointments[index].from;
///  }
///
///  @override
///  DateTime getEndTime(int index) {
///    return appointments[index].to;
///  }
///
///  @override
///  Color getColor(int index) {
///    return appointments[index].background;
///  }
///
///  @override
///  String getEndTimeZone(int index) {
///    return appointments[index].toZone;
///  }
///
///  @override
///  List<DateTime> getRecurrenceExceptionDates(int index) {
///    return appointments[index].exceptionDates;
///  }
///
///  @override
///  String getRecurrenceRule(int index) {
///    return appointments[index].recurrenceRule;
///  }
///
///  @override
///  String getStartTimeZone(int index) {
///    return appointments[index].fromZone;
///  }
///
///  @override
///  String getSubject(int index) {
///    return appointments[index].title;
///  }
///
///  @override
///  bool isAllDay(int index) {
///    return appointments[index].isAllDay;
///  }
/// }
///
/// class Meeting {
///  Meeting(
///      {this.from,
///      this.to,
///      this.title,
///      this.isAllDay,
///      this.background,
///      this.fromZone,
///      this.toZone,
///      this.exceptionDates,
///      this.recurrenceRule});
///
///  DateTime from;
///  DateTime to;
///  String title;
///  bool isAllDay;
///  Color background;
///  String fromZone;
///  String toZone;
///  String recurrenceRule;
///  List<DateTime> exceptionDates;
/// }
///
/// final DateTime date = DateTime.now();
///  MeetingDataSource _getCalendarDataSource() {
///    List<Meeting> appointments = <Meeting>[];
///    appointments.add(Meeting(
///     from: date,
///     to: date.add(const Duration(hours: 1)),
///     title: 'General Meeting',
///     isAllDay: false,
///     background: Colors.red,
///     fromZone: '',
///     toZone: '',
///     recurrenceRule: '',
///     exceptionDates: null
///  ));
///
///    return MeetingDataSource(appointments);
///  }
///  ```
abstract class CalendarDataSource extends CalendarDataSourceChangeNotifier {
  /// Tha collection of appointments to be rendered on [SfCalendar].
  ///
  /// Defaults to `null`.
  ///
  /// ```dat
  ///
  /// class _AppointmentDataSource extends CalendarDataSource {
  ///  _AppointmentDataSource(List<Appointment> source) {
  ///    appointments = source;
  ///  }
  /// }
  ///```
  List<dynamic>? appointments;

  /// Returns the appointments in the specified date range.
  ///
  /// startDate - required - The starting date from which
  /// to obtain the appointments.
  ///
  /// endDate - optional - The end date till which
  /// to obtain the visible appointments.
  ///
  /// ```dart
  ///
  /// class MyAppState extends State<MyApp> {
  ///
  ///   CalendarController _calendarController;
  ///   _AppointmentDataSource _dataSource;
  ///
  ///   @override
  ///   initState() {
  ///     _calendarController = CalendarController();
  ///     _dataSource = _getCalendarDataSource();
  ///     super.initState();
  ///   }
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return MaterialApp(
  ///       home: Scaffold(
  ///         body: SfCalendar(
  ///           view: CalendarView.month,
  ///           controller: _calendarController,
  ///           dataSource: _dataSource,
  ///           onViewChanged: (ViewChangedDetails details) {
  ///             List<DateTime> dates = details.visibleDates;
  ///             String calendarTimeZone = '';
  ///             List<Object> appointment = _dataSource.getVisibleAppointments(
  ///                 dates[0], calendarTimeZone,
  ///                 dates[(details.visibleDates.length) - 1]);
  ///           },
  ///         ),
  ///       ),
  ///     );
  ///   }
  /// }
  ///
  /// _AppointmentDataSource _getCalendarDataSource() {
  ///   List<Appointment> appointments = <Appointment>[];
  ///   appointments.add(Appointment(
  ///     startTime: DateTime(2020, 11, 27, 9),
  ///     endTime: DateTime(2020, 11, 27, 9).add(Duration(hours: 2)),
  ///     subject: 'Meeting',
  ///     color: Colors.cyanAccent,
  ///     startTimeZone: '',
  ///     endTimeZone: '',
  ///     recurrenceRule: 'FREQ=DAILY;INTERVAL=2;COUNT=5',
  ///   ));
  ///   appointments.add(Appointment(
  ///       startTime: DateTime(2020, 11, 28, 5),
  ///       endTime: DateTime(2020, 11, 30, 7),
  ///       subject: 'Discussion',
  ///       color: Colors.orangeAccent,
  ///       startTimeZone: '',
  ///       endTimeZone: '',
  ///       isAllDay: true
  ///   ));
  ///   return _AppointmentDataSource(appointments);
  /// }}
  ///
  /// class _AppointmentDataSource extends CalendarDataSource {
  ///   _AppointmentDataSource(List<Appointment> source) {
  ///     appointments = source;
  ///   }
  /// }
  /// ```
  List<Appointment> getVisibleAppointments(
      DateTime startDate, String calendarTimeZone,
      [DateTime? endDate]) {
    endDate ??= startDate;

    /// Converts the given appointment type to calendar appointment, to handle
    /// the internal operations like timezone converting.
    /// Calendar appointment is an internal class to handle the appointment
    /// rendering on view.
    List<CalendarAppointment> calendarAppointments =
        AppointmentHelper.generateCalendarAppointments(this, calendarTimeZone);

    calendarAppointments = AppointmentHelper.getVisibleAppointments(
        startDate, endDate, calendarAppointments, calendarTimeZone, false,
        canCreateNewAppointment: false);

    final List<Appointment> visibleAppointments = <Appointment>[];

    for (int i = 0; i < calendarAppointments.length; i++) {
      visibleAppointments
          .add(calendarAppointments[i].convertToCalendarAppointment());
    }

    return visibleAppointments;
  }

  /// The collection of resource to be displayed in the timeline views of
  /// [SfCalendar].
  ///
  /// Defaults to `null`.
  ///
  /// ```dart
  ///
  /// class AppointmentDataSource extends CalendarDataSourceResource {
  ///    AppointmentDataSource(List<Appointment> appointments,
  ///                                 List<CalendarResource> resources) {
  ///    resources = resources;
  ///    appointments = appointments;
  ///  }
  /// }
  ///
  /// ```
  List<CalendarResource>? resources;

  /// Maps the custom appointments start time to the [Appointment].
  ///
  /// Allows to set the custom appointments corresponding property to the
  /// [Appointment]'s start time property.
  ///
  /// _Note:_ It is applicable only when the custom appointments set to the
  /// [appointments].
  ///
  /// It is mandatory to override this method to set custom appointments
  /// collection to the [appointments].
  ///
  /// See also: [Appointment.startTime]
  ///
  /// ```dart
  ///  @override
  ///  DateTime getStartTime(int index) {
  ///    return appointments[index].from;
  ///  }
  /// ```
  DateTime getStartTime(int index) => DateTime.now();

  /// Maps the custom appointments end time to the [Appointment].
  ///
  /// Allows to set the custom appointments corresponding property to the
  /// [Appointment]'s end time property.
  ///
  /// _Note:_ It is applicable only when the custom appointments set to the
  /// [appointments].
  ///
  /// It is mandatory to override this method to set custom appointments
  /// collection to the [appointments].
  ///
  /// See also: [Appointment.endTime]
  ///
  /// ```dart
  ///  @override
  ///  DateTime getEndTime(int index) {
  ///    return appointments[index].to;
  ///  }
  /// ```
  DateTime getEndTime(int index) => DateTime.now();

  /// Maps the custom appointments subject to the [Appointment].
  ///
  /// Allows to set the custom appointments corresponding property to the
  /// [Appointment]'s subject property.
  ///
  /// _Note:_ It is applicable only when the custom appointments set to the
  /// [appointments].
  ///
  /// See also: [Appointment.subject]
  ///
  /// ```dart
  ///  @override
  ///  DateTime getSubject(int index) {
  ///    return appointments[index].title;
  ///  }
  /// ```
  String getSubject(int index) => '';

  /// Maps the custom appointments isAllDay to the [Appointment].
  ///
  /// Allows to set the custom appointments corresponding property to the
  /// [Appointment]'s isAllDay property.
  ///
  /// _Note:_ It is applicable only when the custom appointments set to the
  /// [appointments].
  ///
  /// See also: [Appointment.isAllDay]
  ///
  /// ```dart
  ///  @override
  ///  DateTime isAllDay(int index) {
  ///    return appointments[index].isAllDay;
  ///  }
  /// ```
  bool isAllDay(int index) => false;

  /// Maps the custom appointments color to the [Appointment].
  ///
  /// Allows to set the custom appointments corresponding property to the
  /// [Appointment]'s color property.
  ///
  /// _Note:_ It is applicable only when the custom appointments set to the
  /// [appointments].
  ///
  /// See also: [Appointment.color]
  ///
  /// ```dart
  ///  @override
  ///  DateTime getColor(int index) {
  ///    return appointments[index].background;
  ///  }
  /// ```
  Color getColor(int index) => Colors.lightBlue;

  /// Maps the custom appointments notes to the [Appointment].
  ///
  /// Allows to set the custom appointments corresponding property to the
  /// [Appointment]'s notes property.
  ///
  /// _Note:_ It is applicable only when the custom appointments set to the
  /// [appointments].
  ///
  /// See also: [Appointment.notes]
  ///
  /// ```dart
  ///  @override
  ///  DateTime getNotes(int index) {
  ///    return appointments[index].notes;
  ///  }
  /// ```
  String? getNotes(int index) => null;

  /// Maps the custom appointments location to the [Appointment].
  ///
  /// Allows to set the custom appointments corresponding property to the
  /// [Appointment]'s location property.
  ///
  /// _Note:_ It is applicable only when the custom appointments set to the
  /// [appointments].
  ///
  /// See also: [Appointment.location].
  ///
  /// ```dart
  ///  @override
  ///  DateTime getLocation(int index) {
  ///    return appointments[index].place;
  ///  }
  /// ```
  String? getLocation(int index) => null;

  /// Maps the custom appointments start time zone to the [Appointment].
  ///
  /// Allows to set the custom appointments corresponding property to the
  /// [Appointment]'s start time zone property.
  ///
  /// _Note:_ It is applicable only when the custom appointments set to the
  /// [appointments].
  ///
  /// See also: [Appointment.startTimeZone].
  ///
  /// ```dart
  ///  @override
  ///  DateTime getStartTimeZone(int index) {
  ///    return appointments[index].fromZone;
  ///  }
  /// ```
  String? getStartTimeZone(int index) => null;

  /// Maps the custom appointments end time zone to the [Appointment].
  ///
  /// Allows to set the custom appointments corresponding property to the
  /// [Appointment]'s end time zone property.
  ///
  /// _Note:_ It is applicable only when the custom appointments set to the
  /// [appointments].
  ///
  /// See also: [Appointment.endTimeZone].
  ///
  /// ```dart
  ///  @override
  ///  DateTime getEndTimeZone(int index) {
  ///    return appointments[index].toZone;
  ///  }
  /// ```
  String? getEndTimeZone(int index) => null;

  /// Maps the custom appointments recurrence rule to the [Appointment].
  ///
  /// Allows to set the custom appointments corresponding property to the
  /// [Appointment]'s recurrence rule property.
  ///
  /// _Note:_ It is applicable only when the custom appointments set to the
  /// [appointments].
  ///
  /// See also: [Appointment.recurrenceRule].
  ///
  /// ```dart
  ///  @override
  ///  DateTime getRecurrenceRule(int index) {
  ///    return appointments[index].recurrenceRule;
  ///  }
  /// ```
  String? getRecurrenceRule(int index) => null;

  /// Maps the custom appointments recurrenceExceptionDates to the [Appointment]
  ///
  /// Allows to set the custom appointments corresponding property to the
  /// [Appointment]'s recurrenceExceptionDates property.
  ///
  /// _Note:_ It is applicable only when the custom appointments set to the
  /// [appointments].
  ///
  /// See also: [Appointment.recurrenceExceptionDates].
  ///
  /// ```dart
  ///  @override
  ///  DateTime getRecurrenceExceptionDates(int index) {
  ///    return appointments[index].exceptionDates;
  ///  }
  /// ```
  List<DateTime>? getRecurrenceExceptionDates(int index) => null;

  /// Maps the custom appointment resource ids to the [Appointment] resource
  /// ids.
  ///
  /// _Note:_ It is applicable only when the custom appointments set to the
  /// [appointments].
  ///
  /// See also:
  ///
  /// * [Appointment.resourceIds], the ids of the [CalendarResource] that shares
  /// this [Appointment].
  ///
  /// ```dart
  ///  @override
  ///  DateTime getResourceIds(int index) {
  ///    return appointments[index].resourceIds;
  ///  }
  /// ```
  List<Object>? getResourceIds(int index) => null;

  /// Called when loadMoreAppointments function is called from the
  /// loadMoreWidgetBuilder.
  /// Call the [notifyListeners] to notify the calendar for data source changes.
  ///
  /// See also: [SfCalendar.loadMoreWidgetBuilder]
  ///
  /// ```dart
  ///  @override
  ///  void handleLoadMore(DateTime startDate, DateTime endDate){
  ///  await Future.delayed(Duration(seconds: 5));
  ///    List<Appointment> newColl = <Appointment>[];
  ///    for (DateTime date = startDate;
  ///        date.isBefore(endDate);
  ///        date = date.add(Duration(days: 1))) {
  ///      newColl.add(Appointment(
  ///        startTime: date,
  ///        endTime: date.add(Duration(hours: 2)),
  ///        subject: 'Meeting',
  ///        color: Colors.red,
  ///      ));
  ///    }
  ///
  ///    appointments.addAll(newColl);
  ///    notifyListeners(CalendarDataSourceAction.add, newColl);
  ///  }
  /// ```
  @protected
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {}

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableDiagnostics<dynamic>(appointments)
        .toDiagnosticsNode(name: 'appointments'));
    properties.add(IterableDiagnostics<CalendarResource>(resources)
        .toDiagnosticsNode(name: 'resources'));
  }
}

/// Signature for callback that reports that a appointment collection set to the
/// [CalendarDataSource] modified.
///
/// See also: [CalendarDataSourceAction]
typedef CalendarDataSourceCallback = void Function(
    CalendarDataSourceAction, List<dynamic>);

/// Notifier used to notify the action performed in the [CalendarDataSource]
class CalendarDataSourceChangeNotifier with Diagnosticable {
  List<CalendarDataSourceCallback>? _listeners;

  /// Calls the listener every time the collection in the [CalendarDataSource]
  /// changed
  ///
  /// Listeners can be removed with [removeListener]
  void addListener(CalendarDataSourceCallback listener) {
    _listeners ??= <CalendarDataSourceCallback>[];
    _listeners!.add(listener);
  }

  /// remove the listener used for notify the data source changes.
  ///
  /// Stop calling the listener every time the the collection in
  /// [CalendarDataSource] changed.
  ///
  /// If `listener` is not currently registered as a listener, this method does
  /// nothing.
  ///
  /// Listeners can be added with [addListener].
  void removeListener(CalendarDataSourceCallback listener) {
    if (_listeners == null) {
      return;
    }

    _listeners!.remove(listener);
  }

  /// Call all the registered listeners.
  ///
  /// Call this method whenever the object changes, to notify any clients the
  /// object may have. Listeners that are added during this iteration will not
  /// be visited. Listeners that are removed during this iteration will not be
  /// visited after they are removed.
  ///
  /// Exceptions thrown by listeners will be caught and reported using
  /// [FlutterError.reportError].
  ///
  /// This method must not be called after [dispose] has been called.
  ///
  /// Surprising behavior can result when reentrantly removing a listener (i.e.
  /// in response to a notification) that has been registered multiple times.
  /// See the discussion at [removeListener].
  void notifyListeners(CalendarDataSourceAction type, List<dynamic> data) {
    if (_listeners == null) {
      return;
    }

    for (final CalendarDataSourceCallback listener in _listeners!) {
      listener(type, data);
    }
  }

  /// Discards any resources used by the object. After this is called, the
  /// object is not in a usable state and should be discarded (calls to
  /// [addListener] and [removeListener] will throw after the object is
  /// disposed).
  ///
  /// This method should only be called by the object's owner.
  @mustCallSuper
  void dispose() {
    _listeners = null;
  }
}
