import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUC extends UseCase<User, LoginParam> {
  final AuthRepository repository;

  LoginUC({required this.repository});

  @override
  Future<Either<Failure, User>> call({required LoginParam param}) async {
    return await repository.login(param);
  }
}

class LoginParam {
  final String phone;
  final String password;

  LoginParam({
    required this.phone,
    required this.password,
  });
}
