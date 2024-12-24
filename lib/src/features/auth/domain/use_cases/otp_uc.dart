import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/auth_repository.dart';

class OtpUC extends UseCase<bool, String> {
  final AuthRepository repository;

  OtpUC({required this.repository});

  @override
  Future<Either<Failure, bool>> call({required String param}) async {
    return await repository.otp(param);
  }
}
