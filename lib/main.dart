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
  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K'
  ];
  final List<int> colorCodes = <int>[
    50,
    100,
    200,
    300,
    400,
    500,
    600,
    700,
    800,
    900
  ];

  Widget _selectPage(int pageNumber) {
    switch (pageNumber) {
      case 0:
        return Container();
      case 1:
        return ListView.builder(
            key: ValueKey('page2list'),
            padding: const EdgeInsets.all(0),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                color: Colors.amber[colorCodes[index]],
                child: Center(child: Text('Entry ${entries[index]}')),
              );
            });
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          TopBar(),
          Expanded(
            child: _selectPage(_selectedIndex),
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
    final double iconSize = 30.0;

    const List<IconData> unselectedIcons = [
      Icons.home_outlined,
      Icons.qr_code_scanner_outlined,
      Icons.add_circle_outline,
      Icons.settings_outlined,
    ];

    const List<IconData> selectedIcons = [
      Icons.home,
      Icons.qr_code_scanner,
      Icons.add_circle,
      Icons.settings,
    ];

    return Container(
      color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          for (var index = 0; index < unselectedIcons.length; index++)
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
                    index == currentIndex
                        ? selectedIcons[index]
                        : unselectedIcons[index],
                    color: index == currentIndex ? Colors.white : Colors.black,
                    size: iconSize,
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
