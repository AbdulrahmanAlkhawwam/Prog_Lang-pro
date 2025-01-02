import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/screens/error_screen.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/app_context.dart';
import '../../../home/presentation/manger/cubit/main_cubit.dart';
import '../../../product/presentation/manger/product_bloc.dart';
import '../../domain/entities/category.dart';
import '../manger/shop_bloc.dart';
import '../widgets/categories_list.dart';

class ShopDetailsScreen extends StatefulWidget {
  final int id;

  const ShopDetailsScreen({super.key, required this.id});

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen>
    with TickerProviderStateMixin {
  List<Category> tabs = [];

  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl.get<ShopBloc>()
            ..add(GetShopDetails(id: widget.id))
            ..add(GetShopCategory(shopId: widget.id)),
        ),
        BlocProvider(
          create: (context) => sl.get<MainCubit>(),
        ),
        BlocProvider(
          create: (context) =>
              sl.get<ProductBloc>()..add(GetShopProduct(shopId: widget.id)),
        ),
      ],
      child: BlocListener<ShopBloc, ShopState>(
        listener: (context, state) {
          if (state.status == ShopStatus.success) {
            setState(() {
              controller =
                  TabController(length: state.categories.length, vsync: this);
            });
          }
        },
        child: BlocBuilder<ShopBloc, ShopState>(
          builder: (context, state) {
            return switch (state.status) {
              ShopStatus.error => ErrorScreen(errorMessage: state.message!),
              _ => Scaffold(
                  body: SafeArea(
                    child: Column(
                      children: [
                        Stack(children: [
                          SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Image.network(
                              context
                                  .read<MainCubit>()
                                  .image(state.shop!.imagePath),
                            ),
                          ),
                          AppBar(
                            backgroundColor: Colors.transparent,
                            leading: IconButton(
                              onPressed: () => context.pop,
                              icon: Icon(Icons.arrow_back_ios_new),
                            ),
                          )
                        ]),
                        Container(
                          height: 170,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: context.colors.outline),
                              if (state.shop?.status != "OPEN")
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
                        // TabBar(
                        //   controller: controller,
                        //   isScrollable: true,
                        //   tabs: tabs
                        //       .map((element) => Tab(child: Text(element.name)))
                        //       .toList(),
                        // ),
                        // Expanded(
/*                          child:*/
                        CategoriesList(
                          onTap: (_) {},
                          categories: state.categories,
                          select: 0,
                        ),
                        BlocBuilder<ProductBloc, ProductState>(
                          builder: (context, state) {
                            return ListView.separated(
                              itemBuilder: (context, index) => Container(
                                height: 50,
                                width: double.infinity,
                                color: Colors.red,
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 8),
                              itemCount: state.products.length,
                            );
                          },
                        ),
                        // )
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
