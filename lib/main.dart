import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SfDataGridDemo()));
}

class SfDataGridDemo extends StatefulWidget {
  const SfDataGridDemo({Key? key}) : super(key: key);

  @override
  SfDataGridDemoState createState() => SfDataGridDemoState();
}

class SfDataGridDemoState extends State<SfDataGridDemo> {
  late EmployeeDataSource _employeeDataSource;
  List<Employee> employees = <Employee>[];

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
}

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

class Employee {
  Employee(this.id, this.name, this.designation, this.salary, this.address,
      this.city, this.country);

  final int id;
  final String name;
  final String designation;
  final String address;
  final String city;
  final String country;
  final int salary;
}

List<Employee> getEmployeeData() {
  return [
    Employee(
        10001, 'Jack', 'Manager', 120000, 'Obere Str. 57', 'Berlin', 'Germany'),
    Employee(10002, 'Ellis', 'Project Lead', 80000, 'Avda Constitución 22',
        'México D.F', 'Mexico'),
    Employee(10003, 'Lara', 'Developer', 51000, 'Mataderos  2312', 'Graz',
        'Austria'),
    Employee(
        10004, 'Stark', 'Designer', 40000, '120 Hanover Sq', 'London', 'UK'),
    Employee(10005, 'James', 'Developer', 50000, 'Berguvsvägen  8', 'Luleå',
        'Sweden'),
    Employee(10006, 'Perry', 'Developer', 49000, 'Forsterstr. 57', 'Bergamo',
        'Italy'),
    Employee(10007, 'Edwards', 'Developer', 48000, '24, place Kléber',
        'Strasbourg', 'France'),
    Employee(10008, 'Grimes', 'Developer', 48000, 'C/ Araquil, 67', 'Madrid',
        'Spain'),
    Employee(10009, 'Michael', 'Support', 40000, '12, rue des Bouchers',
        'Stavern', 'Norway'),
    Employee(10010, 'Elizabeth', 'Developer', 47000, '23, Tsawassen Blvd.',
        'Tsawassen', 'Canada'),
    Employee(10011, 'Sven Ottlieb', 'Developer', 46000, 'Fauntleroy Circus',
        'Cantaura', 'Venezuela'),
    Employee(10012, 'Maria Anders', 'QA Testing', 38000, 'Cerrito 333',
        'Svendborg', 'Denmark'),
    Employee(10013, 'Thomas Hardy', 'Developer', 44000, 'Sierras de Granada 99',
        'Lyon', 'France'),
    Employee(10014, 'Roland Mendel', 'Sales Associate', 37000, 'Hauptstr. 29',
        'Bern', 'Switzerland'),
    Employee(10015, 'Patricio Simpson', 'Administrator', 35000,
        'Av. dos Lusíadas, 23', 'Estremoz', 'Portugal')
  ];
}
