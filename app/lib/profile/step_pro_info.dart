import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heal_happy/auth/models/user_info.dart';
import 'package:heal_happy/common/presentation/job_search_field.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/common/utils/form_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StepInfoPro extends HookConsumerWidget {
  final VoidCallback? onContinue;
  final String? saveButtonLabel;
  final bool headless;

  const StepInfoPro({Key? key, this.headless = false, this.saveButtonLabel, this.onContinue}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.read(userInfoProvider);
    final controllerDescription = useTextEditingController(text: userInfo.description);
    final controllerExperiences = useTextEditingController(text: userInfo.experiences);
    final controllerDiploma = useTextEditingController(text: userInfo.diploma);
    final controllerSpe = useTextEditingController(text: userInfo.job == null ? '' : specialities[userInfo.job]);
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return Form(
      key: formKey,
      child: Column(
        children: [
          if (!headless)
            Text(
              'Merci de remplir vos informations professionelles:',
              style: context.textTheme.headline5,
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              JobSearchFormField(
                decoration: const InputDecoration(label: Text('Spécialité*:')),
                controller: controllerSpe,
                validator: (value) {
                  final result = isRequired(value);
                  if (result == null && userInfo.job == null) {
                    return isRequired(null); //force required message
                  }
                  return result;
                },
                onItemSelected: (MapEntry<String, String> selected) {
                  userInfo.job = selected.key;
                },
              ),
              TextFormField(
                controller: controllerDescription,
                validator: isRequired,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(label: Text('Description*:')),
                maxLines: 3,
              ),
              TextFormField(
                controller: controllerExperiences,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(label: Text('Experiences:')),
                maxLines: 3,
              ),
              TextFormField(
                controller: controllerDiploma,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(label: Text('Diplomes:')),
                maxLines: 2,
              ),
            ],
          ),
          if (!headless) const Spacer(),
          Row(
            children: [
              if (!headless)
                Padding(
                  padding: const EdgeInsets.all(kNormalPadding),
                  child: TextButton(
                    onPressed: () async {
                      Navigator.of(context).maybePop();
                    },
                    child: const Text('Retour'),
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
                  child: Text(saveButtonLabel ?? 'Continuer'),
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
    final isAddressValid = useState(userInfo.isAddressVisible ?? false);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!headless)
            Text(
              'Merci de remplir votre adresse:',
              style: context.textTheme.headline5,
            ),
          if (!headless) const Text('Elle sera utilisée afin que les patients proche de vous puissent vous trouver'),
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
                title: const Text(
                  'Afficher mon adresse publiquement sur mon profile soignant',
                  textAlign: TextAlign.left,
                ),
              ),
              TextFormField(
                controller: controllerStreet,
                keyboardType: TextInputType.streetAddress,
                autofillHints: const [AutofillHints.streetAddressLine1],
                decoration: const InputDecoration(label: Text('Rue:')),
              ),
              TextFormField(
                controller: controllerStreet2,
                keyboardType: TextInputType.streetAddress,
                autofillHints: const [AutofillHints.streetAddressLine2],
                decoration: const InputDecoration(label: Text('Complément:')),
              ),
              TextFormField(
                controller: controllerCity,
                validator: isRequired,
                keyboardType: TextInputType.streetAddress,
                autofillHints: const [AutofillHints.addressCity],
                decoration: const InputDecoration(label: Text('Ville*:')),
              ),
              TextFormField(
                controller: controllerZipCode,
                validator: isRequired,
                keyboardType: const TextInputType.numberWithOptions(),
                autofillHints: const [AutofillHints.postalCode],
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(label: Text('Code postal*:')),
              ),
            ],
          ),
          if (!headless) const Spacer(),
          Row(
            children: [
              if (!headless)
                Padding(
                  padding: const EdgeInsets.all(kNormalPadding),
                  child: TextButton(
                    onPressed: () async {
                      Navigator.of(context).maybePop();
                    },
                    child: const Text('Retour'),
                  ),
                ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(kNormalPadding),
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      userInfo.isAddressVisible = isAddressValid.value;
                      userInfo.street = controllerStreet.text;
                      userInfo.street2 = controllerStreet2.text;
                      userInfo.city = controllerCity.text;
                      userInfo.zipCode = controllerZipCode.text;
                      onContinue?.call();
                    }
                  },
                  child: Text(saveButtonLabel ?? 'Continuer'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
