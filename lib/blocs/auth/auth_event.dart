import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// событие AppStarted, чтобы уведомить блок о том, что ему нужно проверить, аутентифицирован ли пользователь в настоящее время или нет.
class AppStarted extends AuthEvent {
  @override
  String toString() => 'Приложение запустилось';
}

//событие LoggedIn, чтобы уведомить блок о том, что пользователь успешно вошел в систему.
class LoggedIn extends AuthEvent {
  final String token;

  const LoggedIn({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'Вы вошли, ваш токен { token: $token }';
}

//событие LoggedOut, чтобы уведомить блок о том, что пользователь успешно вышел из системы.
class LoggedOut extends AuthEvent {
  @override
  String toString() => 'Выход из профиля';
}
