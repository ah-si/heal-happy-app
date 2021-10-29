import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/auth/login_screen.dart';
import 'package:heal_happy/auth/models/user_info.dart';
import 'package:heal_happy/common/presentation/autocomplete_field.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/common/utils/form_validators.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final infoPersoStepValidationProvider = Provider((ref) {
  final info = ref.watch(userInfoProvider);
  return !info.firstName.isNullOrEmpty && !info.lastName.isNullOrEmpty && !info.email.isNullOrEmpty && !info.password.isNullOrEmpty;
});

class RegisterScreen extends HookConsumerWidget {
  static const name = 'register';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider);
    final controller = usePageController();
    return WillPopScope(
      onWillPop: () async {
        if ((controller.page ?? 0) > .0) {
          controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
          return false;
        }
        return true;
      },
      child: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/ahsi_bg.jpg"), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(kNormalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 160,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 500),
                        padding: const EdgeInsets.all(kNormalPadding),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: kPrimaryColor,
                                blurRadius: 15,
                                offset: Offset(4, 6), // Shadow position
                              ),
                            ],
                            border: Border.all(
                              color: kAccentColor,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(kSmallPadding))),
                        child: PageView.builder(
                          controller: controller,
                          itemBuilder: (BuildContext context, int index) {
                            next() => controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                            switch (index) {
                              case 1:
                                return _StepPersonalInfo(onContinue: next);
                              case 2:
                                return _StepSocial(onContinue: next);
                              case 3:
                                return _StepInfoPro(onContinue: next);
                              case 4:
                                return _StepAddress(onContinue: next);
                            }
                            return _StepType(
                              onContinue: next,
                            );
                          },
                          itemCount: userInfo.type == UserTypeEnum.patient ? 2 : 5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
    final controllerConsultation = useTextEditingController(text: userInfo.consultationTime?.toString() ?? '');
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Merci de remplir vos informations professionelles:',
            style: context.textTheme.headline5,
          ),
          AutocompleteFormField<MapEntry<String, String>>(
            decoration: InputDecoration(label: Text('Spécialité*:')),
            characterThreshold: 0,
            controller: controllerSpe,
            delegate: (String query) async {
              if (query.isEmpty) {
                return specialities.entries.toList(growable: false);
              }
              return specialities.entries.where((element) => element.value.toLowerCase().contains(query.toLowerCase())).toList(growable: false);
            },
            validator: (value) {
              final result = isRequired(value);
              if (result == null && userInfo.job == null) {
                return isRequired(null);//force required message
              }
              return result;
            },
            itemBuilder: (BuildContext context, MapEntry<String, String> entry) {
              return ListTile(title: Text(entry.value));
            },
            onItemSelected: (MapEntry<String, String> entry) {
              controllerSpe.text = entry.value;
              userInfo.job = entry.key;
            },
          ),
          TextFormField(
            controller: controllerConsultation,
            validator: isRequired,
            keyboardType: const TextInputType.numberWithOptions(),
            decoration: InputDecoration(label: Text('Durée d\'une consultation*:'), hintText: 'A spécifier en minute'),
          ),
          TextFormField(
            controller: controllerDescription,
            validator: isRequired,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(label: Text('Description*:')),
            maxLines: 4,
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

class _StepTypeAvatar extends HookConsumerWidget {
  final VoidCallback onContinue;
  final IconData icon;
  final Color color;
  final String label;

  const _StepTypeAvatar({
    Key? key,
    required this.onContinue,
    required this.label,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: color,
          child: Stack(
            children: [
              Center(
                child: Icon(
                  icon,
                  size: 40,
                  semanticLabel: label,
                ),
              ),
              Material(
                type: MaterialType.circle,
                clipBehavior: Clip.antiAlias,
                color: Colors.transparent,
                child: InkWell(
                  onTap: onContinue,
                ),
              ),
            ],
          ),
        ),
        Text(label),
      ],
    );
  }
}

class _StepType extends HookConsumerWidget {
  final VoidCallback onContinue;

  const _StepType({Key? key, required this.onContinue}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(kNormalPadding),
            child: Text(
              'Vous êtes:',
              style: context.textTheme.headline5,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _StepTypeAvatar(
              onContinue: () {
                userInfo.type = UserTypeEnum.patient;
                onContinue();
              },
              label: 'Patient',
              icon: Icons.person,
              color: userInfo.type == UserTypeEnum.patient ? context.primaryColor : Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(width: 50),
            _StepTypeAvatar(
              onContinue: () {
                userInfo.type = UserTypeEnum.healer;
                onContinue();
              },
              label: 'Soignant',
              color: userInfo.type == UserTypeEnum.healer ? context.primaryColor : Colors.grey.withOpacity(0.5),
              icon: Icons.healing,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(kBigPadding),
          child: TextButton(
            onPressed: () {
              context.goNamed(LoginScreen.name);
            },
            child: Text('J\'ai déjà un compte, me connecter'),
          ),
        ),
      ],
    );
  }
}

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
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Merci de remplir vos informations personnel:',
            style: context.textTheme.headline5,
          ),
          const Spacer(),
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
            decoration: InputDecoration(label: Text('Mobile:')),
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
          const Spacer(),
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Si vous le souhaitez, vous pouvez renseigner vos liens sociaux:',
          style: context.textTheme.headline5,
        ),
        const Spacer(),
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
        const Spacer(),
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
                child: Text('Continuer'),
              ),
            ),
          ],
        ),
      ],
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
    final formKey = useMemoized(() => GlobalKey<FormState>());
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Merci de remplir votre adresse:',
            style: context.textTheme.headline5,
          ),
          const Text('Elle sera utilisée afin que les patients proche de vous puissent vous trouver'),
          const Spacer(),
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
            onChanged: (value) => userInfo.email = value,
            decoration: InputDecoration(label: Text('Code postale*:')),
          ),
          const Spacer(),
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
                      userInfo.street = controllerStreet.text;
                      userInfo.street2 = controllerStreet2.text;
                      userInfo.city = controllerCity.text;
                      userInfo.zipCode = controllerZipCode.text;
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
