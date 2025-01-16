import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:program_language_project/src/core/utils/app_image.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/app_context.dart';
import '../../../home/presentation/manger/cubit/main/main_cubit.dart';
import '../../domain/entities/shop.dart';
import '../pages/shop_details_screen.dart';

class ShopsItem extends StatelessWidget {
  final bool isVertical;

  final Shop shop;

  const ShopsItem({
    super.key,
    required this.shop,
    required this.isVertical,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<MainCubit>(),
      lazy: false,
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return InkWell(
            onTap: () => context.push(ShopDetailsScreen(id: shop.id)),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(appBor),
                color: context.colors.surfaceContainer,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(appBor),
                        child: AppImage(
                          context.read<MainCubit>().image(shop.imagePath),
                          placeholderHeight: 50,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(appBor),
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      if (isVertical)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 9),
                          child: Text(
                            shop.name.toUpperCase(),
                            style: context.textTheme.titleSmall
                                ?.copyWith(color: Colors.white),
                          ),
                        )
                    ]),
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
