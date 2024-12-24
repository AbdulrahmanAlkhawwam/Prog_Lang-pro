import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/message.dart';
import '../../domain/entities/shop.dart';
import '../../domain/repositories/Shop_repository.dart';

part 'shop_event.dart';

part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final ShopRepository repository;

  ShopBloc({required this.repository}) : super(ShopState()) {
    on<GetShops>(_getShops);
    on<GetShopsDetails>(_getShopsDetails);
  }

  FutureOr<void> _getShopsDetails(
      GetShopsDetails event, Emitter<ShopState> emit) async {
    emit(state.copyWith(status: ShopStatus.loading));
    final response = await repository.getShop(event.id);
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
    final response = await repository.getShops();
    response.fold(
      (failure) => emit(state.copyWith(
          status: ShopStatus.error, message: Message.fromFailure(failure))),
      (shops) => emit(
        state.copyWith(
          status: ShopStatus.success,
          shops: shops,
        ),
      ),
    );
  }
}
