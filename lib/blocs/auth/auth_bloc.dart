import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wellnor/repositories/user_repository.dart';
import 'package:meta/meta.dart';
import 'auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({@required this.userRepository}) : assert(userRepository != null);

  @override
  AuthState get initialState => AuthUninitialized();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }

    if (event is LoggedIn) {
      yield* _mapLoadingToState(event);
    }

    if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    final bool hasToken = await userRepository.hasToken();

    if (hasToken) {
      yield AuthAuthenticated(user: await userRepository.getUser());
    } else {
      yield AuthUnauthenticated();
    }
  }

  Stream<AuthState> _mapLoadingToState(LoggedIn event) async* {
    yield AuthLoading();
    await userRepository.persistToken(event.token);
    yield AuthAuthenticated(user: await userRepository.getUser());
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    yield AuthLoading();
    await userRepository.deleteToken();
    yield AuthUnauthenticated();
  }
}
