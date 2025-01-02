part of 'file_bloc.dart';

enum FileStatus {
  init,
  loading,
  error,
  loaded,
  deleted,
}

class FileState {
  final FileStatus status;
  final Message? message;

  const FileState({
    this.status = FileStatus.init,
    this.message,
  });

  FileState copyWith({
    FileStatus? status,
    Message? message,
  }) {
    return FileState(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
