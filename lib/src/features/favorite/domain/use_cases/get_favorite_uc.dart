import 'package:dartz/dartz.dart';
import 'package:program_language_project/src/core/errors/failures.dart';
import 'package:program_language_project/src/core/use_case/use_case.dart';
import 'package:program_language_project/src/features/favorite/domain/repositories/favorite_repository.dart';

class GetFavoriteUC extends UseCase<bool, int> {
  final FavoriteRepository repository;

  GetFavoriteUC({required this.repository});

  @override
  Future<Either<Failure, bool>> call({required int param}) async {
    return await repository.getFavorite(param);
  }
}
