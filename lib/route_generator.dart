import 'package:flutter/material.dart';
import 'package:myapp/avaliacoes.dart';
import 'package:myapp/local.dart';
import 'package:myapp/main.dart';
import 'package:myapp/menu.dart';
import 'package:myapp/perfil.dart';

class NoAnimationPageRoute<T> extends PageRouteBuilder<T> {
  NoAnimationPageRoute({required WidgetBuilder builder})
    : super(
        pageBuilder:
            (context, animation, secondaryAnimation) => builder(context),
        transitionDuration: Duration.zero,
      );
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "menu":
        return NoAnimationPageRoute(builder: (_) => Menu());
      case "home":
        return NoAnimationPageRoute(builder: (_) => MyHomePage());
      case "perfil":
        return NoAnimationPageRoute(builder: (_) => Perfil());
      case "local":
        return NoAnimationPageRoute(builder: (_) => Local());
      case "avaliacoes":
        return NoAnimationPageRoute(builder: (_) => Avaliacoes());

      default:
        return _erroRoute();
    }
  }

  static Route<dynamic> _erroRoute() {
    return NoAnimationPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text("Tela não encontrada")),
          body: Center(child: Text("Tela não encontrada")),
        );
      },
    );
  }
}
