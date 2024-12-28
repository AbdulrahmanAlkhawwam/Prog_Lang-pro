import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../../home/domain/entities/Location.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class EditAccountUC extends UseCase<User, EditAccountParam> {
  final AuthRepository repository ;

  EditAccountUC({required this.repository});

  @override
  Future<Either<Failure, User>> call({required EditAccountParam param}) async {
    return await repository.editAccount(param);
  }

}

class EditAccountParam {
  final String firstName;
  final String lastName;
  final Location? location;

  EditAccountParam({
    required this.firstName,
    required this.lastName,
    required this.location,
  });
}
