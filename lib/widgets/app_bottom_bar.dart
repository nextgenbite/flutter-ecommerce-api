import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBottomBar extends StatefulWidget {
  final int currentIndex;
  const AppBottomBar({super.key, required this.currentIndex});

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  final List<String> _pages = ['/', '/cart', '/profile'];

  void _onItemTapped(int index) {
    if (widget.currentIndex != index) {
      Navigator.pushReplacementNamed(context, _pages[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.house),
          label: 'Home',
          activeIcon: Icon(CupertinoIcons.house_fill),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.cart),
          label: 'Cart',
          activeIcon: Icon(CupertinoIcons.cart_fill),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person),
          label: 'Profile',
          activeIcon: Icon(CupertinoIcons.person_fill),
        ),
      ],
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      currentIndex: widget.currentIndex,
      onTap: _onItemTapped,
    );
  }
}
