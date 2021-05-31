import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Line Prototype',
    theme: ThemeData(
      primaryColor: Colors.indigo[300],
    ),
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          TopBar(),
          Expanded(
            child: Center(
              child: Text('Page ${_selectedIndex + 1}'),
            ),
          ),
          NavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final double padding = 12.0;

  @override
  Widget build(BuildContext context) {
    final double _safePaddingTop = MediaQuery.of(context).padding.top;

    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(
        top: _safePaddingTop == 0 ? padding : _safePaddingTop,
        bottom: padding,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          'Line App',
          style: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class NavigationBar extends StatelessWidget {
  NavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  final int currentIndex;
  final ValueChanged<int> onTap;
  final double padding = 12.0;

  @override
  Widget build(BuildContext context) {
    final double _safePaddingBottom = MediaQuery.of(context).padding.bottom;

    const List<IconData> icons = [
      Icons.home,
      Icons.account_circle,
      Icons.view_list,
      Icons.settings,
    ];

    return Container(
      color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          for (var index = 0; index < icons.length; index++)
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: padding,
                    bottom:
                        _safePaddingBottom == 0 ? padding : _safePaddingBottom,
                  ),
                  child: Icon(
                    icons[index],
                    color: index == currentIndex ? Colors.white : Colors.black,
                  ),
                ),
                onTap: () => onTap(index),
              ),
            ),
        ],
      ),
    );
  }
}
