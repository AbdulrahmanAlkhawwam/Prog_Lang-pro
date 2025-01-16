import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:program_language_project/src/features/product/presentation/widgets/product_item.dart';

import '../../../../core/service_locator/service_locator.dart';
import '../manger/product_bloc.dart';

class ProductsScreen extends StatelessWidget {
  final int id;

  const ProductsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<ProductBloc>(), //..add(Getproduct),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("selected product"),
            ),
            body: ListView.separated(
              itemBuilder: (context, index) => ProductItem(
                product: state.products[index],
                inCartScreen: false,
                inShop: false,
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemCount: state.products.length,
            ),
          );
        },
      ),
    );
  }
}
