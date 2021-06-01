import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:line_prototype/database.dart';

final database = Database.instance;

/// Class for the user interface component.
class UserInterface {
  UserInterface._();

  static final UserInterface instance = UserInterface._();

  void start(Future<void> Function() load) {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(_App(load: load()));
  }
}

class _App extends StatefulWidget {
  const _App({Key? key, required Future<void> load})
      : _load = load,
        super(key: key);

  final Future<void> _load;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<_App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Line Prototype',
      theme: ThemeData(
        primaryColor: Colors.indigo[300],
      ),
      home: FutureBuilder(
        future: widget._load,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _Error();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return _TopPage();
          }
          return _Loading();
        },
      ),
    );
  }
}

class _Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text('Error :('),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text('Loading...'),
      ),
    );
  }
}

class _TopPage extends StatefulWidget {
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<_TopPage> {
  final List<Widget> pages = <Widget>[
    _HomePage(),
    _ScannerPage(key: PageStorageKey<String>('scannerPage')),
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
            child: PageStorage(
              child: pages[_pageNumber],
              bucket: _bucket,
            ),
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
  const _HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text('Home Page', style: TextStyle(fontSize: 36.0)),
    );
  }
}

class _ScannerPage extends StatelessWidget {
  const _ScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
  const _CreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Spacer(),
            Text('Create Line', style: TextStyle(fontSize: 36.0)),
            Spacer(flex: 10),
            Text('Enter line name below: '),
            TextField(
              onSubmitted: (String lineName) async {
                await database.addLine(
                  lineName: lineName,
                  people: [],
                  waitTime: 0,
                );
              },
            ),
            Spacer(flex: 10),
          ],
        ),
      ),
    );
  }
}

class _SettingsPage extends StatelessWidget {
  const _SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text('Settings', style: TextStyle(fontSize: 36.0)),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({Key? key}) : super(key: key);

  final double padding = 12.0;

  @override
  Widget build(BuildContext context) {
    final double _safePaddingTop = MediaQuery.of(context).viewPadding.top;

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
    final double _safePaddingBottom = MediaQuery.of(context).viewPadding.bottom;
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
