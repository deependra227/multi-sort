library multi_sort;

enum MultiSortType {
  /// sort datetime type elements
  datetime,
  /// sort number elements (int/double)
  number,
  /// sort generic elements (string, bool, enum)
  generic
}

extension MultiSort on List {
  multisort(
      List<bool> criteria, dynamic preferrence, List<MultiSortType> type) {
    if (preferrence.length == 0 || criteria.length == 0 || this.length == 0)
      return this;

    assert((preferrence.length == criteria.length)  && (criteria.length == type.length),
        'Criteria, preferrence and type MUST HAVE same size}');

    int compare(int i, dynamic a, dynamic b) {
      switch (type[i]) {
        case MultiSortType.datetime:
          try {
            if (a.get(preferrence[i]).isAtSameMomentAs(b.get(preferrence[i])))
              return 0;
            else if (a.get(preferrence[i]).isBefore(b.get(preferrence[i])))
              return criteria[i] ? 1 : -1;
            else
              return criteria[i] ? -1 : 1;
          } catch (e) {
            print('multi_sort: Error,  $e');
            return 0;
          }

          break;
        case MultiSortType.number:
          try {
            if (a.get(preferrence[i]) == b.get(preferrence[i]))
              return 0;
            else if (a.get(preferrence[i]) > b.get(preferrence[i]))
              return criteria[i] ? 1 : -1;
            else
              return criteria[i] ? -1 : 1;
          } catch (e) {
            print('multi_sort: Error,  $e');
          }

          break;
        case MultiSortType.generic:
          //Works with ascii, bool, enum, etc (convert to string before sort)
          try {
            return criteria[i]
                ? a
                    .get(preferrence[i])
                    .toString()
                    .toLowerCase()
                    .compareTo(b.get(preferrence[i]).toString().toLowerCase())
                : b
                    .get(preferrence[i])
                    .toString()
                    .toLowerCase()
                    .compareTo(a.get(preferrence[i]).toString().toLowerCase());
          } catch (e) {
            print('multi_sort: Error,  $e');
            return 0;
          }

          break;
      }
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

    this.sort((a, b) => sortall(a, b));
  }
}
