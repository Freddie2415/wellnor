import 'package:equatable/equatable.dart';
import 'package:wellnor/models/models.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class InitialCartState extends CartState {
  @override
  List<Object> get props => [];
}

class FullCartState extends CartState {
  final List<Product> cartProducts;
  final String countText;
  final String totalText;
  final String discountText;
  final String amountText;
  final double discount;

  FullCartState({
    this.cartProducts,
    this.countText,
    this.amountText,
    this.discountText,
    this.totalText,
    this.discount,
  });

  @override
  List<Object> get props => [];
}

class EmptyCartState extends CartState {}
