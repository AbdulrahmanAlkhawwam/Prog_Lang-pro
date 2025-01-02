part of 'file_bloc.dart';

abstract class FileEvent {
  const FileEvent();
}

class UploadImage extends FileEvent {
  final File image;

  const UploadImage({required this.image});
}

class DeleteImage extends FileEvent {}
