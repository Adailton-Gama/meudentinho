import 'package:flutter/material.dart';
import 'package:meudentinho/pages/especialistas.dart';
import 'package:meudentinho/pages/nossahistoria.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/home': (_) => const NossaHistoria(),
    '/notificacao': (_) => const Especialistas(),
  };

  static String initial = '/home';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
