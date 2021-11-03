import 'package:flutter/material.dart';
import 'package:heal_happy/common/utils/constants.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircularProgressIndicator.adaptive(),
          SizedBox(height: kNormalPadding),
          Text('Chargement en cours...', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
