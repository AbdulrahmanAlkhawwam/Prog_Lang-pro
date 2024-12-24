import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RegisterUC extends UseCase<User, RegisterParam> {
  final AuthRepository repository;

  RegisterUC({required this.repository});

  @override
  Future<Either<Failure, User>> call({required RegisterParam param}) async {
    return await repository.register(param);
  }
}

class RegisterParam {
  final String firstName;
  final String lastName;
  final String password;
  final String phone;

  RegisterParam({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.phone,
  });
}
