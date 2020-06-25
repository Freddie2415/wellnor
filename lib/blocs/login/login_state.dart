import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

/*
LoginInitial - является начальным состоянием LoginForm.
LoginLoading - состояние LoginForm, когда мы проверяем учетные данные
LoginFailure - состояние LoginForm, когда попытка входа не удалась.
 */

class LoginInitial extends LoginState {
  @override
  String toString() => 'Начальное состояние Логина';
}

class LoginLoading extends LoginState {
  @override
  String toString() => 'Состояние: в процессе логирования';
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Ошибка входа { error: $error }';
}
