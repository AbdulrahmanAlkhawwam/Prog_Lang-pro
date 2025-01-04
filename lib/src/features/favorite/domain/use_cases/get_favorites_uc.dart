import 'package:dartz/dartz.dart';
import 'package:program_language_project/src/core/errors/failures.dart';
import 'package:program_language_project/src/core/use_case/use_case.dart';
import 'package:program_language_project/src/features/favorite/domain/repositories/favorite_repository.dart';
import 'package:program_language_project/src/features/product/domain/entities/product.dart';

class GetFavoritesUC extends UseCaseNoParam<List<Product>> {
  final FavoriteRepository repository;

  GetFavoritesUC({required this.repository});

  @override
  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getFavorites();
  }
}
