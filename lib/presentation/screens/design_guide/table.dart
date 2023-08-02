import 'package:flutter/material.dart';

enum Calendar { day, week, month, year }

class Contact {
  String firstName;
  String lastName;
  String emailAddress;
  bool selected;

  Contact({
    this.firstName = '',
    this.lastName = '',
    this.emailAddress = '',
    this.selected = false,
  });
}

class CustomTable extends StatefulWidget {
  const CustomTable({super.key});

  @override
  State<CustomTable> createState() => _CustomTableState();
}

enum Sizes { extraSmall, small, medium, large, extraLarge }

class _CustomTableState extends State<CustomTable> {
  List selectedContacts = [];
  List<Contact> rowsData = [];
  List<DataRow> contactRows = [];
  bool allContactsSelected = true;
  Calendar calendarView = Calendar.day;
  List<DataColumn> contactColumns = [];
  Set<Sizes> selection = <Sizes>{Sizes.large, Sizes.extraLarge};
  List<String> columnsData = [
    '',
    'First Name',
    'Last Name',
    'Email Address',
  ];

  @override
  Widget build(BuildContext context) {
    contactRows = buildContactListOfDataRows(rowsData, TextAlign.center);
    contactColumns = buildListOfDataColumns(columnsData, TextAlign.center);

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: DataTable(
                columns: contactColumns,
                rows: contactRows,
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  List<DataRow> buildContactListOfDataRows(
      List<Contact> rowsData, TextAlign textAlign) {
    List<DataRow> dataRows = [];

    for (int i = 0; i < rowsData.length; i++) {
      String firstName = rowsData[i].firstName;
      String lastName = rowsData[i].lastName;
      String emailAddress = rowsData[i].emailAddress;
      DataRow row = DataRow(
        cells: [
          DataCell(Checkbox(
            value: rowsData[i].selected,
            onChanged: (value) {
              setState(
                () {
                  rowsData[i].selected = value == null
                      ? false
                      : value == false
                          ? false
                          : true;
                },
              );
              if (value == true) {
                selectedContacts.add(rowsData[i]);
              } else {
                selectedContacts.remove(rowsData[i]);
              }
            },
            tristate: true,
          )),
          DataCell(
            Text(
              firstName,
              textAlign: textAlign,
            ),
          ),
          DataCell(
            Text(
              lastName,
              textAlign: textAlign,
            ),
          ),
          DataCell(
            Text(
              emailAddress,
              textAlign: textAlign,
            ),
          ),
        ],
      );
      dataRows.add(row);
    }
    return dataRows;
  }

  List<DataColumn> buildListOfDataColumns(
      List<String> columnData, TextAlign textAlign) {
    List<DataColumn> dataColumns = [];

    for (int i = 0; i < columnData.length; i++) {
      String columnName = columnData[i];
      DataColumn column = const DataColumn(label: Text(''));

      if (columnName == '') {
        column = DataColumn(
            label: Checkbox(
          value: allContactsSelected,
          onChanged: (value) {
            setState(() {
              allContactsSelected = value == null
                  ? false
                  : value == false
                      ? false
                      : true;

              if (selectedContacts.isNotEmpty) {
                selectedContacts.clear();
              }

              if (allContactsSelected) {
                for (var element in rowsData) {
                  element.selected = true;
                  selectedContacts.add(element);
                }
              } else {
                for (var element in rowsData) {
                  element.selected = false;
                }
                selectedContacts.clear();
              }
            });
          },
          tristate: true,
        ));
      } else {
        column = DataColumn(
          label: Text(
            columnName,
            textAlign: textAlign,
          ),
        );
      }

      dataColumns.add(column);
    }

    return dataColumns;
  }

  @override
  void initState() {
    super.initState();

    if (rowsData.isEmpty) {
      for (int i = 0; i < 4; i++) {
        rowsData.add(
          Contact(
            lastName: 'test$i',
            firstName: 'user$i',
            emailAddress: 'email@test$i',
          ),
        );
      }
    }
  }
}
