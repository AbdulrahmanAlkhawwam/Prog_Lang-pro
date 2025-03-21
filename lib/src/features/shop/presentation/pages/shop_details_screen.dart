import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:program_language_project/src/core/components/screens/empty_shops_screen.dart';
import 'package:program_language_project/src/core/constants/styles.dart';
import 'package:program_language_project/src/core/utils/app_image.dart';

import '../../../../core/components/screens/error_screen.dart';
import '../../../../core/components/screens/loading_screen.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/app_context.dart';
import '../../../home/presentation/manger/cubit/main/main_cubit.dart';
import '../../../product/presentation/manger/product_bloc.dart';
import '../../../product/presentation/widgets/product_item.dart';
import '../manger/shop_bloc.dart';

class ShopDetailsScreen extends StatefulWidget {
  final int id;

  const ShopDetailsScreen({super.key, required this.id});

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl.get<ShopBloc>()..add(GetShopDetails(id: widget.id)),
          lazy: false,
        ),
        BlocProvider(create: (context) => sl.get<MainCubit>()),
        BlocProvider(
          create: (context) => sl.get<ProductBloc>()
            ..add(GetShopProducts(shopId: widget.id))
            ..add(GetProductsCategories()),
          lazy: false,
        ),
      ],
      child: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state.status == ProductStatus.success) {
            setState(() {});
          }
        },
        child: BlocBuilder<ShopBloc, ShopState>(
          builder: (context, state) {
            print(state.status);
            print(state.shop.toString());
            return switch (state.status) {
              ShopStatus.error => ErrorScreen(errorMessage: state.message!),
              ShopStatus.loading || ShopStatus.init => LoadingScreen(),
              _ => Scaffold(
                  body: SafeArea(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            if (state.shop?.imagePath != null)
                              Opacity(
                                opacity: state.shop?.status == "OPEN" ? 1 : 0.5,
                                child: SizedBox(
                                  height: 200,
                                  width: double.infinity,
                                  child: AppImage(
                                    context
                                        .read<MainCubit>()
                                        .image(state.shop!.imagePath),
                                  ),
                                ),
                              ),
                            AppBar(
                              backgroundColor: Colors.transparent,
                              leading: IconButton(
                                onPressed: () => context.pop(),
                                icon: Icon(Icons.arrow_back_ios_new),
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 170,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: context.colors.outline),
                              if (state.shop?.status == "OPEN")
                                BoxShadow(
                                  color: context.colors.surfaceContainer,
                                  spreadRadius: -2,
                                  blurRadius: 8,
                                ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.shop?.name ?? "market name",
                                  style: TextStyle(
                                    color: context.colors.onSurface,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 16),
                                  child: Text(
                                    state.shop?.description ??
                                        "Market description",
                                    style: TextStyle(
                                      color: context.colors.onSurface,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.map,
                                      color: context.colors.onPrimaryContainer,
                                    ),
                                    SizedBox(width: 14),
                                    Text(state.shop?.address ?? "Market place",
                                        style: context.textTheme.labelMedium
                                            ?.copyWith(
                                                color: context.colors
                                                    .onPrimaryContainer)),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.door_front_door_outlined,
                                        color:
                                            context.colors.onPrimaryContainer,
                                      ),
                                      SizedBox(width: 14),
                                      Text(
                                        state.shop?.status ?? "Market state",
                                        style: TextStyle(
                                          color:
                                              context.colors.onPrimaryContainer,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: BlocBuilder<ProductBloc, ProductState>(
                            builder: (context, state) {
                              final categories =
                                  state.status != ProductStatus.success
                                      ? []
                                      : state.products
                                          .map((e) => e.categoryId)
                                          .toList();
                              return DefaultTabController(
                                length: categories.length,
                                child: Column(
                                  children: [
                                    TabBar(
                                      isScrollable: true,
                                      tabs: state.categories
                                          .where(
                                            (element) =>
                                                categories.contains(element.id),
                                          )
                                          .map((element) =>
                                              Tab(child: Text(element.name)))
                                          .toList(),
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        children: List.generate(
                                          categories.length,
                                          (index) {
                                            final product = state.products
                                                .where((element) =>
                                                    element.categoryId ==
                                                    categories[index])
                                                .toList();
                                            return product.isEmpty
                                                ? EmptyShopsScreen(
                                                    // TODO : fix this
                                                    onRefresh: () async {},
                                                  )
                                                : ListView.separated(
                                                    padding:
                                                        EdgeInsets.all(appBor),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ProductItem(
                                                        inCartScreen: false,
                                                        inShop: true,
                                                        product: product[index],
                                                      );
                                                    },
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            const SizedBox(
                                                                height: 8),
                                                    itemCount: product.length,
                                                  );
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            };
          },
        ),
      ),
    );
  }
}
