import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../core/components/search_input.dart';
import '../../mangers/shops/Shops_bloc.dart';
import '../../widgets/shop/shops_list.dart';

class ShopsScreen extends StatelessWidget {
  ShopsScreen({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopsBloc, ShopsState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: switch (state.status) {
              ShopsStatus.loading =>
                Center(child: CircularProgressIndicator()),
              ShopsStatus.error =>
                Center(child: Text('Error loading stores #${state.message.toString()}')),
              _ => Column(
                  children: [
                    SearchInput(
                      onTap: () {},
                      hint: "Search",
                      onChanged: null,
                      controller: controller,
                    ),
                    Expanded(
                        child: ShopsList(
                      shops: state.shops ?? [],
                    )),
                  ],
                ),
            },
          ),
        );
      },
    );
  }
}


















/*
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



*/