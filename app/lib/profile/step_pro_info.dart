import 'package:dart_countries/dart_countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heal_happy/auth/models/user_info.dart';
import 'package:heal_happy/common/presentation/country_picker.dart';
import 'package:heal_happy/common/presentation/job_search_field.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/common/utils/form_validators.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _CountryWidget extends HookWidget {
  final String country;
  final Function(String country) onSelected;

  const _CountryWidget({required this.country, required this.onSelected, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iso = useState(IsoCode.fromJson(country));
    return CountryCodePicker(
          showCountryOnly: true,
          value: iso.value,
          onChanged: (value) {
            iso.value = value;
            onSelected(value.name);
          },
    );
  }
}

class StepInfoPro extends HookConsumerWidget {
  final VoidCallback? onContinue;
  final String? saveButtonLabel;
  final bool headless;

  const StepInfoPro({Key? key, this.headless = false, this.saveButtonLabel, this.onContinue}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.read(userStoreProvider);
    final userInfo = ref.read(userInfoProvider);
    final controllerDescription = useTextEditingController(text: userInfo.description);
    final controllerExperiences = useTextEditingController(text: userInfo.experiences);
    final controllerDiploma = useTextEditingController(text: userInfo.diploma);
    final controllerSpe = useTextEditingController(text: userInfo.job == null ? '' : (store.specialities[userInfo.job] ?? ''));
    final formKey = useMemoized(() => GlobalKey<FormState>());

    useEffect(() {
      if (controllerSpe.text.isEmpty && userInfo.job != null) {
        controllerSpe.text = store.specialities[userInfo.job] ?? '';
      }
      return null;
    }, [store.specialities]);

    return Form(
      key: formKey,
      child: Column(
        children: [
          if (!headless)
            Text(
              context.l10n.proInfoIntro,
              style: context.textTheme.headlineSmall,
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              JobSearchFormField(
                decoration: InputDecoration(label: Text(context.l10n.speField)),
                controller: controllerSpe,
                validator: (value) {
                  final result = isRequired(value, context);
                  if (result == null && userInfo.job == null) {
                    return isRequired(null, context); //force required message
                  }
                  return result;
                },
                onItemSelected: (MapEntry<String, String> selected) {
                  userInfo.job = selected.key;
                },
                loadData: () {
                  return ref.read(userStoreProvider).getSpecialities();
                },
              ),
              TextFormField(
                controller: controllerDescription,
                validator: (value) => isRequired(value, context),
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(label: Text(context.l10n.descriptionField)),
                maxLines: 3,
              ),
              TextFormField(
                controller: controllerExperiences,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(label: Text(context.l10n.expField)),
                maxLines: 3,
              ),
              TextFormField(
                controller: controllerDiploma,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(label: Text(context.l10n.diplomaField)),
                maxLines: 2,
              ),
            ],
          ),
          Row(
            children: [
              if (!headless)
                Padding(
                  padding: const EdgeInsets.all(kNormalPadding),
                  child: TextButton(
                    onPressed: () async {
                      Navigator.of(context).maybePop();
                    },
                    child: Text(MaterialLocalizations.of(context).backButtonTooltip),
                  ),
                ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(kNormalPadding),
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      userInfo.diploma = controllerDiploma.text;
                      userInfo.description = controllerDescription.text;
                      userInfo.experiences = controllerExperiences.text;
                      onContinue?.call();
                    }
                  },
                  child: Text(saveButtonLabel ?? context.l10n.continueButton),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StepAddress extends HookConsumerWidget {
  final VoidCallback? onContinue;
  final String? saveButtonLabel;
  final bool headless;

  const StepAddress({this.saveButtonLabel, this.headless = false, this.onContinue, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.read(userInfoProvider);
    final controllerStreet = useTextEditingController(text: userInfo.street);
    final controllerStreet2 = useTextEditingController(text: userInfo.street2);
    final controllerCity = useTextEditingController(text: userInfo.city);
    final controllerZipCode = useTextEditingController(text: userInfo.zipCode);
    final controllerCountry = useTextEditingController(text: userInfo.country);
    final isAddressValid = useState(userInfo.isAddressVisible ?? false);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    submitForm() {
      if (formKey.currentState!.validate()) {
        userInfo.isAddressVisible = isAddressValid.value;
        userInfo.street = controllerStreet.text;
        userInfo.street2 = controllerStreet2.text;
        userInfo.city = controllerCity.text;
        userInfo.zipCode = controllerZipCode.text;
        userInfo.country = controllerCountry.text;
        onContinue?.call();
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!headless)
            Text(
              context.l10n.addressIntro,
              style: context.textTheme.headlineSmall,
            ),
          if (!headless)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
              child: Text(context.l10n.addressDescription),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              CheckboxListTile(
                value: isAddressValid.value,
                onChanged: (bool? value) {
                  isAddressValid.value = value!;
                },
                contentPadding: EdgeInsets.zero,
                title: Text(
                  context.l10n.showAddress,
                  textAlign: TextAlign.left,
                ),
              ),
              TextFormField(
                controller: controllerStreet,
                keyboardType: TextInputType.streetAddress,
                autofillHints: const [AutofillHints.streetAddressLine1],
                decoration: InputDecoration(label: Text(context.l10n.streetField)),
              ),
              TextFormField(
                controller: controllerStreet2,
                keyboardType: TextInputType.streetAddress,
                autofillHints: const [AutofillHints.streetAddressLine2],
                decoration: InputDecoration(label: Text(context.l10n.street2Field)),
              ),
              TextFormField(
                controller: controllerCity,
                validator: (value) => isRequired(value, context),
                keyboardType: TextInputType.streetAddress,
                autofillHints: const [AutofillHints.addressCity],
                decoration: InputDecoration(label: Text(context.l10n.cityField)),
              ),
              TextFormField(
                controller: controllerZipCode,
                validator: (value) => isRequired(value, context),
                keyboardType: const TextInputType.numberWithOptions(),
                autofillHints: const [AutofillHints.postalCode],
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(label: Text(context.l10n.zipField)),
              ),
              _CountryWidget(
                country: controllerCountry.text,
                onSelected: (selected) {
                  controllerCountry.text = selected;
                },
              ),
            ],
          ),
          Row(
            children: [
              if (!headless)
                Padding(
                  padding: const EdgeInsets.all(kNormalPadding),
                  child: TextButton(
                    onPressed: () async {
                      Navigator.of(context).maybePop();
                    },
                    child: Text(MaterialLocalizations.of(context).backButtonTooltip),
                  ),
                ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(kNormalPadding),
                child: ElevatedButton(
                  onPressed: submitForm,
                  child: Text(saveButtonLabel ?? context.l10n.sendButton),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
