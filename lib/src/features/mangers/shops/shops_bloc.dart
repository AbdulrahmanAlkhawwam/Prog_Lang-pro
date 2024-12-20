import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/message.dart';
import '../../models/shop.dart';
import '../../repositories/shops_details/shops_repository.dart';


part 'shops_state.dart';
part 'shops_event.dart';

class ShopsBloc extends Bloc<ShopsEvent, ShopsState> {
  final ShopsDetailsRepository repository;

  ShopsBloc({required this.repository}) : super(ShopsState()) {

    on<GetShopsDetails>(_getShopsDetails);
  }
  FutureOr<void> _getShopsDetails(ShopsEvent event, Emitter<ShopsState> emit) async {
    emit(state.copyWith(status: ShopsStatus.loading));
    final response = await repository.call();
    response.fold(
          (failure) => emit(state.copyWith(status: ShopsStatus.error,message: Message.fromFailure(failure))),
          (shopsDetails) => emit(
        state.copyWith(
          status: ShopsStatus.success,
          shops : shopsDetails,
        ),
      ),
    );
  }
}


