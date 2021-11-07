import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heal_happy/common/utils/constants.dart';

class Donate extends StatelessWidget {
  const Donate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Voici les informations pour faire vos dons par virement bancaire: '),
          const SizedBox(height: kSmallPadding),
          SelectableText(
            'Nom : ONG AH-SI',
            style: const TextStyle(fontWeight: FontWeight.bold),
            onTap: () {
              Clipboard.setData(const ClipboardData(text: 'ONG AH-SI'));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nom copié dans le presse-papiers')));
            },
          ),
          SelectableText(
            'Banque : BCV, Banque Cantonale Vaudoise',
            style: const TextStyle(fontWeight: FontWeight.bold),
            onTap: () {
              Clipboard.setData(const ClipboardData(text: 'BCV, Banque Cantonale Vaudoise'));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Banque copié dans le presse-papiers')));
            },
          ),
          SelectableText(
            'IBAN : CH50 0076 7000 Z552 7783 3',
            style: const TextStyle(fontWeight: FontWeight.bold),
            onTap: () {
              Clipboard.setData(const ClipboardData(text: 'CH5000767000Z55277833'));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('IBAN copié dans le presse-papiers')));
            },
          ),
          SelectableText(
            'SWIFT/BIC : BCVLCH2LXXX',
            style: const TextStyle(fontWeight: FontWeight.bold),
            onTap: () {
              Clipboard.setData(const ClipboardData(text: 'BCVLCH2LXXX'));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('SWIFT/BIC copié dans le presse-papiers')));
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: kSmallPadding),
            child: Text('Si vous faîtes un don, merci de préciser votre destination de don dans le champ information :'),
          ),
          const Text('''
1. SOIGNEZ HEUREUX, Téléconsultation par internet
2. SOIGNEZ HEUREUX, consultation directe, en présentiel
3. TCLC, T’as compris le coup ? (soutien pour les enfants)
4. Don en général pour l’ONG'''),
        ],
      ),
    );
  }
}
