import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Class for the user interface component.
class UserInterface {
  void start() {
    runApp(MaterialApp(
      title: 'Line Prototype',
      theme: ThemeData(
        primaryColor: Colors.indigo[300],
      ),
      home: _TopPage(),
    ));
  }
}

class _TopPage extends StatefulWidget {
  const _TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<_TopPage> {
  final List<Widget> pages = <Widget>[
    _HomePage(),
    _ScannerPage(),
    _CreatePage(),
    _SettingsPage(),
  ];
  int _pageNumber = 0;
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Material(
      child: Column(
        children: <Widget>[
          _TopBar(),
          Expanded(
            child: PageStorage(child: pages[_pageNumber], bucket: _bucket),
          ),
          _NavigationBar(
            currentIndex: _pageNumber,
            onTap: (index) {
              setState(() {
                _pageNumber = index;
              });
            },
          ),
        ],
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey<String>('page1'),
      alignment: Alignment.center,
      child: Text('Home Page', style: TextStyle(fontSize: 36.0)),
    );
  }
}

class _ScannerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: PageStorageKey<String>('page2list'),
      padding: EdgeInsets.all(0),
      itemCount: 10000,
      itemBuilder: (BuildContext context, int index) => Container(
        height: 50.0,
        color: Colors.amber[(index % 9 + 1) * 100],
        child: Center(child: Text('Entry $index')),
      ),
    );
  }
}

class _CreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey<String>('page3'),
      alignment: Alignment.center,
      child: Text('Create Line', style: TextStyle(fontSize: 36.0)),
    );
  }
}

class _SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey<String>('page4'),
      alignment: Alignment.center,
      child: Text('Settings', style: TextStyle(fontSize: 36.0)),
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
