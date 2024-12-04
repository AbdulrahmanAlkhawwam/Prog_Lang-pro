import 'package:flutter/material.dart';

import '../../../core/components/search_input.dart';
import '../../../core/utils/app_context.dart';
import '../../widgets/shop/shops_list.dart';
import '../auth/register_screen.dart';

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
            onTap: () {
              context.push(MaterialPageRoute(
                builder: (context) => RegisterScreen(),
              ));
            },
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
