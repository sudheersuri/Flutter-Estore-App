import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/login.dart';
import 'package:practice/pages/search.dart';
import 'package:practice/pages/account.dart';
import 'package:practice/providers/global_state.dart';
import 'package:practice/widgets/cart_icon_with_badge.dart';
import 'package:practice/pages/favorites.dart';
import 'package:practice/pages/home.dart';
import 'package:practice/pages/cart.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Store',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF0F1F2),
        primaryColor: const Color(0xFF000000), // Primary color
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFF0F1F2), // Secondary color
        ),
      ),
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Home(),
    Search(),
    Cart(),
    Favorites(),
    Account(),
  ];
  @override
  Widget build(BuildContext context) {
  final isLoggedIn = ref.watch(loggedInProvider);
    if (!isLoggedIn) {
        return Login();
    }
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        toolbarHeight: 0,
      ),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: Colors.black),
            label: 'Home',
            activeIcon: (Icon(Icons.home, color: Colors.black)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Catalog',
            activeIcon: (Icon(Icons.search, color: Colors.black)),
          ),
          BottomNavigationBarItem(
            icon: Carticonwithbadge(active: false),
            label: 'Cart',
            activeIcon: Carticonwithbadge(active: true),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favorite',
            activeIcon: (Icon(Icons.favorite, color: Colors.black)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Account',
            activeIcon: (Icon(Icons.account_circle, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
