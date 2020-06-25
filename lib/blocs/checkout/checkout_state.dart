import 'package:equatable/equatable.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class InitialCheckoutState extends CheckoutState {
  @override
  List<Object> get props => [];
}

class CheckoutInProgressState extends CheckoutState {}

class CheckoutSuccessState extends CheckoutState {
  final String message = 'Заявка успешно оформлена!';

  @override
  List<Object> get props => [message];
}

class CheckoutFailureState extends CheckoutState {
  final String message;

  CheckoutFailureState({this.message});
}
