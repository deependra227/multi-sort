import 'package:flutter/material.dart';
import "package:multi_sort/multi_sort.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ExampleApp(),
    );
  }
}

class ExampleApp extends StatefulWidget {
  ExampleApp({Key key}) : super(key: key);

  @override
  _ExampleAppState createState() => _ExampleAppState();
}

class Items {
  String name;
  int ram;
  int price;
  int storage;
  Items(this.name, this.ram, this.price, this.storage);

  Map<String, dynamic> _toMap() {
    return {'name': name, 'price': price, 'ram': ram, 'storage': storage};
  }

  dynamic get(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

class _ExampleAppState extends State<ExampleApp> {
  List<Items> items = [
    Items("real me 6", 6, 18999, 128),
    Items("real me 6", 8, 19999, 128),
    Items("real Note 8", 7, 16999, 128),
    Items("oppo a9", 4, 13999, 128),
    Items("real me 6 pro", 6, 17999, 64),
    Items("Oppo 5as", 2, 8999, 32),
    Items("Real me 5i", 4, 10999, 64),
    Items("Poco x2", 6, 18500, 128),
  ];
  List<Items> sortingList = [];
  List<bool> criteria = [false,false];
  List<String> preferrence = ['ram', 'storage'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      sortingList = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sort List Example"),
      ),
      body: Column(
        children: [
          _buttons(),
          ListView.builder(
              shrinkWrap: true,
              itemCount: sortingList.length,
              itemBuilder: (BuildContext context, int i) {
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(sortingList[i].name),
                      Text(sortingList[i].price.toString()),
                      Text(sortingList[i].ram.toString()),
                      Text(sortingList[i].storage.toString()),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget _buttons() {
    return RaisedButton(
      onPressed: () {
        setState(() {
          sortingList = MultiSort(
                  criteria: criteria,
                  preferrence: preferrence,
                  sortingList: sortingList)
              .sort();
        });
      },
      child: Text('Sort by preferrence'),
    );
  }
}
