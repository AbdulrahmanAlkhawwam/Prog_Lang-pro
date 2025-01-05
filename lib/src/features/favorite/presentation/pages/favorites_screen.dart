import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/screens/empty_favorite_screen.dart';
import '../../../../core/components/screens/error_screen.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/app_context.dart';
import '../../../product/presentation/widgets/product_item.dart';
import '../manger/favorite_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<FavoriteBloc>()..add(GetFavorites()),
      child: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          return switch (state.status) {
            FavoriteStatus.error => ErrorScreen(
                errorMessage: state.message!,
              ),
            _ => Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(Icons.arrow_back_ios_new),
                  ),
                ),
                body: state.favorites.isEmpty
                    ? EmptyFavoritesScreen()
                    : ListView.separated(
                        itemBuilder: (context, index) => ProductItem(
                          product: state.favorites[index],
                          inShop: true,
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemCount: state.favorites.length,
                      ),
              )
          };
        },
      ),
    );
  }
}
