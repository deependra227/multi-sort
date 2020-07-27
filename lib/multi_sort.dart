library multi_sort;

import 'package:flutter/cupertino.dart';

class MultiSort {
  dynamic allProperties;
  dynamic preferrence;
  dynamic sortingList;
  bool increasing;
  MultiSort(
      {@required this.allProperties,
      @required this.preferrence,
      @required this.sortingList,
      this.increasing = false});

  List<dynamic> sort() {
    int compare(String property, dynamic a, dynamic b) {
      if (a.get(property) == b.get(property))
        return 0;
      else if (a.get(property) > b.get(property))
        return increasing ? 1 : -1;
      else
        return increasing ? -1 : 1;
    }

    int sortall(preferrence, a, b) {
      int i = 0;
      int result;
      while (i < preferrence.length) {
        result = compare(preferrence[i], a, b);
        if (result != 0) break;
        i++;
      }
      return result;
    }

    sortingList.sort((a, b) => sortall(preferrence, a, b));

    return sortingList;
  }
}
