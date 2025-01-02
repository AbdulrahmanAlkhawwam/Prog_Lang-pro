import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:program_language_project/src/features/shop/domain/use_cases/get_shop_details_uc.dart';
import 'package:program_language_project/src/features/shop/domain/use_cases/get_shops_uc.dart';

import '../../../../core/utils/message.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/shop.dart';
import '../../domain/repositories/Shop_repository.dart';

part 'shop_event.dart';

part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final GetShopDetailsUC getShopDetailsUC;
  final GetShopsUC getShopsUC;
  final ShopRepository repository;

  ShopBloc({
    required this.getShopDetailsUC,
    required this.getShopsUC,
    required this.repository,
  }) : super(ShopState()) {
    on<GetShops>(_getShops);
    on<GetShopDetails>(_getShopsDetails);
    on<GetShopCategory>(_getShopCategory);
    on<GetShopsCategories>(_getCategories);
  }

  FutureOr<void> _getShopsDetails(
      GetShopDetails event, Emitter<ShopState> emit) async {
    emit(state.copyWith(status: ShopStatus.loading));
    final response = await getShopDetailsUC(param: event.id);
    response.fold(
      (failure) => emit(state.copyWith(
          status: ShopStatus.error, message: Message.fromFailure(failure))),
      (shop) => emit(
        state.copyWith(
          status: ShopStatus.success,
          shop: shop,
        ),
      ),
    );
  }

  FutureOr<void> _getShops(GetShops event, Emitter<ShopState> emit) async {
    emit(state.copyWith(status: ShopStatus.loading));
    if (state.shops != []) {
      final response = await getShopsUC(param: event.typeId);
      response.fold(
        (failure) => emit(state.copyWith(
          status: ShopStatus.error,
          message: Message.fromFailure(failure),
        )),
        (shops) => emit(state.copyWith(
          status: ShopStatus.success,
          shops: shops,
        )),
      );
    }
  }

  FutureOr<void> _getShopCategory(
      GetShopCategory event, Emitter<ShopState> emit) async {
    emit(state.copyWith(status: ShopStatus.loading));
    final response = await repository.getShopCategories(event.shopId);

    response.fold(
      (failure) => emit(state.copyWith(
          status: ShopStatus.error, message: Message.fromFailure(failure))),
      (categories) => emit(
          state.copyWith(status: ShopStatus.success, categories: categories)),
    );
  }

  FutureOr<void> _getCategories(
      GetShopsCategories event, Emitter<ShopState> emit) async {
    emit(state.copyWith(status: ShopStatus.loading));
    final response = await repository.getCategories();

    response.fold(
        (failure) => emit(state.copyWith(
              status: ShopStatus.error,
              message: Message.fromFailure(failure),
            )),
        (categories) => emit(state.copyWith(
              status: ShopStatus.success,
              categories: categories,
            )));
  }
}
