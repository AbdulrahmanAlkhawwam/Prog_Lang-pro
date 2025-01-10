import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:program_language_project/src/features/product/presentation/pages/product_details_screen.dart';
import 'package:program_language_project/src/features/shop/presentation/pages/shop_details_screen.dart';

import '../../../../core/components/search_input.dart';
import '../../../../core/localization/keys.g.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/app_context.dart';
import '../manger/cubit/main/main_cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<MainCubit>(),
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                leadingWidth: double.infinity,
                leading: TabBar(tabs: [
                  Tab(text: "Stores"),
                  Tab(text: "products"),
                ]),
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    SearchInput(
                      controller: controller,
                      hint: LocaleKeys.home_search.tr(),
                      onChanged: (value) {
                        context.read<MainCubit>().searchStore(value);
                        context.read<MainCubit>().searchProduct(value);
                      },
                    ),
                    Expanded(
                      child: TabBarView(
                        children: List.generate(
                          2,
                          (i) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: ListView.separated(
                              itemBuilder: (context, index) => ListTile(
                                onTap: () {
                                  context.push(i == 0
                                      ? ShopDetailsScreen(
                                          id: state.searchStoreResult[index].id)
                                      : ProductDetailsScreen(
                                          product: state
                                              .searchProductResult[index]));
                                },
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      context.read<MainCubit>().image(
                                            i == 0
                                                ? state.searchStoreResult[index]
                                                    .imagePath
                                                : state
                                                    .searchProductResult[index]
                                                    .image??'',
                                          )),
                                ),
                                title: Text(
                                  i == 0
                                      ? state.searchStoreResult[index].name
                                      : state.searchProductResult[index].name,
                                  style: context.textTheme.titleSmall,
                                ),
                                subtitle: Text(
                                  i == 0
                                      ? state.searchStoreResult[index].address
                                      : state.searchProductResult[index]
                                              .description ??
                                          '',
                                  style: context.textTheme.bodySmall,
                                ),
                              ),
                              separatorBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Divider(
                                  color: context.colors.outline,
                                ),
                              ),
                              itemCount: i == 0
                                  ? state.searchStoreResult.length
                                  : state.searchProductResult.length,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
