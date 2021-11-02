part of 'register_screen.dart';

class _StepInfoPro extends HookConsumerWidget {
  final VoidCallback onContinue;

  const _StepInfoPro({Key? key, required this.onContinue}) : super(key: key);

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
          Text(
            'Merci de remplir vos informations professionelles:',
            style: context.textTheme.headline5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                JobSearchFormField(
                  decoration: InputDecoration(label: Text('Spécialité*:')),
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
                  decoration: InputDecoration(label: Text('Description*:')),
                  maxLines: 3,
                ),
                TextFormField(
                  controller: controllerExperiences,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(label: Text('Experiences:')),
                  maxLines: 3,
                ),
                TextFormField(
                  controller: controllerDiploma,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(label: Text('Diplomes:')),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(kNormalPadding),
                child: TextButton(
                  onPressed: () async {
                    Navigator.of(context).maybePop();
                  },
                  child: Text('Retour'),
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
                      onContinue();
                    }
                  },
                  child: Text('Continuer'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepAddress extends HookConsumerWidget {
  final VoidCallback onContinue;

  const _StepAddress({required this.onContinue, Key? key}) : super(key: key);

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
          Text(
            'Merci de remplir votre adresse:',
            style: context.textTheme.headline5,
          ),
          const Text('Elle sera utilisée afin que les patients proche de vous puissent vous trouver'),
          Expanded(
            child: Column(
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
                    'Afficher mon adresse publiquement sur mon profile soignant',
                    textAlign: TextAlign.left,
                  ),
                ),
                TextFormField(
                  controller: controllerStreet,
                  keyboardType: TextInputType.streetAddress,
                  autofillHints: const [AutofillHints.streetAddressLine1],
                  decoration: InputDecoration(label: Text('Rue:')),
                ),
                TextFormField(
                  controller: controllerStreet2,
                  keyboardType: TextInputType.streetAddress,
                  autofillHints: const [AutofillHints.streetAddressLine2],
                  decoration: InputDecoration(label: Text('Complément:')),
                ),
                TextFormField(
                  controller: controllerCity,
                  validator: isRequired,
                  keyboardType: TextInputType.streetAddress,
                  autofillHints: const [AutofillHints.addressCity],
                  decoration: InputDecoration(label: Text('Ville*:')),
                ),
                TextFormField(
                  controller: controllerZipCode,
                  validator: isRequired,
                  keyboardType: const TextInputType.numberWithOptions(),
                  autofillHints: const [AutofillHints.postalCode],
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(label: Text('Code postale*:')),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(kNormalPadding),
                child: TextButton(
                  onPressed: () async {
                    Navigator.of(context).maybePop();
                  },
                  child: Text('Retour'),
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
                      onContinue();
                    }
                  },
                  child: Text('Continuer'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
