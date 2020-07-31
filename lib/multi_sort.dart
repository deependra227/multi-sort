library multi_sort;

extension MultiSort on List {
  multisort(List<bool> criteria, dynamic preferrence) {
    if (preferrence.length == 0 || criteria.length == 0 || this.length == 0)
      return this;
    if (preferrence.length != criteria.length) {
      print('Criteria length is not equal to preferrence');
      return this;
    }

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

    this.sort((a, b) => sortall(a, b));
  }
}
