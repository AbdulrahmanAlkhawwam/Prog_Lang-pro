import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/message.dart';
import '../../models/shop.dart';
import '../../repositories/shops/Shop_repository.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final ShopRepository repository;

  ShopBloc({required this.repository}) : super(ShopState()) {
    on<GetShops>(_getShops);
  }
  FutureOr<void> _getShops(ShopEvent event, Emitter<ShopState> emit) async {
     emit(state.copyWith(status: ShopsStatus.loading));
    final response = await repository.call();
    response.fold(
      (failure) => emit(state.copyWith(status: ShopsStatus.error,message: Message.fromFailure(failure))),
      (shops) => emit(
        state.copyWith(
          status: ShopsStatus.success,
          shops : shops,
        ),
      ),
    );
  }
}


