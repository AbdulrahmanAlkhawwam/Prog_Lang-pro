import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/failures.dart';

abstract class SettingsRepository {
  Either<Failure, ThemeMode> getTheme();

  Future<Either<Failure, bool>> setTheme(ThemeMode theme);
}
