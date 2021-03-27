//flutter test --plain-name=LessonSplitter

import 'package:flutter_test/flutter_test.dart';
import 'package:multi_sort/multi_sort.dart';

/// Class of Items
class Items implements Sortable {
  String name;
  int ram;
  Items(this.name, this.ram);

  String toString() => //
      "name: ${this.name}, ram: ${this.ram}";

  Map<String, Comparable> sortableFields() => //
      {
        'name': name,
        'ram': ram,
      };
}

void main() {
  group("multiSort", () {
//    List<Items> unsorted;

    var unsorted = [
      Items("b", 1),
      Items("b", 128),
      Items("a", 64),
    ];

//    setUp(() {
//      unsorted = [
//        Items("b", 1),
//        Items("b", 128),
//        Items("a", 64),
//      ];
//    });

    test("two asc", () {
      var sortedFields = [
        SortField('ram'),
        SortField('name'),
      ];
      var sorted = unsorted.multisort(sortedFields);
      var expected = [
        Items("b", 1),
        Items("a", 64),
        Items("b", 128),
      ];

      expect(sorted.toString(), expected.toString());
    });

    test("two asc & desc", () {
      var sortedFields = [
        SortField('name'),
        SortField('ram', isAscending: false),
      ];
      var sorted = unsorted.multisort(sortedFields);
      var expected = [
        Items("a", 64),
        Items("b", 128),
        Items("b", 1),
      ];

      expect(sorted.toString(), expected.toString());
    });

    test("sort set to null", () {
      var sortedFields = <SortField>[];
      var sorted = unsorted.multisort(sortedFields);
      var expected = [
        Items("b", 1),
        Items("b", 128),
        Items("a", 64),
      ];

      expect(sorted.toString(), expected.toString());
    });
  });
}
