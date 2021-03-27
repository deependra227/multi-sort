import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'multi_sort.dart';

/// A button to go with multi-sort to toggle sorting on multiple fields
class SortableButton extends StatelessWidget {
  /// The current list of sorted fields
  final List<SortField> sortedFields;

  /// This field
  final SortField field;

  /// The text for the button label
  final String text;

  /// A callback to set the altered sortedFields list
  ///
  /// '''void setSortedFields(List<SortField> sortedFields) {
  //    setState(() {
  //      this.sortedFields = sortedFields;
  //      this.data = data.multisort(sortedFields);
  //    });
  //  }'''
  final void Function(List<SortField>) onPressed;

  SortableButton(this.sortedFields, this.field, this.onPressed, {this.text});

  Widget build(BuildContext context) {
    SortField thisSortedField;
    int index;

    sortedFields.forEachIndexed((e, i) {
      if (e.fieldName == field.fieldName) {
        index = i;
        thisSortedField = e;
      }
    });

    return TextButton(
      onPressed: () {
        var newSortedFields = <SortField>[];

        if (thisSortedField == null) //
          newSortedFields = [...sortedFields, field];
        else {
          if (thisSortedField.isAscending) //
            newSortedFields = sortedFields.map((e) => e.fieldName != thisSortedField.fieldName ? e : SortField(e.fieldName, isAscending: false)).toList();
          else
            newSortedFields = sortedFields.where((e) => e.fieldName != thisSortedField.fieldName).toList();
        }

        onPressed(newSortedFields);
      },
      child: Row(
        children: [
          if (thisSortedField != null) //
            ...[
            Icon(
              thisSortedField.isAscending ? FontAwesomeIcons.angleUp : FontAwesomeIcons.angleDown,
              size: 15,
            ),
            Text(
              index.toString(),
              textScaleFactor: 0.6,
            ),
          ],
          Text(this.text ?? field.fieldName),
        ],
      ),
    );
  }
}
