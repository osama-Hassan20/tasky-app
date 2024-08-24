sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class ChangePasswordVisibilityState extends LoginState {}


final class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {
  final dynamic data;

  LoginSuccessState(this.data);
}

final class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}
