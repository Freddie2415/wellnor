import 'package:equatable/equatable.dart';
import 'package:wellnor/models/models.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

/*
*
Uninitialized - ожидание проверки подлинности пользователя при запуске приложения.
Loading - ожидание сохранения/удаления токена
Authenticated - успешно аутентифицирован
Unauthenticated - не аутентифицирован
*
*/

//ожидание проверки подлинности пользователя при запуске приложения.
class AuthUninitialized extends AuthState {
  @override
  String toString() =>
      'Ожидание проверки подлинности пользователя при запуске приложения';
}

//успешно аутентифицирован
class AuthAuthenticated extends AuthState {
  final User user;

  AuthAuthenticated({this.user});
  @override
  String toString() => 'Успешно аутентифицирован';
}

//не аутентифицирован
class AuthUnauthenticated extends AuthState {
  @override
  String toString() => 'Не аутентифицирован';
}

//ожидание сохранения/удаления токена
class AuthLoading extends AuthState {
  @override
  String toString() => 'Загрузка|ожидание сохранения|удаления токена|';
}
