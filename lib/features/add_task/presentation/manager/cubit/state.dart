sealed class AddTaskState {}

final class AddTaskInitial extends AddTaskState {}

final class HomeTaskImagePickedSuccessState extends AddTaskState {}

final class HomeTaskImagePickedErrorState extends AddTaskState {
  final String error;
  HomeTaskImagePickedErrorState(this.error);
}

final class AddTaskLoading extends AddTaskState {}

final class AddTaskSuccess extends AddTaskState {}

final class AddTaskError extends AddTaskState {}

final class UploadImageLoading extends AddTaskState {}

final class UploadImageSuccess extends AddTaskState {
  final String imageUrl;

  UploadImageSuccess(this.imageUrl);
}

final class UploadImageError extends AddTaskState {}

final class EditTaskLoading extends AddTaskState {}

final class EditTaskSuccess extends AddTaskState {}

final class EditTaskError extends AddTaskState {}

final class RemoveTaskImageState extends AddTaskState {}

final class PickImageSuccessState extends AddTaskState {}

final class CompressAndUploadImageState extends AddTaskState {}
