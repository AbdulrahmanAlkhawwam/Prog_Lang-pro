import 'package:flutter/material.dart';

import '../constants/strings.dart';

class AppBottomBar extends StatefulWidget {
  final Function(dynamic) onTap;

  const AppBottomBar({super.key, required this.onTap});

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  int index = 0;

  @override
  BottomNavigationBar build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        setState(() => index = value);
        widget.onTap(value);
      },
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.storefront_outlined),
          label: shops,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined),
          label: purchase,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: cart,
        ),
      ],
    );
  }
}
