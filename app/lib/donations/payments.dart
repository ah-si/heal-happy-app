import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/donations/donate.dart';

class PaymentSuccess extends StatelessWidget {
  static const name = 'subscriptionSuccess';
  final bool isSuccess;

  const PaymentSuccess({Key? key, this.isSuccess = true}) : super(key: key);

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
                        isSuccess ? context.l10n.paymentSuccess : context.l10n.paymentCancelled,
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

class PaymentCancelled extends StatelessWidget {
  static const name = 'subscriptionCancelled';

  const PaymentCancelled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PaymentSuccess(isSuccess: false);
  }
}

class SubscriptionPayment extends HookWidget {
  final VoidCallback onSuccess;
  final VoidCallback onCancelled;

  const SubscriptionPayment({Key? key, required this.onSuccess, required this.onCancelled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaymentByCard(
      isDonation: false,
      onCancelled: onCancelled,
      onSuccess: onSuccess,
    );
  }
}
