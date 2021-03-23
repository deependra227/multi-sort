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
  multisort(List<String> preference,
      {List<bool> criteria, List<MultiSortType> type}) {
    assert((preference.length > 0),
        'MultiSort: Preference lenght must NOT me empty.');
        
        if(criteria != null){
           assert((criteria.length == preference.length ),
        'MultiSort: Criteria list has to be same size as preference list.');
        }

        if(type != null){
           assert((type.length == preference.length ),
        'MultiSort: Type list has to be same size as preference list.');
        }
   
    int compare(int i, dynamic a, dynamic b) {
      MultiSortType _type = type == null ? MultiSortType.generic : type[i];
      bool _criteria = criteria == null ? true : criteria[i];
      

      switch (_type) {
        case MultiSortType.datetime:
          try {
            if (a.get(preference[i]).isAtSameMomentAs(b.get(preference[i])))
              return 0;
            else if (a.get(preference[i]).isBefore(b.get(preference[i])))
              return _criteria ? 1 : -1;
            else
              return _criteria ? -1 : 1;
          } catch (e) {
            print(
                'MultiSort: Error, $e . \n Try using another[MultiSortType] or open an issue on Github');
            return 0;
          }

          break;
        case MultiSortType.number:
          try {
            if (a.get(preference[i]) == b.get(preference[i]))
              return 0;
            else if (a.get(preference[i]) > b.get(preference[i]))
              return _criteria ? 1 : -1;
            else
              return _criteria ? -1 : 1;
          } catch (e) {
            print(
                'MultiSort: Error, $e . \n Try using another[MultiSortType] or open an issue on Github');
            return 0;
          }

          break;
        case MultiSortType.generic:
          //Works with ascii, bool, enum, etc (convert to string before sort)
          try {
            return _criteria
                ? a
                    .get(preference[i])
                    .toString()
                    .toLowerCase()
                    .compareTo(b.get(preference[i]).toString().toLowerCase())
                : b
                    .get(preference[i])
                    .toString()
                    .toLowerCase()
                    .compareTo(a.get(preference[i]).toString().toLowerCase());
          } catch (e) {
            print(
                'MultiSort: Error, $e . \n Try using another[MultiSortType] or open an issue on Github');
            return 0;
          }
          break;
      }
      print('MultiSort: Error, MultiSortType not found.');
      return 0;
    }

    int sortall(a, b) {
      int i = 0;
      int result;
      while (i < preference.length) {
        result = compare(i, a, b);
        if (result != 0) break;
        i++;
      }
      return result;
    }

    this.sort((a, b) => sortall(a, b));
  }
}
