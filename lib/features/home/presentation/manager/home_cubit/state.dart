sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class LoadingLogoutSate extends HomeState {}

final class LogoutSuccessState extends HomeState {
  // final String message;
  //
  // LogoutSuccessState(this.message);
}

final class LogoutErrorState extends HomeState {
  final String message;

  LogoutErrorState(this.message);
}

final class ChangeIndexState extends HomeState {}

final class TasksLoadingState extends HomeState {}

final class TasksSuccessState extends HomeState {}

final class TasksErrorState extends HomeState {
  final String message;

  TasksErrorState(this.message);
}

final class DeleteTaskLoadingState extends HomeState {}

final class DeleteTaskSuccessState extends HomeState {}

final class DeleteTaskErrorState extends HomeState {
  final String message;

  DeleteTaskErrorState(this.message);
}



final class UpScrollDirectionState extends HomeState {}
final class DownScrollDirectionState extends HomeState {}
final class IdleScrollDirectionState extends HomeState {}