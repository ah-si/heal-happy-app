import 'package:dart_countries/dart_countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';

class CountryCodePicker extends StatelessWidget {
  final IsoCode value;
  final bool showCountryOnly;
  final void Function(IsoCode value) onChanged;

  const CountryCodePicker({super.key, required this.onChanged, this.value = IsoCode.MX, this.showCountryOnly = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSmallPadding),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              countriesFlag[value]!,
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(width: kSmallPadding),
            if (!showCountryOnly) Text('+${countriesCountryCode[value]!}'),
            if (showCountryOnly) Text(countriesName[value]!),
          ],
        ),
      ),
      onTap: () => openPopup(context),
    );
  }

  void openPopup(BuildContext context) {
    final controller = TextEditingController();
    final label = context.l10n.search;
    showAlert(
      context,
      (context) => TextField(
        controller: controller,
        autofocus: true,
        decoration: InputDecoration(hintText: label, prefixIcon: const Icon(Icons.search)),
      ),
      (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: HookBuilder(
              builder: (context) {
                useListenable(controller);
                final scrollController = useScrollController();
                final searchQuery = controller.text;

                final data = IsoCode.values
                    .where(
                      (element) =>
                          searchQuery.toLowerCase() == element.name.toLowerCase() ||
                          countriesName[element]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
                          countriesCountryCode[element]!.toLowerCase().contains(searchQuery.toLowerCase()),
                    )
                    .toList();

                final countriesOrderedName = countriesName.entries
                    .where(
                      (element) => data.contains(element.key),
                    )
                    .map((e) => e.value)
                    .toList()
                  ..sort();
                IsoCode countryCodeByName(String name) {
                  return countriesName.entries.firstWhere((element) => element.value == name).key;
                }

                return Scrollbar(
                  controller: scrollController,
                  child: ListView.separated(
                    controller: scrollController,
                    separatorBuilder: (context, index) {
                      return const Divider(height: 1);
                    },
                    itemBuilder: (context, index) {
                      final isoCode = countryCodeByName(countriesOrderedName[index]);
                      return InkWell(
                        onTap: () {
                          onChanged(isoCode);
                          context.navigator.pop(isoCode);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kSmallPadding),
                          child: Row(
                            children: [
                              Text(countriesFlag[isoCode]!, style: const TextStyle(fontSize: 35)),
                              const SizedBox(width: kSmallPadding),
                              if (!showCountryOnly) Text('(${countriesCountryCode[isoCode]!})'),
                              Expanded(child: Text(countriesName[isoCode]!)),
                            ],
                          ),
                        ),
                      );
                    },
                    shrinkWrap: true,
                    itemCount: data.length,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
