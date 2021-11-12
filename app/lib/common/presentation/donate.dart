import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';

class Donate extends StatelessWidget {
  const Donate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(context.l10n.donateIntro),
          const SizedBox(height: kSmallPadding),
          SelectableText(
            'Nom: ONG AH-SI',
            style: const TextStyle(fontWeight: FontWeight.bold),
            onTap: () {
              Clipboard.setData(const ClipboardData(text: 'ONG AH-SI'));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text( context.l10n.itemCopied('Nom'))));
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
