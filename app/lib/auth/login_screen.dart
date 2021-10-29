import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/auth/register_screen.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/form_validators.dart';
import 'package:heal_happy/home/home_screen.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  static const name = 'login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: 'jimmy.aumard@gmail.com');
    final controllerPass = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    return DecoratedBox(
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
                      height: 180,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 400),
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
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: controller,
                              validator: isEmailValid,
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: const [AutofillHints.email],
                              decoration: InputDecoration(label: Text('Email*:')),
                            ),
                            TextFormField(
                              controller: controllerPass,
                              obscureText: true,
                              validator: isRequired,
                              keyboardType: TextInputType.text,
                              autofillHints: const [AutofillHints.password],
                              decoration: InputDecoration(label: Text('Mot de passe*:')),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(kNormalPadding),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    final store = ref.read(userStoreProvider);
                                    try {
                                      await store.login(controller.text, controllerPass.text);
                                      context.goNamed(HomeScreen.name);
                                    } catch (err, stack) {}
                                  }
                                },
                                child: Text('Connexion'),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.goNamed(RegisterScreen.name);
                              },
                              child: Text('Je n\'ai pas de compte, m\'inscrire'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.goNamed(RegisterScreen.name);
                              },
                              child: Text('J\'ai oublié mon mot de passe'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
