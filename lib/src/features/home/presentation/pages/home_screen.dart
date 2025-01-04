import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:program_language_project/src/features/product/presentation/manger/product_bloc.dart';

import '../../../../core/components/search_input.dart';
import '../../../../core/utils/app_context.dart';
import '../../../shop/presentation/manger/shop_bloc.dart';
import '../../../shop/presentation/pages/shops_screen.dart';
import '../../../shop/presentation/widgets/categories_list.dart';
import '../pages/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          return Column(
            children: [
              SearchInput(
                onTap: () => context.push(SearchScreen()),
                hint: "Search",
                onChanged: null,
                controller: null,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Shop Categories"),
                    const SizedBox(height: 16),
                    CategoriesList(
                      onTap: (select) {
                        context.read<ShopBloc>().add(GetShops(typeId: select));
                        context.push(ShopsScreen());
                      },
                      categories: state.categories,
                      select: null,
                    ),
                    const SizedBox(height: 32),
                    Text("Product Categories"),
                    const SizedBox(height: 16),
                    CategoriesList(
                      onTap: (select) {},
                      categories: context.read<ProductBloc>().state.categories,
                      select: null,
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text("Shops"),
              //       const SizedBox(height: 16),
              //       ShopsList(
              //         shops: state.shops ?? [],
              //         isHorizontal: false,
              //       ),
              //     ],
              //   ),
              // ),
            ],
          );
        },
      ),
    ));
  }
}
