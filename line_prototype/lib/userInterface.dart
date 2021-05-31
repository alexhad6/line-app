import 'package:flutter/material.dart';

class UserInterface {
  void start() => runApp(_App());
}

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Line Prototype',
      theme: ThemeData(
        primaryColor: Colors.indigo[300],
      ),
      home: _HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  final List<Widget> pages = <Widget>[
    Container(
      key: PageStorageKey<String>('page1'),
      alignment: Alignment.center,
      child: Text('Home Page', style: TextStyle(fontSize: 36.0)),
    ),
    ListView.builder(
      key: PageStorageKey<String>('page2list'),
      padding: EdgeInsets.all(0),
      itemCount: 1000,
      itemBuilder: (BuildContext context, int index) => Container(
        height: 50.0,
        color: Colors.amber[300],
        child: Center(child: Text('Entry $index')),
      ),
    ),
    Container(
      key: PageStorageKey<String>('page3'),
      alignment: Alignment.center,
      child: Text('Create Line', style: TextStyle(fontSize: 36.0)),
    ),
    Container(
      key: PageStorageKey<String>('page4'),
      alignment: Alignment.center,
      child: Text('Settings', style: TextStyle(fontSize: 36.0)),
    ),
  ];
  int _selectedIndex = 0;
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          _TopBar(),
          Expanded(
            child: PageStorage(
              child: pages[_selectedIndex],
              bucket: _bucket,
            ),
          ),
          _NavigationBar(
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

class _TopBar extends StatelessWidget {
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

class _NavigationBar extends StatelessWidget {
  _NavigationBar({
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
