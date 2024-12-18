import 'package:flutter/material.dart';

import '../../widgets/shop/shops_list.dart';

class ShopsScreen extends StatelessWidget {
  ShopsScreen({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ShopsList(),
      ),
    );
  }
}
