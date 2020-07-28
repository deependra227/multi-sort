library multi_sort;

import 'package:flutter/cupertino.dart';

class MultiSort {
  List<bool> criteria;
  dynamic preferrence;
  dynamic sortingList;

  MultiSort(
      {@required this.criteria,
      @required this.preferrence,
      @required this.sortingList});

  List<dynamic> sort() {

    if (preferrence.length == 0 || criteria.length == 0 || sortingList.length == 0) return [];
    if (preferrence.length != criteria.length) 
        return ['Criteria length is not equal to preferrence'];
    
    int compare(int i, dynamic a, dynamic b) {
      if (a.get(preferrence[i]) == b.get(preferrence[i]))
        return 0;
      else if (a.get(preferrence[i]) > b.get(preferrence[i]))
        return criteria[i] ? 1 : -1;
      else
        return criteria[i] ? -1 : 1;
    }

    int sortall(a, b) {
      int i = 0;
      int result;
      while (i < preferrence.length) {
        result = compare(i, a, b);
        if (result != 0) break;
        i++;
      }
      return result;
    }

    sortingList.sort((a, b) => sortall(a, b));

    return sortingList;
  }
}
