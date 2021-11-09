import 'package:flutter/material.dart';

class BgContainer extends StatelessWidget {
  final Widget child;

  const BgContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/ahsi_bg.jpg"), fit: BoxFit.cover),
        ),
        child: child,
      ),
    );
  }
}
