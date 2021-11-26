import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heal_happy/common/presentation/autocomplete_field.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/common/utils/form_validators.dart';

class JobSearchFormField extends StatelessWidget {
  final InputDecoration decoration;
  final TextEditingController controller;
  final int nbVisibleResults;
  final Future<Map<String, String>> Function() loadData;
  final Function(MapEntry<String, String> selected) onItemSelected;
  final String? Function(String? value)? validator;

  const JobSearchFormField({
    Key? key,
    this.validator,
    required this.decoration,
    required this.loadData,
    required this.controller,
    required this.onItemSelected,
    this.nbVisibleResults = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutocompleteFormField<MapEntry<String, String>>(
      decoration: decoration,
      characterThreshold: 0,
      nbVisibleResults: nbVisibleResults,
      controller: controller,
      delegate: (String query) async {
        final specialities = await loadData();
        if (query.isEmpty) {
          return specialities.entries.toList(growable: false);
        }
        return specialities.entries.where((element) => element.value.toLowerCase().removeDiacritic().contains(query.trim().toLowerCase().removeDiacritic())).toList(growable: false);
      },
      validator: validator ?? (value) => isRequired(value, context),
      itemBuilder: (BuildContext context, MapEntry<String, String> entry) {
        return ListTile(title: Text(entry.value));
      },
      onItemSelected: (MapEntry<String, String> entry) {
        controller.text = entry.value;
        onItemSelected(entry);
      },
    );
  }
}
