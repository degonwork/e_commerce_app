import 'package:e_commerce_app_getx/ui/pages/cart/cart_history_page.dart';
import 'package:e_commerce_app_getx/ui/pages/home/main_product_page.dart';
import 'package:e_commerce_app_getx/ui/utils/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectIndex = 0;
  List pages = [
    MainFoodPage(),
    Container(child: Center(child: Text('Next page'))),
    CartHistoryPage(),
    Container(child: Center(child: Text('Next next next page'))),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectIndex,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
