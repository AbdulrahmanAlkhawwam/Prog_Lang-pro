import '../../domain/entities/local_file.dart';

class LocalFileModel extends LocalFile {
  LocalFileModel({
    required super.uid,
    required super.filename,
    required super.path,
    required super.mimetype,
    required super.type,
    required super.isPrivate,
    required super.createdAt,
    required super.updatedAt,
  });
}
