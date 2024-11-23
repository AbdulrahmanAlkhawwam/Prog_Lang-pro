// import 'package:equatable/equatable.dart';

import '../errors/failures.dart';

class Message /*extends Equatable*/ {
  final String value;
  final int? code;
  final String? platformCode;
  final bool readable;

  const Message(
    this.value, {
    this.code,
    this.platformCode,
    this.readable = false,
  });

  factory Message.fromFailure(Failure failure) => Message(failure.message);

  // @override
  // List<Object?> get props => [value, code, readable];
}
