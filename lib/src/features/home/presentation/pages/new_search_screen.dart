import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/search_input.dart';
import '../../../../core/localization/keys.g.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/app_context.dart';
import '../../../../core/utils/app_image.dart';
import '../../../product/presentation/pages/product_details_screen.dart';
import '../../../shop/presentation/pages/shop_details_screen.dart';
import '../manger/cubit/main/main_cubit.dart';

class NewSearchScreen extends StatelessWidget {
  NewSearchScreen({super.key});

  final searchController = TextEditingController();

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
                toolbarHeight: 80,
                backgroundColor: context.colors.surfaceContainer,
                leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: context.colors.outline,
                  ),
                ),
                titleSpacing: 0,
                title: SearchInput(
                  padding: EdgeInsets.only(
                    right: context.isLTR ? 24 : 0,
                    left: context.isLTR ? 0 : 24,
                  ),
                  controller: searchController,
                  hint: LocaleKeys.screens_search_search_bar.tr(),
                  onChanged: (value) {
                    context.read<MainCubit>().searchStore(value);
                    context.read<MainCubit>().searchProduct(value);
                  },
                ),
              ),
              body: Column(
                children: [
                  Container(
                    color: context.colors.surfaceContainer,
                    padding: EdgeInsets.only(
                      right: context.isLTR ? 24 : 0,
                      left: context.isLTR ? 0 : 24,
                    ),
                    child: Row(
                      children: [
                        TabBar(
                          isScrollable: true,
                          tabs: [
                            Tab(
                                text: LocaleKeys.screens_search_tab_bar_store
                                    .plural(state.searchStoreResult.length)),
                            Tab(
                              text: LocaleKeys.screens_search_tab_bar_product
                                  .plural(state.searchProductResult.length),
                            ),
                          ],
                        ),
                        Spacer(),
                        Text(
                          LocaleKeys.screens_search_tab_bar_result.plural(
                              state.searchProductResult.length +
                                  state.searchStoreResult.length),
                          style: context.textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child:
                        // state.status == SearchStatus.loading
                        //     ? LoadingState()
                        //     :
                        TabBarView(
                      children: List.generate(
                        2,
                        (i) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ListView.separated(
                            itemBuilder: (context, index) => ListTile(
                              onTap: () {
                                context.push(i == 0
                                    ? ShopDetailsScreen(
                                        id: state.searchStoreResult[index].id)
                                    : ProductDetailsScreen(
                                        product:
                                            state.searchProductResult[index]));
                              },
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: AppImage(
                                  context.read<MainCubit>().image(
                                        i == 0
                                            ? state.searchStoreResult[index]
                                                .imagePath
                                            : state.searchProductResult[index]
                                                    .image ??
                                                '',
                                      ),
                                  height: 48,
                                  width: 48,
                                  fit: BoxFit.cover,
                                ),
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
                            separatorBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 8,
                                ),
                                child: Divider(color: context.colors.outline),
                              );
                            },
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
          );
        },
      ),
    );
  }
}

// content search in loading state
class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (ctx, index) =>
          // todo : item in loading state
          Container(),
      separatorBuilder: (ctx, index) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        child: Divider(color: context.colors.surfaceBright),
      ),
      itemCount: Random().nextInt(7) + 3,
    );
  }
}
