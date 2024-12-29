import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:program_language_project/src/features/home/presentation/manger/cubit/main_cubit.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/app_context.dart';
import '../../domain/entities/category.dart';
import '../manger/shop_bloc.dart';

class ShopDetailsScreen extends StatefulWidget {
  final int id;

  ShopDetailsScreen({super.key, required this.id});

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen>
    with SingleTickerProviderStateMixin {
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
      ],
      child: BlocListener<ShopBloc, ShopState>(
        listener: (context, state) {
          if (state.status == ShopStatus.success) {
            tabs = context.read<ShopBloc>().state.categories ?? [];
          }
        },
        child: BlocBuilder<ShopBloc, ShopState>(
          builder: (context, state) {
            switch (state.status) {
              case ShopStatus.loading:
                return Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              case ShopStatus.error:
                return Scaffold(
                  body: Center(
                      child: Text(
                          'Error loading details : #${state.message.toString()}')),
                );
              case ShopStatus.success:
                return Scaffold(
                  body: SafeArea(
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          child: Image.network(
                            context
                                .read<MainCubit>()
                                .image(state.shop!.imagePath),
                          ),
                        ),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: context.colors.surface,
                            boxShadow: [
                              BoxShadow(
                                color: context.colors.outline,
                                blurRadius: 4,
                                offset: Offset(0, 3),
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
                                      const EdgeInsets.only(top: 4, bottom: 16),
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
                                      color: context.colors.primaryContainer,
                                    ),
                                    SizedBox(width: 14),
                                    Text(
                                      state.shop?.address ?? "Market place",
                                      style: TextStyle(
                                        color: context.colors.primaryContainer,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.door_front_door_outlined,
                                        color: context.colors.primaryContainer,
                                      ),
                                      SizedBox(width: 14),
                                      Text(
                                        state.shop?.status ?? "Market state",
                                        style: TextStyle(
                                          color:
                                              context.colors.primaryContainer,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.lens_blur,
                                      color: context.colors.primaryContainer,
                                    ),
                                    SizedBox(width: 14),
                                    Text(
                                      "Market category",
                                      style: TextStyle(
                                        color: context.colors.primaryContainer,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        TabBar(
                          controller: controller,
                          isScrollable: true,
                          tabs: tabs
                              .map((element) => Tab(child: Text(element.name)))
                              .toList(),
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) => Container(
                              height: 50,
                              width: double.infinity,
                              color: Colors.red,
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8),
                            itemCount: 5,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              case ShopStatus.init:
                return Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
            }
          },
        ),
      ),
    );
  }
}
