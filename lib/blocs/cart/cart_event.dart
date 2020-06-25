import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wellnor/blocs/blocs.dart';
import 'package:wellnor/models/models.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class UpdateCartEvent extends CartEvent {
  final Product product;

  UpdateCartEvent(this.product);

  @override
  List<Object> get props => [product];
}

class ClearCartEvent extends CartEvent {}

class SetDiscountCartEvent extends CartEvent {
  final double discount;

  SetDiscountCartEvent(this.discount);
  @override
  List<Object> get props => [discount];
}
