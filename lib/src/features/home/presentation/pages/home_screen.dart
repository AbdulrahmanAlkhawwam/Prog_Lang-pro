import 'package:flutter/material.dart';

import '../../../../core/components/search_input.dart';
import '../../../../core/utils/app_context.dart';
import '../pages/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SearchInput(
            onTap: () {
              context.push(
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
            hint: "Search",
            onChanged: null,
            controller: null,
          ),
        ],
      ),
    ));
  }
}
