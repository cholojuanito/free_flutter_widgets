![syncfusion flutter datagrid](https://cdn.syncfusion.com/content/images/Flutter/pub_images/Flutter-DataGrid.png)

# Flutter DataGrid (DataTable) library

The Flutter DataTable or DataGrid is used to display and manipulate data in a tabular view. It is built from the ground up to achieve the best possible performance, even when loading large amounts data.

**Disclaimer:** This is a commercial package. To use this package, you need to have either a Syncfusion commercial license or [Free Syncfusion Community license](https://www.syncfusion.com/products/communitylicense). For more details, please check the [LICENSE](https://github.com/syncfusion/flutter-examples/blob/master/LICENSE) file.

**Note:** Our packages are now compatible with Flutter for web. However, this will be in beta until Flutter for web becomes stable.

## Table of contents
- [DataGrid features](#datagrid-features)
- [Coming soon](#coming-soon)
- [Get the demo application](#get-the-demo-application)
- [Useful links](#other-useful-links)
- [Installation](#installation)
- [Getting started](#getting-started)
    - [Creating data for an application](#creating-data-for-an-application)
    - [Creating data source for DataGrid](#creating-datasource-for-datagrid)
    - [Defining columns](#defining-columns)
- [Support and feedback](#support-and-feedback)
- [About Syncfusion](#about-syncfusion)

## DataGrid features

**Column types** - Support to load any widget in a each column.

![Flutter DataGrid shows different column types](https://cdn.syncfusion.com/content/images/Flutter/pub_images/flutter-datagrid-column-types.png)

**Column sizing** - Set the width of columns with various sizing options.

**Row height** - Set the height for header and data rows. Also, set the different height for specific rows.

![Flutter DataGrid shows rows in auto-fit](https://cdn.syncfusion.com/content/images/Flutter/pub_images/flutter-datagrid-auto-row-height.png)

**Sorting** - Sort one or more columns in the ascending or descending order. 

![Columns are sorted in flutter datagrid](https://cdn.syncfusion.com/content/images/Flutter/pub_images/flutter-datagrid-sorting.gif)

**Selection** - Select one or more rows. Keyboard navigation is supported for web platforms.

![Flutter DataGrid shows rows with selection](https://cdn.syncfusion.com/content/images/Flutter/pub_images/flutter-datagrid-selection.png)

**Styling** - Customize the appearance of cells and headers. Conditional styling is also supported.

![Styling in Flutter DataGrid](https://cdn.syncfusion.com/content/images/Flutter/pub_images/flutter-datagrid-styling.png)
![Styling in Flutter DataGrid](https://cdn.syncfusion.com/content/images/Flutter/pub_images/flutter-datagrid-conditional-styles.png)

**Stacked headers** - Show unbound header rows. Unbound header rows span stacked header columns across multiple rows and columns.

![Flutter datagrid shows multiple column headers](https://cdn.syncfusion.com/content/images/Flutter/pub_images/flutter-datagrid-stacked-headers.png)

**Load more** - Display an interactive view when the grid reaches its maximum offset while scrolling down. Tapping the interactive view triggers a callback to add more data from the data source of the grid at run time.

![infinite scrolling in Flutter datagrid](https://cdn.syncfusion.com/content/images/Flutter/pub_images/flutter-datagrid-load-more.gif)

**Paging** - Load data in segments. It is useful when loading huge amounts of data.

![Flutter DataGrid shows rows in page segments](https://cdn.syncfusion.com/content/images/Flutter/pub_images/flutter-datagrid-paging.png)

**Freeze Panes** - Freeze the rows and columns when scrolling the grid. 

![First row and column are frozen in flutter datagrid](https://cdn.syncfusion.com/content/images/Flutter/pub_images/flutter-datagrid-freeze-panes.gif)

**Swiping** - Swipe a row right to left or left to right for custom actions such as deleting, editing, and so on. When the user swipes a row, the row will be moved and the swipe view will show the custom actions.

**Pull to refresh** - Allows users to refresh data when the DataGrid is pulled down.

**Theme** - Use a dark or light theme.

**Accessibility** - The DataGrid can easily be accessed by screen readers.

**Right to Left (RTL)** - Right-to-left direction support for users working in RTL languages like Hebrew and Arabic.

## Coming soon

* Editing
* Column resizing
* Column drag and drop
* Grouping
* Row drag and drop

## Get the demo application

Explore the full capabilities of our Flutter widgets on your device by installing our sample browser applications from the following app stores, and view sample code in GitHub.

<p align="center">
  <a href="https://play.google.com/store/apps/details?id=com.syncfusion.flutter.examples"><img src="https://cdn.syncfusion.com/content/images/FTControl/google-play.png"/></a>
  <a href="https://apps.apple.com/us/app/syncfusion-flutter-ui-widgets/id1475231341"><img src="https://cdn.syncfusion.com/content/images/FTControl/apple-button.png"/></a>
</p>
<p align="center">
  <a href="https://github.com/syncfusion/flutter-examples"><img src="https://cdn.syncfusion.com/content/images/FTControl/GitHub.png"/></a>
  <a href="https://flutter.syncfusion.com"><img src="https://cdn.syncfusion.com/content/images/FTControl/web_sample_browser.png"/></a>  
</p>

## Other useful links
Check out the following resource to learn more about the Syncfusion Flutter DataGrid:

* [Syncfusion Flutter DataGrid product page](https://www.syncfusion.com/flutter-widgets/flutter-datagrid)
* [User guide documentation](https://help.syncfusion.com/flutter/datagrid/overview)

## Installation

Install the latest version from [pub](https://pub.dartlang.org/packages/free_flutter_datagrid#-installing-tab-).

## Getting started

Import the following package.

```dart
import 'package:free_flutter_datagrid/datagrid.dart';
```
### Creating Data for an application

The SfDataGrid is dependent upon data. Create a simple data source for `SfDataGrid` as shown in the following code example.

```dart
class Employee {
  Employee(this.id, this.name, this.designation, this.salary);
  final int id;
  final String name;
  final String designation;
  final int salary;
}
```

Create the collection of employee data with the required number of data objects. Here, the method used to populate the data objects is initialized in initState()

`DataGridSource` objects are expected to be long-lived, not re-created with each build.

```dart
List<Employee> employees = <Employee>[];

EmployeeDataSource employeeDataSource;

@override
void initState() {
  super.initState();
  employees= getEmployees();
  employeeDataSource = EmployeeDataSource(employees: employees);
}

 List<Employee> getEmployees() {
  return[
  Employee(10001, 'James', 'Project Lead', 20000),
  Employee(10002, 'Kathryn', 'Manager', 30000),
  Employee(10003, 'Lara', 'Developer', 15000),
  Employee(10004, 'Michael', 'Designer', 15000),
  Employee(10005, 'Martin', 'Developer', 15000),
  Employee(10006, 'Newberry', 'Developer', 15000),
  Employee(10007, 'Balnc', 'Developer', 15000),
  Employee(10008, 'Perry', 'Developer', 15000),
  Employee(10009, 'Gable', 'Developer', 15000),
  Employee(10010, 'Grimes', 'Developer', 15000)
  ];
}
```

### Creating DataSource for DataGrid

`DataGridSource` is used to obtain the row data for the `SfDataGrid`. So, create the data source from the DataGridSource and override the following APIs in it:

* `rows`: Fetches the rows available for data population. Also, it is used to fetch the corresponding data object to process the selection. This contains the collection of `DataGridRow` where each row contains the collection of `DataGridCell`. Each cell should have the cell value in `value` property. `value` is used to perform the sorting for columns.

* `buildRow`: Fetches the widget for each cell with `DataGridRowAdapter`.

```dart
class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({List<Employee> employees}) {
     _employees = employees
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'designation', value: e.designation),
              DataGridCell<int>(columnName: 'salary', value: e.salary),
            ]))
        .toList();
  }

  List<DataGridRow>  _employees;

  @override
  List<DataGridRow> get rows =>  _employees;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: (dataGridCell.columnName == 'id' || dataGridCell.columnName == 'salary')
            ? Alignment.centerRight
            : Alignment.centerLeft,
        padding: EdgeInsets.all(16.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}
```

Create an instance of `DataGridSource` and set this object to the `source` property of `SfDataGrid`.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Text('Syncfusion DataGrid'),
      ),
      body: Center(
        child: Expanded(
          child: SfDataGrid(
            source: _employeeDataSource,
          ),
        ),
      ));
}
```

### Defining columns

`SfDataGrid` supports load any widget in columns. You can add the column collection to the `columns` property.

```dart  
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Syncfusion Flutter DataGrid'),
    ),
    body: SfDataGrid(
      source: employeeDataSource,
      columns: <GridColumn>[
        GridTextColumn(
            columnName: 'id',
            label: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'ID',
                ))),
        GridTextColumn(
            columnName: 'name',
            label: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.centerLeft,
                child: Text('Name'))),
        GridTextColumn(
            columnName: 'designation',
            width: 120,
            label: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.centerLeft,
                child: Text('Designation'))),
        GridTextColumn(
            columnName: 'salary',
            label: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.centerRight,
                child: Text('Salary'))),
      ],
    ),
  );
}
```

The following screenshot illustrates the result of the above code sample.

![syncfusion flutter datagrid](https://cdn.syncfusion.com/content/images/Flutter/pub_images/getting-started-flutter-datagrid.png)

## Support and Feedback

* If you have any questions, you can reach the [Syncfusion support team](https://www.syncfusion.com/support/directtrac/incidents/newincident) or post queries to the [community forums](https://www.syncfusion.com/forums). You can also submit a feature request or a bug report through our [feedback portal](https://www.syncfusion.com/feedback/flutter).
* To renew your subscription, click [renew](https://www.syncfusion.com/sales/products) or contact our sales team at sales@syncfusion.com  | Toll Free: 1-888-9 DOTNET.

## About Syncfusion

Founded in 2001 and headquartered in Research Triangle Park, N.C., Syncfusion has more than 20,000 customers and more than 1 million users, including large financial institutions, Fortune 500 companies, and global IT consultancies.

Today we provide 1,600+ controls and frameworks for web ([ASP.NET Core](https://www.syncfusion.com/aspnet-core-ui-controls), [ASP.NET MVC](https://www.syncfusion.com/aspnet-mvc-ui-controls), [ASP.NET WebForms](https://www.syncfusion.com/jquery/aspnet-web-forms-ui-controls), [JavaScript](https://www.syncfusion.com/javascript-ui-controls), [Angular](https://www.syncfusion.com/angular-ui-components), [React](https://www.syncfusion.com/react-ui-components), [Vue](https://www.syncfusion.com/vue-ui-components), and [Blazor](https://www.syncfusion.com/blazor-components)) , mobile ([Xamarin](https://www.syncfusion.com/xamarin-ui-controls), [Flutter](https://www.syncfusion.com/flutter-widgets), [UWP](https://www.syncfusion.com/uwp-ui-controls), and [JavaScript](https://www.syncfusion.com/javascript-ui-controls)), and desktop development ([WinForms](https://www.syncfusion.com/winforms-ui-controls), [WPF](https://www.syncfusion.com/wpf-ui-controls), and [UWP](https://www.syncfusion.com/uwp-ui-controls)). We provide ready-to- deploy enterprise software for dashboards, reports, data integration, and big data processing. Many customers have saved millions in licensing fees by deploying our software.