part of 'register_screen.dart';

class _StepSocial extends HookConsumerWidget {
  final VoidCallback onContinue;

  const _StepSocial({required this.onContinue, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider);
    final controllerWebsite = useTextEditingController(text: userInfo.website);
    final controllerSocial1 = useTextEditingController(text: userInfo.social1);
    final controllerSocial2 = useTextEditingController(text: userInfo.social2);
    final controllerSocial3 = useTextEditingController(text: userInfo.social3);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Si vous le souhaitez, vous pouvez renseigner vos liens sociaux:',
          style: context.textTheme.headline5,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: controllerWebsite,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(label: Text('Website:')),
              ),
              TextFormField(
                controller: controllerSocial1,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(label: Text('Réseau social 1:')),
              ),
              TextFormField(
                controller: controllerSocial2,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(label: Text('Réseau social 2:')),
              ),
              TextFormField(
                controller: controllerSocial3,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(label: Text('Réseau social 3:')),
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
                  userInfo.website = controllerWebsite.text;
                  userInfo.social1 = controllerSocial1.text;
                  userInfo.social2 = controllerSocial2.text;
                  userInfo.social3 = controllerSocial3.text;
                  onContinue();
                },
                child: Text('Envoyer'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
