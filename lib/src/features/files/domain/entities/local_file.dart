
import 'package:equatable/equatable.dart';

class LocalFile extends Equatable {
  final String? uid;
  final String? filename;
  final String? path;
  final String? mimetype;
  final String? type;
  final bool? isPrivate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LocalFile({
    required this.uid,
    required this.filename,
    required this.path,
    required this.mimetype,
    required this.type,
    required this.isPrivate,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [uid, filename, path];
}
