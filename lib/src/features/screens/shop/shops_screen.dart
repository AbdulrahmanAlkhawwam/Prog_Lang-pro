import 'package:flutter/material.dart';

import '../../../core/components/search_input.dart';
import '../../widgets/shop/shops_list.dart';

class ShopsScreen extends StatelessWidget {
  ShopsScreen({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SearchInput(
            onTap: () {},
            hint: "Search",
            onChanged: null,
            controller: null,
          ),
          Expanded(child: ShopsList()),
        ],
      ),
    ));
  }
}
