import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/homeScreen.dart';
import 'package:furniture_app/pages/navbar/basket.dart';
import 'package:furniture_app/pages/navbar/favorite.dart';
import 'package:furniture_app/pages/navbar/notification.dart';
import 'package:furniture_app/pages/navbar/user.dart';

import '../../Items_upload_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

const List<Widget> pages = [
  HomeScreen(),
  FavoriteProduct(),
  BasketScreen(),
  NotificationScreeen(),
  UserScreen()
];
int curIndex = 0;
int index = 0;
// TabController = _tabController;

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: pages.length, vsync: this);
    int t = _tabController.index;
    setState(() {
      curIndex = t;
    });
    print("indexTab:$curIndex");
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void onTap(int i) {
    setState(() {
      curIndex = i;
    });
    int t = _tabController.index;
    print('click index=$t');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Builder(
        builder: (context) {
          index = DefaultTabController.of(context).index;

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                color: Colors.black,
                icon: const Icon(Icons.menu),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('This is a snackbar')));
                },
              ),
              backgroundColor: Colors.white,
              title: const Text(
                'Тавилга захиалга',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 2,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => const ItemsUploadScreen()),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            body: TabBarView(
              // controller: _tabController,
              controller: _tabController,
              physics: const BouncingScrollPhysics(),
              children: pages,
            ),

            // pages[curIndex],
            bottomNavigationBar: Container(
              padding: const EdgeInsets.all(10),
              height: 70,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: HexColor.fromHex("#0C1A4B"),
                    unselectedLabelColor: Colors.grey,
                    labelStyle: const TextStyle(fontSize: 10),
                    indicatorColor: HexColor.fromHex("#0C1A4B"),
                    tabs: const <Widget>[
                      Tab(icon: Icon(Icons.home)),
                      Tab(icon: Icon(Icons.favorite)),
                      Tab(icon: Icon(Icons.shopping_basket)),
                      Tab(icon: Icon(Icons.notifications)),
                      Tab(icon: Icon(Icons.manage_accounts)),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
