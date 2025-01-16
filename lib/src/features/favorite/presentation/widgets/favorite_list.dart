import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:program_language_project/src/core/utils/app_context.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/app_image.dart';
import '../../../home/presentation/manger/cubit/main/main_cubit.dart';
import '../../../product/presentation/pages/product_details_screen.dart';
import '../manger/favorite_bloc.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavoriteBloc>(
          create: (context) => sl.get<FavoriteBloc>()..add(GetFavorites()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => sl.get<MainCubit>(),
          lazy: false,
        ),
      ],
      child: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          return SizedBox(
            height: 160,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => context.push(
                      ProductDetailsScreen(product: state.favorites[index])),
                  child: Container(
                    margin: EdgeInsets.only(top: 16),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.colors.surfaceContainer,
                      borderRadius: BorderRadius.circular(appBor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: AppImage(
                        context
                            .read<MainCubit>()
                            .image(state.favorites[index].image ?? ''),
                        placeholderHeight: 75,
                        height: 140,
                        width: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemCount: state.favorites.length,
            ),
          );
        },
      ),
    );
  }
}
