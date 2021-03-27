import 'package:flutter/material.dart';
import 'package:multi_sort/SortableButton.dart';
import "package:multi_sort/multi_sort.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExampleApp(),
    );
  }
}

class ExampleApp extends StatefulWidget {
  ExampleApp({Key key}) : super(key: key);

  _ExampleAppState createState() => _ExampleAppState();
}

/// Class of Items
class Items implements Sortable {
  String name;
  int ram;
  int price;
  int storage;
  Items(this.name, this.ram, this.price, this.storage);

  ///Mapping the properties
  Map<String, Comparable> sortableFields() {
    return {'name': name, 'price': price, 'ram': ram, 'storage': storage};
  }
}

class _ExampleAppState extends State<ExampleApp> {
  //List of Items
  var data = [
    Items("real me 6", 6, 18999, 1),
    Items("real me 6", 8, 19999, 128),
    Items("real Note 8", 7, 16999, 128),
    Items("oppo a9", 4, 13999, 64),
    Items("real me 6 pro", 6, 17999, 64),
    Items("Oppo 5as", 2, 8999, 32),
    Items("Real me 5i", 4, 10999, 64),
    Items("Poco x2", 6, 18500, 128),
  ];

  var sortedFields = <SortField>[];

  void setSortedFields(List<SortField> sortedFields) {
    setState(() {
      this.sortedFields = sortedFields;
      this.data = data.multisort(sortedFields);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sort List Example"),
      ),
      body: Column(
        children: [
          Row(children: [
            SortableButton(sortedFields, SortField('name'), setSortedFields),
            SortableButton(sortedFields, SortField('price'), setSortedFields),
            SortableButton(sortedFields, SortField('ram'), setSortedFields),
            SortableButton(sortedFields, SortField('storage'), setSortedFields),
          ]),
          ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int i) {
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(data[i].name),
                      Text(data[i].price.toString()),
                      Text(data[i].ram.toString()),
                      Text(data[i].storage.toString()),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
