import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:program_language_project/src/core/components/screens/empty_orders_screen.dart';

import '../../../../core/components/screens/empty_shops_screen.dart';
import '../../../../core/components/screens/error_screen.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../home/presentation/manger/cubit/main/main_cubit.dart';
import '../widgets/categories_list.dart';
import '../manger/shop_bloc.dart';
import '../widgets/shops_list.dart';

class ShopsScreen extends StatefulWidget {
  int? index;

  ShopsScreen({super.key, this.index});

  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  final controller = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> _refresh() async {
    _refreshIndicatorKey.currentState?.show();
    context.read<ShopBloc>().add(GetShops());
    context.read<ShopBloc>().add(GetShopsCategories());
    await Future.delayed(Duration(seconds: 3));
  }

  int? index;

  @override
  void initState() {
    index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<MainCubit>(),
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          return switch (state.status) {
            ShopStatus.error => ErrorScreen(errorMessage: state.message!),
            _ => Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: RefreshIndicator(
                      onRefresh: _refresh,
                      child: Column(
                        children: [
                          CategoriesList(
                            onTap: (select) => setState(() {
                              index == select ? index = null : index = select;
                              context
                                  .read<ShopBloc>()
                                  .add(GetShops(typeId: index));
                            }),
                            select: index,
                            categories: state.categories,
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: state.shops.isEmpty &&
                                    state.status == ShopStatus.success
                                ? EmptyOrdersScreen(onRefresh: _refresh)
                                : ShopsList(
                                    shops: state.shops,
                                    isHorizontal: true,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          };
        },
      ),
    );
  }
}
