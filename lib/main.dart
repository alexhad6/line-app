import 'package:flutter/widgets.dart';

void main() {
  runApp(App(
    title: 'Line Prototype',
    textStyle: const TextStyle(
      color: Color(0xFF000000),
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
    ),
    home: HomePage(
      title: 'Line Prototype',
      backgroundColor: Color(0xFFFFFFFF),
    ),
  ));
}

class App extends StatelessWidget {
  App({
    Key? key,
    required this.title,
    required this.textStyle,
    required this.home,
  }) : super(key: key);

  final String title;
  final TextStyle textStyle;
  final Widget home;

  PageRoute<T> _pageRouteBuilder<T>(
      RouteSettings settings, WidgetBuilder build) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, _, __) => build(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      pageRouteBuilder: _pageRouteBuilder,
      textStyle: textStyle,
      home: home,
      title: title,
      color: Color(0xFF0000FF),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
    required this.title,
    required this.backgroundColor,
  }) : super(key: key);

  final String title;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: backgroundColor,
        child: Container(
          alignment: Alignment.topCenter,
          color: Color(0xFF0000FF),
          height: 0.1,
          child: Text(title),
        ),
      ),
    );
  }
}
