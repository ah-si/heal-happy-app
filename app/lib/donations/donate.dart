import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/common/config.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/presentation/loading.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/donations/stores/donations_store.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stripe_checkout/stripe_checkout.dart';

class DonateSuccess extends StatelessWidget {
  static const name = 'donateSuccess';
  final bool isSuccess;

  const DonateSuccess({Key? key, this.isSuccess = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BgContainer(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kNormalPadding),
            child: Column(
              children: [
                Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 180,
                  ),
                ),
                const SizedBox(height: 30),
                IntroDialog(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    children: [
                      Text(
                        isSuccess ? context.l10n.donateSuccess : context.l10n.donateCancelled,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: kNormalPadding),
                      TextButton(
                        onPressed: () {
                          context.go('/');
                        },
                        child: Text(context.l10n.backToWebsite),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DonateCancelled extends StatelessWidget {
  static const name = 'donateCancelled';

  const DonateCancelled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DonateSuccess(isSuccess: false);
  }
}

class DonateScreen extends StatelessWidget {
  static const name = 'donate';

  const DonateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BgContainer(
      child: Center(
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
                  IntroDialog(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      children: [
                        Donate(
                          onCancelled: () {
                            context.goNamed(DonateCancelled.name);
                          },
                          onSuccess: () {
                            context.goNamed(DonateSuccess.name);
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            context.go('/');
                          },
                          child: Text(context.l10n.backToWebsite),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class Donate extends HookWidget {
  final VoidCallback onSuccess;
  final VoidCallback onCancelled;

  const Donate({Key? key, required this.onSuccess, required this.onCancelled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useTabController(initialLength: 2);
    return Column(
      children: [
        TabBar(
          controller: controller,
          tabs: [
            Tab(
              child: Text(
                context.l10n.donateByCard.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: kPrimaryColor),
              ),
            ),
            Tab(
              child: Text(
                context.l10n.donateByWire.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: kPrimaryColor),
              ),
            ),
          ],
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 300),
          child: TabBarView(
            controller: controller,
            children: [
              PaymentByCard(
                onCancelled: onCancelled,
                onSuccess: onSuccess,
              ),
              const DonateByBankTransfert(),
            ],
          ),
        ),
      ],
    );
  }
}

class PaymentByCard extends HookConsumerWidget {
  final bool isDonation;
  final VoidCallback onSuccess;
  final VoidCallback onCancelled;

  const PaymentByCard({Key? key, this.isDonation = true, required this.onSuccess, required this.onCancelled})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(donateStoreProvider);

    useEffect(() {
      if (isDonation) {
        store.donateMode = DonateMode.oneTime;
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        store.loadPaymentProducts(isDonation);
      });
      return null;
    }, const []);

    if (store.productsResults == null) {
      return const Loading();
    }

    if (store.productsResults?.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Text(
            store.productsResults!.error!.cause.twoLiner(context),
            style: TextStyle(color: context.theme.colorScheme.error),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(kNormalPadding),
      child: Column(
        children: [
          if (!isDonation) Text(context.l10n.subscriptionRenewal),
          if (isDonation)
            CheckboxListTile(
              value: store.donateMode == DonateMode.recurrent,
              onChanged: (value) {
                store.donateMode = value! ? DonateMode.recurrent : DonateMode.oneTime;
              },
              title: Text(context.l10n.donateRecurrent),
            ),
          const SizedBox(
            height: kSmallPadding,
          ),
          Wrap(
            runSpacing: kSmallPadding,
            spacing: kSmallPadding,
            alignment: WrapAlignment.center,
            children: store.productsResults!.products
                .map((e) => ElevatedButton(
                      key: ValueKey(e.id),
                      onPressed: () async {
                        final userStore = ref.read(userStoreProvider);
                        final success = await showLoadingDialog(context, (_) => Text(context.l10n.loading), () async {
                          await store.loadPaymentSessionId(e, isDonation, userStore.user?.email);
                        });

                        if (success) {
                          final result = await redirectToCheckout(
                            context: context,
                            sessionId: store.sessionId,
                            publishableKey: getStripeKey(),
                            successUrl: '${Config().baseUrl}/${DonateSuccess.name}',
                            canceledUrl: '${Config().baseUrl}/${DonateCancelled.name}',
                          );
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            userStore.reloadUser();
                            result.when(
                              redirected: () {},
                              success: onSuccess,
                              canceled: onCancelled,
                              error: (error) {
                                //FIXME in web it crash but works so ignore error for now showErrorDialog(context, error, StackTrace.current);
                              },
                            );
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(kNormalPadding),
                        child: Text('${(e.price / 100).toStringAsFixed(0)} ${e.currency.toUpperCase()}'),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class DonateByBankTransfert extends StatelessWidget {
  const DonateByBankTransfert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: kNormalPadding),
          Text(context.l10n.donateIntro),
          const SizedBox(height: kSmallPadding),
          SelectableText(
            'Nom: ONG AH-SI',
            style: const TextStyle(fontWeight: FontWeight.bold),
            onTap: () {
              Clipboard.setData(const ClipboardData(text: 'ONG AH-SI'));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.itemCopied('Nom'))));
            },
          ),
          SelectableText(
            'Banque: BCV, Banque Cantonale Vaudoise',
            style: const TextStyle(fontWeight: FontWeight.bold),
            onTap: () {
              Clipboard.setData(const ClipboardData(text: 'BCV, Banque Cantonale Vaudoise'));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.itemCopied('Banque'))));
            },
          ),
          SelectableText(
            'IBAN: CH50 0076 7000 Z552 7783 3',
            style: const TextStyle(fontWeight: FontWeight.bold),
            onTap: () {
              Clipboard.setData(const ClipboardData(text: 'CH5000767000Z55277833'));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.itemCopied('IBAN'))));
            },
          ),
          SelectableText(
            'SWIFT/BIC: BCVLCH2LXXX',
            style: const TextStyle(fontWeight: FontWeight.bold),
            onTap: () {
              Clipboard.setData(const ClipboardData(text: 'BCVLCH2LXXX'));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.itemCopied('SWIFT/BIC'))));
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
            child: Text(context.l10n.donateInstructions),
          ),
          const Text('''
1. SOIGNEZ HEUREUX, Téléconsultation par internet
2. SOIGNEZ HEUREUX, consultation directe, en présentiel
'''),
        ],
      ),
    );
  }
}

class DonateBanner extends StatelessWidget {
  const DonateBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.primaryColor,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            showAppDialog(
              context,
              (_) => Text(context.l10n.donate),
              (_) => Donate(
                onCancelled: () {
                  context.goNamed(DonateCancelled.name);
                },
                onSuccess: () {
                  context.goNamed(DonateSuccess.name);
                },
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kNormalPadding, vertical: kSmallPadding),
            child: Text(
              context.l10n.donateDescription,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
