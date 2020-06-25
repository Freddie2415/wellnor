import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnor/blocs/cart/cart.dart';
import 'package:wellnor/blocs/products/products.dart';
import 'package:wellnor/constants.dart';
import 'package:wellnor/repositories/repositories.dart';
import 'package:wellnor/screens/screens.dart';
import 'package:wellnor/widgets/loading_indicator.dart';

import 'blocs/blocs.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  runApp(
    BlocProvider<AuthBloc>(
      create: (context) {
        return AuthBloc(userRepository: userRepository)..add(AppStarted());
      },
      child: ShopApp(
        userRepository: userRepository,
      ),
    ),
  );
}

class ShopApp extends StatelessWidget {
  final UserRepository userRepository;

  const ShopApp({this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: kBrightness,
        primaryColor: kPrimeryColor,
        accentColor: kAccentColor,
        fontFamily: kFontFamily,
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthUninitialized) {
            return SplashScreen();
          }
          if (state is AuthAuthenticated) {
            ProductsBloc productsBloc = ProductsBloc();
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => productsBloc..add(ProductsLoaded()),
                ),
                BlocProvider(
                  create: (context) => CartBloc(productsBloc),
                ),
              ],
              child: HomeScreen(user: state.user),
            );
          }
          if (state is AuthUnauthenticated) {
            return LoginScreen(userRepository: userRepository);
          }
          if (state is AuthLoading) {
            return Scaffold(
              body: LoadingIndicator(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
