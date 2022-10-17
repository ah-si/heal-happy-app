import 'package:flutter/material.dart';

enum RouteTransitionType {
  fromBottom, fade
}

class RouteArguments {
  final dynamic arguments;
  final RouteTransitionType type;

  RouteArguments({this.arguments, this.type = RouteTransitionType.fade});
}

class FadePageRoute extends PageRouteBuilder {
  final WidgetBuilder builder;
  @override
  final RouteSettings settings;

  FadePageRoute({required this.builder, required this.settings})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return builder(context);
          },
          transitionsBuilder: (context, anim1, anim2, child) {
            return FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(anim1),
              child: child,
            );
          },
          settings: settings,
        );
}

class FromBottomPageRoute extends PageRouteBuilder {
  final WidgetBuilder builder;
  @override
  final RouteSettings settings;

  FromBottomPageRoute({required this.builder, required this.settings})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return builder(context);
          },
          transitionsBuilder: (context, anim1, anim2, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(anim1),
              child: FadeTransition(
                opacity: Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(anim1),
                child: child,
              ),
            );
          },
          opaque: false,
          settings: settings,
        );
}
