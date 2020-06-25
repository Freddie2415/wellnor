import 'package:equatable/equatable.dart';
import 'package:wellnor/models/models.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class CheckoutCustomerOrderEvent extends CheckoutEvent {
  final String comment;
  final double discount;
  final List<Product> products;

  CheckoutCustomerOrderEvent({
    this.products,
    this.comment = 'Новая заявка',
    this.discount = 0.0,
  });
}
