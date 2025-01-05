import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/screens/empty_shops_screen.dart';
import '../../../../core/components/screens/error_screen.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../home/presentation/manger/cubit/main/main_cubit.dart';
import '../widgets/categories_list.dart';
import '../manger/shop_bloc.dart';
import '../widgets/shops_list.dart';

class ShopsScreen extends StatefulWidget {
  const ShopsScreen({super.key});

  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  final controller = TextEditingController();

  int? index;

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
                              ? EmptyScreen(isShopScreen: true)
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
          };
        },
      ),
    );
  }
}
