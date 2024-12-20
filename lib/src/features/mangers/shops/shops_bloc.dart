import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/message.dart';
import '../../models/shop.dart';
import '../../repositories/shops/Shops_repository.dart';

part 'shops_event.dart';
part 'shops_state.dart';

class ShopsBloc extends Bloc<ShopsEvent, ShopsState> {
  final ShopsRepository repository;

  ShopsBloc({required this.repository}) : super(ShopsState()) {
    on<GetShops>(_getShops);
  }
  FutureOr<void> _getShops(ShopsEvent event, Emitter<ShopsState> emit) async {
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


