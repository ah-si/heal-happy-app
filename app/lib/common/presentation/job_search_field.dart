import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heal_happy/common/presentation/autocomplete_field.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/form_validators.dart';

class JobSearchFormField extends StatelessWidget {
  final InputDecoration decoration;
  final TextEditingController controller;
  final int nbVisibleResults;
  final Function(MapEntry<String, String> selected) onItemSelected;
  final String? Function(String? value)? validator;

  const JobSearchFormField({Key? key, this.validator, required this.decoration, required this.controller, required this.onItemSelected, this.nbVisibleResults = 3}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutocompleteFormField<MapEntry<String, String>>(
      decoration: decoration,
      characterThreshold: 0,
      nbVisibleResults: nbVisibleResults,
      controller: controller,
      delegate: (String query) async {
        if (query.isEmpty) {
          return specialities.entries.toList(growable: false);
        }
        return specialities.entries.where((element) => element.value.toLowerCase().contains(query.toLowerCase())).toList(growable: false);
      },
      validator: validator ?? isRequired,
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
