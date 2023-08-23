part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}



class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationLoginState extends AuthenticationState {
  final User user;

  AuthenticationLoginState({required this.user});
}

class AuthenticationLogOutState extends AuthenticationState {}

class AuthenticationErrorState extends AuthenticationState {
  final String errorMsg;

  AuthenticationErrorState({required this.errorMsg});
}
