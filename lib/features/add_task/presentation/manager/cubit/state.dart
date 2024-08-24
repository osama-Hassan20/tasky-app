sealed class AddTaskState {}

final class AddTaskInitial extends AddTaskState {}

final class HomeTaskImagePickedSuccessState extends AddTaskState {}

final class HomeTaskImagePickedErrorState extends AddTaskState {
  final String error;
  HomeTaskImagePickedErrorState(this.error);
}

final class AddTaskLoading extends AddTaskState {}

final class AddTaskSuccess extends AddTaskState {}

final class AddTaskError extends AddTaskState {
  // final String error;
  //
  // AddTaskError(this.error);
}

final class UploadImageLoading extends AddTaskState {}

final class UploadImageSuccess extends AddTaskState {
  final String imageUrl;

  UploadImageSuccess(this.imageUrl);
}

final class UploadImageError extends AddTaskState {
  final String error;

  UploadImageError(this.error);
}


final class EditTaskLoading extends AddTaskState {}

final class EditTaskSuccess extends AddTaskState {}

final class EditTaskError extends AddTaskState {
  // final String error;
  //
  // AddTaskError(this.error);
}

final class RemoveTaskImageState extends AddTaskState {}