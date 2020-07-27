# multi_sort [![Pub Package](https://img.shields.io/pub/v/multi_sort)](https://pub.dev/packages/multi_sort)

Fast and powerful Flutter package that help you to sort an List of objects by one or more properties written in Dart.

# Installing
### 1. Depend on it

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  multi_sort: ^0.0.1
```

### 2. Install it
You can install packages from the command line:

with Flutter:

```shell
$ flutter pub get
```
Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.

### 3. Import it
Now in your Dart code, you can use:

```dart
import 'package:multi_sort/multi_sort.dart';
```

# Example
```
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
  List<String> allProperties = ['ram', 'storage', 'price'];
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
                  allProperties: allProperties,
                  preferrence: preferrence,
                  sortingList: sortingList)
              .sort();
        });
      },
      child: Text('Sort by preferrence'),
    );
  }
}
```
# License

multi_sort is licensed under `MIT license`.
```
MIT License

Copyright (c) 2020 Deependra Chansoliya

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```