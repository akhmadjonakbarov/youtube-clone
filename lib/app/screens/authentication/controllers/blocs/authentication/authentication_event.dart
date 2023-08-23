part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationLogInEvent extends AuthenticationEvent {}

class AuthenticationLogOutEvent extends AuthenticationEvent {}
