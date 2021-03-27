library multi_sort;

///get function to get the properties of Item
Comparable getComparableField(String propertyName, Sortable sortable) {
  var _mapRep = sortable.sortableFields();
  if (_mapRep.containsKey(propertyName)) {
    return _mapRep[propertyName];
  }
  throw ArgumentError('propery not found');
}

abstract class Sortable {
  ///A list of strings and their textual ids eg
  ///
  /// {'name': name, 'price': price, 'ram': ram, 'storage': storage};
  Map<String, Comparable> sortableFields();
}

class SortField {
  final String fieldName;
  final bool isAscending;

  SortField(this.fieldName, {this.isAscending = true});
}

extension MultiSort on List<Sortable> {
  List<Sortable> multisort(List<SortField> sortedFields) {
    if (sortedFields.length == 0) //
      return this;

    int compare(int i, Sortable a, Sortable b) {
      var valueA = getComparableField(sortedFields[i].fieldName, a);
      var valueB = getComparableField(sortedFields[i].fieldName, b);

      var result = valueA.compareTo(valueB);

      if (!sortedFields[i].isAscending) //
        return result * -1;

      return result;
    }

    int sortall(a, b) {
      int i = 0;
      int result;
      while (i < sortedFields.length) {
        result = compare(i, a, b);
        if (result != 0) break;
        i++;
      }
      return result;
    }

    final list = this.toList();

    list.sort((a, b) => sortall(a, b));

    return list;
  }
}
