sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class ChangePasswordVisibilityState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  dynamic successModel ;
  RegisterSuccessState(this.successModel) ;
}

class RegisterErrorState extends RegisterState {
  String? errorModel ;
  RegisterErrorState(this.errorModel) ;
}