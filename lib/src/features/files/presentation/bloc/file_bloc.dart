import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/message.dart';
import '../../domain/use_cases/delete_image_uc.dart';
import '../../domain/use_cases/upload_image_uc.dart';

part 'file_event.dart';

part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  UploadImageUC uploadImageUC;
  DeleteImageUC deleteImageUC;

  FileBloc({
    required this.uploadImageUC,
    required this.deleteImageUC,
  }) : super(FileState()) {
    on<UploadImage>(_uploadImage);
    on<DeleteImage>(_deleteImage);
  }

  _uploadImage(UploadImage event, Emitter<FileState> emit) async {
    emit(state.copyWith(status: FileStatus.loading));
    final response = await uploadImageUC(param: event.image);
    response.fold(
      (failure) => emit(state.copyWith(
        status: FileStatus.error,
        message: Message.fromFailure(failure),
      )),
      (_) => emit(state.copyWith(status: FileStatus.loaded)),
    );
  }

  _deleteImage(DeleteImage event, Emitter<FileState> emit) async {
    emit(state.copyWith(status: FileStatus.loading));
    final response = await deleteImageUC();
    response.fold(
      (failure) => emit(state.copyWith(
        status: FileStatus.error,
        message: Message.fromFailure(failure),
      )),
      (_) => emit(state.copyWith(status: FileStatus.deleted)),
    );
  }
}
