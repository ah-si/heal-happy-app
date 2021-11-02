
part of 'register_screen.dart';
class _StepPersonalInfo extends HookConsumerWidget {
  final VoidCallback onContinue;

  const _StepPersonalInfo({required this.onContinue, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.read(userInfoProvider);
    final controllerMobile = useTextEditingController(text: userInfo.mobile);
    final controllerLastName = useTextEditingController(text: userInfo.lastName);
    final controllerFirstName = useTextEditingController(text: userInfo.firstName);
    final controller = useTextEditingController(text: userInfo.email ?? 'jimmy.aumard@gmail.com');
    final controllerPass = useTextEditingController(text: userInfo.password);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Merci de remplir vos informations personnelles:',
            style: context.textTheme.headline5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controllerLastName,
                  validator: isRequired,
                  keyboardType: TextInputType.name,
                  autofillHints: const [AutofillHints.familyName],
                  onChanged: (value) => userInfo.lastName = value,
                  decoration: InputDecoration(label: Text('Nom*:')),
                ),
                TextFormField(
                  controller: controllerFirstName,
                  validator: isRequired,
                  keyboardType: TextInputType.name,
                  autofillHints: const [AutofillHints.name, AutofillHints.givenName],
                  onChanged: (value) => userInfo.firstName = value,
                  decoration: InputDecoration(label: Text('Prénom*:')),
                ),
                TextFormField(
                  controller: controllerMobile,
                  keyboardType: TextInputType.phone,
                  autofillHints: const [AutofillHints.telephoneNumber],
                  onChanged: (value) => userInfo.mobile = value,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[+0-9]'))],
                  maxLength: 12,
                  decoration: InputDecoration(label: Text('Mobile:'), counter: SizedBox()),
                ),
                TextFormField(
                  controller: controller,
                  validator: isEmailValid,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  onChanged: (value) => userInfo.email = value,
                  decoration: InputDecoration(label: Text('Email*:')),
                ),
                TextFormField(
                  controller: controllerPass,
                  obscureText: true,
                  validator: isPasswordValid,
                  autofillHints: const [AutofillHints.newPassword],
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) => userInfo.password = value,
                  decoration: InputDecoration(label: Text('Mot de passe*:')),
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
                      userInfo.firstName = controllerFirstName.text;
                      userInfo.lastName = controllerLastName.text;
                      userInfo.email = controller.text;
                      userInfo.mobile = controllerMobile.text;
                      userInfo.password = controllerPass.text;
                      onContinue();
                    }
                  },
                  child: Text(userInfo.type == UserTypeEnum.patient ? 'Envoyer' : 'Continuer'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
