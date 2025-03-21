import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:program_language_project/src/core/localization/keys.g.dart';
import 'package:program_language_project/src/features/favorite/presentation/manger/favorite_bloc.dart';
import 'package:program_language_project/src/features/favorite/presentation/widgets/favorite_list.dart';

// import 'package:program_language_project/src/features/home/presentation/manger/cubit/home/home_cubit.dart';
import 'package:program_language_project/src/features/product/presentation/manger/product_bloc.dart';
import 'package:program_language_project/src/features/shop/domain/entities/shop.dart';

import '../../../../core/components/search_input.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/app_context.dart';
import '../../../shop/presentation/manger/shop_bloc.dart';
import '../../../shop/presentation/pages/shops_screen.dart';
import '../../../shop/presentation/widgets/categories_list.dart';
import '../../../shop/presentation/widgets/shops_list.dart';
import '../pages/search_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          return Column(
            children: [
              SearchInput(
                onTap: () => context.push(SearchScreen()),
                hint: LocaleKeys.home_search.tr(),
                onChanged: null,
                controller: null,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.home_shop_category.tr()),
                    const SizedBox(height: 16),
                    CategoriesList(
                      onTap: (select) {
                        context.read<ShopBloc>().add(GetShops(typeId: select));
                        context.push(ShopsScreen(
                          index: select,
                        ));
                        // context.read<HomeCubit>().setScreen(
                        //   screen: Screens.shops,
                        //   args: {"index": select},
                        // );
                      },
                      categories: state.categories,
                      select: null,
                    ),
                    const SizedBox(height: 32),
                    Text(LocaleKeys.home_product_category.tr()),
                    const SizedBox(height: 16),
                    CategoriesList(
                      onTap: (select) {},
                      categories: context.read<ProductBloc>().state.categories,
                      select: null,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.home_shops.tr()),
                    BlocBuilder<ShopBloc, ShopState>(
                      builder: (context, state) {
                        return ShopsList(
                          shops: state.shops,
                          isHorizontal: false,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.home_favorite.tr()),
                    FavoriteList(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    ));
  }
}
