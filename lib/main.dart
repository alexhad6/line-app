import 'package:flutter/widgets.dart';

void main() {
  runApp(WidgetsApp(
    pageRouteBuilder: <T>(settings, build) => PageRouteBuilder(
      pageBuilder: (context, _, __) => build(context),
    ),
    home: HomePage(),
    title: 'Line Prototype',
    textStyle: const TextStyle(
      color: Color(0xFF000000),
      fontSize: 36.0,
      fontWeight: FontWeight.bold,
    ),
    color: Color(0xFF0000FF),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFFFFFF),
      child: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Text('Line Prototype'),
        ),
      ),
    );
  }
}
