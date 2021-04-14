![free_flutter_datepicker_banner](https://cdn.syncfusion.com/content/images/FTControl/Flutter/datepicker.jpg)

# Flutter Date Range Picker

The Flutter Date Range Picker is a lightweight widget that allows users to easily select a single date, multiple dates, or a range of dates. Date Picker provides month, year, decade, and century view options to quickly navigate to the desired date. It supports minimum, maximum, blackout and disabled dates to restrict date selection.

**Disclaimer**: This is a commercial package. To use this package, you need to have either a Syncfusion commercial license or [Free Syncfusion Community license](https://www.syncfusion.com/products/communitylicense). For more details, please check the [LICENSE](https://github.com/syncfusion/flutter-examples/blob/master/LICENSE) file.

## Table of contents

- [Date range picker features](#date-range-picker-features)
- [Get the demo application](#get-the-demo-application)
- [Useful links](#other-useful-links)
- [Installation](#installation)
- [Getting started](#getting-started)
    - [Add date range picker widget to widget tree](#add-date-range-picker-to-the-widget-tree)
    - [Change different date range picker views](#change-different-date-range-picker-views)
    - [Change first day of week](#change-first-day-of-week)
    - [Date selection](#date-selection)
    - [Limit the date selection range](#limit-the-date-selection-range)
- [Support and feedback](#support-and-feedback)
- [About Syncfusion](#about-syncfusion)

##  Date-range-picker features

* **Multiple picker views** - Display month, year, decade, and century views that allow users to easily select and navigate between built-in views. Supports programmatic navigation.  

![multiple_picker_views](https://cdn.syncfusion.com/content/images/FTControl/Flutter/daterangepicker/picker_views.png)

* **Multi-date picker view** - Display two Date Range Pickers side by side, allowing you to select ranges of dates within two separate months easily.

![multi_date_picker_view](https://cdn.syncfusion.com/content/images/FTControl/Flutter/flutter-daterangepicker-multidatepicker.png)

* **Vertical picker** - Displays two Date Range Pickers side by side in the vertical direction, allowing you to select date ranges between two months easily. Also enable or disable the view navigation using swipe interaction along with snap and free scroll picker view navigation modes.

* **Hijri date picker** - In addition to the Gregorian calendar, the date range picker supports displaying the Islamic calendar (Hijri date picker).

![hijri_date_picker](https://cdn.syncfusion.com/content/images/FTControl/date+range+picker/hijricalendar.png)

* **Quick navigation** - Navigate back and forth the date-range views and between different view modes.

* **Enable/disable built-in view switching** - Restrict users from navigating to different picker views by disabling view switching. Select values in terms of month, year, or decade with this feature enabled.

![selection_range](https://cdn.syncfusion.com/content/images/FTControl/Flutter/date_range_picker_range_selection.png)

* **Date selection** - Select single, multiple, and range of dates. It also supports programmatic selection.

![selection_modes](https://cdn.syncfusion.com/content/images/FTControl/Flutter/daterangepicker/selection_mode.png)

* **Action buttons** - Display action buttons to confirm or cancel the selected date values in DatePicker and SfHijriDatePicker.

![action_buttons](https://cdn.syncfusion.com/content/images/FTControl/Flutter/calendar/action_buttons.png)

* **Limit the date selection range** - Select only a date range with a specific minimum and maximum numbers of days (span of days) by setting the min and max days options.

![min_max_dates](https://cdn.syncfusion.com/content/images/FTControl/Flutter/daterangepicker/min_max_date.png)

* **Change first day of week** - Customize the first day of the week as needed. The default first day is Sunday.

* **Blackout dates** - Disable any date in a calendar to make it inactive. Easily prevent the selection of weekends by disabling them.

![blackout_dates](https://cdn.syncfusion.com/content/images/FTControl/Flutter/daterangepicker/blackoutdates.png)

* **Highlight holidays and weekends** - Highlight any date or every weekend in a month as special days using decoration in Flutter date range picker. 

![highlight_holidays_and_weekends](https://cdn.syncfusion.com/content/images/FTControl/Flutter/daterangepicker/customization.png)

* **Appearance customization** - Change the look and feel of the date range picker by customizing its default appearance and style using Flutter decorations.

* **Builder** - Allows you to design and set your own custom view to the month and year cells of the date range picker.

![builders_in_datepicker](https://cdn.syncfusion.com/content/images/FTControl/date+range+picker/cell_builder.png)

* **Right to left(RTL)** - Right-to-left direction support for users working in RTL languages like Hebrew and Arabic.

![right_to_left](https://cdn.syncfusion.com/content/images/FTControl/Flutter/daterangepicker/right_to_left.png)

* **Accessibility** - Easy access of the date range picker by the screen readers.

* **Globalization** - Display the current date and time by following the globalized date and time formats.

![gloalization](https://cdn.syncfusion.com/content/images/FTControl/Flutter/daterangepicker/localization.png)

## Get the demo application

Explore the full capabilities of our Flutter widgets on your device by installing our sample browser applications from the below app stores, and view samples code in GitHub.

<p align="center">
  <a href="https://play.google.com/store/apps/details?id=com.syncfusion.flutter.examples"><img src="https://cdn.syncfusion.com/content/images/FTControl/google-play.png"/></a>
  <a href="https://apps.apple.com/us/app/syncfusion-flutter-ui-widgets/id1475231341"><img src="https://cdn.syncfusion.com/content/images/FTControl/apple-button.png"/></a>
</p>
<p align="center">
  <a href="https://github.com/syncfusion/flutter-examples"><img src="https://cdn.syncfusion.com/content/images/FTControl/GitHub.png"/></a>
  <a href="https://flutter.syncfusion.com"><img src="https://cdn.syncfusion.com/content/images/FTControl/web_sample_browser.png"/></a>  
</p>

## Other useful links

Take a look at the following to learn more about the Syncfusion Flutter DatePicker.

* [Syncfusion Flutter widgets product page](https://www.syncfusion.com/flutter-widgets)
* [User guide documentation](https://help.syncfusion.com/flutter/introduction/overview)
* [Knowledge base](https://www.syncfusion.com/kb)

## Installation

Install the latest version from [pub]().

## Getting started

Import the following package.

```dart
import 'package:free_flutter_datepicker/datepicker.dart';
```

### Add date range picker to the widget tree

Add the DatePicker widget as a child of any widget. Here, the DatePicker widget is added as a child of the scaffold widget.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
      body: Container(
    child: DatePicker(),
  ));
}
```

### Change different views

The DatePicker widget provides four different types of views to display. It can be assigned to the widget constructor by using the view property. Default view of the widget is month view. By default the current date will be displayed initially for all the date range picker views.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
      body: DatePicker(
    view: DatePickerViewType.year,
  ));
}
```

### Change first day of week

The DatePicker widget will be rendered with Sunday as the first day of the week, but you can customize it to any day by using the `firstDayOfWeek` property.

```dart
@override
Widget build(BuildContext context) {
	return Scaffold(
		body: DatePicker(
      view: DatePickerViewType.month,
      monthViewSettings: DatePickerMonthViewSettings(firstDayOfWeek: 1),
    ));
}
```

### Date selection

The DatePicker supports selecting single, multiple, and range of dates. It also supports programmatic selection.

The selected date or range details can be obtained using the `onSelectionChanged` callback of date range picker. The callback will return the `DatePickerSelectionChangedArgs` which contains the selected date or range details.

```dart
void _onSelectionChanged(DatePickerSelectionChangedArgs args) {
  // TODO: implement your code here
}

@override
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      body: Container(
        child: DatePicker(
          onSelectionChanged: _onSelectionChanged,
          selectionMode: DatePickerSelectionMode.range,
        ),
      ),
    ),
  );
}
```

## Support and Feedback

* For any other queries, reach our [Syncfusion support team](https://www.syncfusion.com/support/directtrac/incidents/newincident) or post the queries through the [Community forums](https://www.syncfusion.com/forums) and submit a feature request or a bug through our [Feedback portal](https://www.syncfusion.com/feedback/flutter).
* To renew the subscription, click [renew](https://www.syncfusion.com/sales/products) or contact our sales team at salessupport@syncfusion.com | Toll Free: 1-888-9 DOTNET.

## About Syncfusion

Founded in 2001 and headquartered in Research Triangle Park, N.C., Syncfusion has more than 20,000 customers and more than 1 million users, including large financial institutions, Fortune 500 companies, and global IT consultancies.

Today we provide 1,000+ controls and frameworks for web ([ASP.NET Core](https://www.syncfusion.com/aspnet-core-ui-controls), [ASP.NET MVC](https://www.syncfusion.com/aspnet-mvc-ui-controls), [ASP.NET WebForms](https://www.syncfusion.com/jquery/aspnet-web-forms-ui-controls), [JavaScript](https://www.syncfusion.com/javascript-ui-controls), [Angular](https://www.syncfusion.com/angular-ui-components), [React](https://www.syncfusion.com/react-ui-components), [Vue](https://www.syncfusion.com/vue-ui-components), and [Blazor](https://www.syncfusion.com/blazor-components), mobile ([Xamarin](https://www.syncfusion.com/xamarin-ui-controls), [Flutter](https://www.syncfusion.com/flutter-widgets), [UWP](https://www.syncfusion.com/uwp-ui-controls), and [JavaScript](https://www.syncfusion.com/javascript-ui-controls)), and desktop development ([WinForms](https://www.syncfusion.com/winforms-ui-controls), [WPF](https://www.syncfusion.com/wpf-ui-controls), and [UWP](https://www.syncfusion.com/uwp-ui-controls)). We provide ready-to deploy enterprise software for dashboards, reports, data integration, and big data processing. Many customers have saved millions in licensing fees by deploying our software.