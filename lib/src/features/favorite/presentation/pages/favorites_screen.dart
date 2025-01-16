import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:program_language_project/src/core/components/dialogs/delete_dialog.dart';
import 'package:program_language_project/src/core/constants/styles.dart';
import 'package:program_language_project/src/features/home/presentation/manger/cubit/main/main_cubit.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl.get<FavoriteBloc>()..add(GetFavorites()),
        ),
        BlocProvider(
          create: (context) => sl.get<MainCubit>(),
        ),
      ],
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
                  title: Text("Favorite"),
                  centerTitle: true,
                ),
                body: state.favorites.isEmpty
                    ? EmptyFavoritesScreen()
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: appBor),
                        itemBuilder: (context, index) => ProductItem(
                          inCartScreen: false,
                          onLongPress: state.status == FavoriteStatus.loading
                              ? null
                              : () async {
                                  final result = await showDialog(
                                      context: context,
                                      builder: (context) => DeleteDialog());
                                  if (result == true) {
                                    context.read<FavoriteBloc>().add(
                                        DeleteFavorite(
                                            id: state.favorites[index].id));
                                  }
                                },
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
