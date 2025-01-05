import 'package:dartz/dartz.dart';
import 'package:program_language_project/src/features/home/domain/repositories/user_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../../home/domain/entities/Location.dart';
import '../entities/user.dart';

class EditAccountUC extends UseCase<User, EditAccountParam> {
  final UserRepository repository ;

  EditAccountUC({required this.repository});

  @override
  Future<Either<Failure, User>> call({required EditAccountParam param}) async {
    return await repository.editAccount(param);
  }

}

class EditAccountParam {
  final String firstName;
  final String lastName;
  final LocalLocation? location;

  EditAccountParam({
    required this.firstName,
    required this.lastName,
    required this.location,
  });
}
