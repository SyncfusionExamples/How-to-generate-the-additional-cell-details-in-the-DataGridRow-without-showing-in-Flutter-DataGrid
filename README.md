# How-to-show-the-additional-cell-details-in-the-DataGridRow-without-showing-in-Flutter-DataGrid

In this article, you can learn about how to generate the additional cell details in the DataGridRow without showing that in [Flutter DataGrid](https://www.syncfusion.com/flutter-widgets/flutter-datagrid).

## STEP 1: 
Create a data source class by extending [DataGridSource](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/DataGridSource-class.html) and use it to map data to the SfDataGrid. In the `buildDataGridRow` method, map the entire underlying collection data to a DataGridRow. 

Here all the columns are generated from the underlying collection to DataGridRow. But, the four columns are alone displayed in a grid.

In the [buildRow](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/DataGridSource/buildRow.html) method, return a [DataGridRowAdapter](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/DataGridRowAdapter-class.html) with the required cell details to be displayed in the DataGrid.

```dart
class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(List<Employee> employees) {
    buildDataGridRow(employees);
  }

  void buildDataGridRow(List<Employee> employeeData) {
    dataGridRow = employeeData.map<DataGridRow>((employee) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'ID', value: employee.id),
        DataGridCell<String>(columnName: 'Name', value: employee.name),
        DataGridCell<String>(
            columnName: 'Designation', value: employee.designation),
        DataGridCell<int>(columnName: 'Salary', value: employee.salary),
        DataGridCell<String>(columnName: 'Address', value: employee.address),
        DataGridCell<String>(columnName: 'City', value: employee.city),
        DataGridCell<String>(columnName: 'Country', value: employee.country)
      ]);
    }).toList();
  }

  List<DataGridRow> dataGridRow = <DataGridRow>[];

  @override
  List<DataGridRow> get rows => dataGridRow.isEmpty ? [] : dataGridRow;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: [
      Container(
          alignment: Alignment.center,
          child: Text(
            row
                .getCells()
                .firstWhere((element) => element.columnName == 'ID')
                .value
                .toString(),
          )),
      Container(
          alignment: Alignment.center,
          child: Text(
            row
                .getCells()
                .firstWhere((element) => element.columnName == 'Name')
                .value
                .toString(),
          )),
      Container(
          alignment: Alignment.center,
          child: Text(
            row
                .getCells()
                .firstWhere((element) => element.columnName == 'Designation')
                .value
                .toString(),
          )),
      Container(
          alignment: Alignment.center,
          child: Text(
            row
                .getCells()
                .firstWhere((element) => element.columnName == 'Salary')
                .value
                .toString(),
          ))
    ].toList());
  }
}

```
## STEP 2: 
Initialize the [SfDataGrid](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid-class.html) widget with all the required properties. In this example, the additional cells not in the grid are displayed when tapping on the corresponding rows.

```dart
  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter SfDataGrid')),
      body: SfDataGrid(
        source: _employeeDataSource,
        columns: [
          GridColumn(
            columnName: 'ID',
            label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: const Text('ID'),
            ),
          ),
          GridColumn(
            columnName: 'Name',
            label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: const Text('Name'),
            ),
          ),
          GridColumn(
            columnName: 'Designation',
            label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: const Text('Designation'),
            ),
          ),
          GridColumn(
            columnName: 'Salary',
            label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: const Text('Salary '),
            ),
          ),
        ],
        onCellTap: (details) {
          if (details.rowColumnIndex.rowIndex != 0) {
            int selectedRowIndex = details.rowColumnIndex.rowIndex - 1;
            var row =
                _employeeDataSource.effectiveRows.elementAt(selectedRowIndex);

            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    content: SizedBox(
                      height: 200,
                      width: 200,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                'Address: ${row.getCells().firstWhere((element) => element.columnName == 'Address').value.toString()}'),
                            Text(
                                'City: ${row.getCells().firstWhere((element) => element.columnName == 'City').value.toString()}'),
                            Text(
                                'Country: ${row.getCells().firstWhere((element) => element.columnName == 'Country').value.toString()}'),
                            SizedBox(
                              width: 300,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("OK")),
                            )
                          ]),
                    )));
          }
        },
        columnWidthMode: ColumnWidthMode.fill,
      ),
    );
  }

```