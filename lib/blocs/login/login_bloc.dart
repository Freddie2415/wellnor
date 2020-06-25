import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:wellnor/blocs/auth/auth.dart';
import 'package:wellnor/repositories/repositories.dart';
import './login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;

  LoginBloc({@required this.userRepository, @required this.authBloc})
      : assert(userRepository != null),
        assert(authBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await this.userRepository.authenticate(
              username: event.username,
              password: event.password,
            );

        authBloc.add(LoggedIn(token: token));

        yield LoginInitial();
      } catch (e) {
        print(e.toString());
        yield LoginFailure(error: e.toString());
      }
    }
  }
}
