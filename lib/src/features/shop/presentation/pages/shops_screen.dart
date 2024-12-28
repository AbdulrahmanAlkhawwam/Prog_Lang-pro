import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../core/service_locator/service_locator.dart';
import '../../domain/entities/category.dart';
import '../../../home/presentation/manger/cubit/main_cubit.dart';
import '../../../home/presentation/widgets/categories_list.dart';
import '../manger/shop_bloc.dart';
import '../widgets/shops_list.dart';

class ShopsScreen extends StatelessWidget {
  ShopsScreen({super.key});

  final controller = TextEditingController();
  final int? index = 2;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<MainCubit>(),
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: switch (state.status) {
                ShopStatus.loading =>
                  Center(child: CircularProgressIndicator()),
                ShopStatus.error => Center(
                    child: Text(
                        'Error loading stores #${state.message.toString()}')),
                _ => Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        CategoriesList(
                          select: 1,
                          categories: [
                            Category(id: 123, name: "food"),
                            Category(id: 234, name: "clothes"),
                            Category(id: 345, name: "cars"),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                            child: ShopsList(
                          shops: state.shops ?? [],
                        )),
                      ],
                    ),
                  ),
              },
            ),
          );
        },
      ),
    );
  }
}
