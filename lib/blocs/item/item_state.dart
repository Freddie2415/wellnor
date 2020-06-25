import 'package:equatable/equatable.dart';
import 'package:wellnor/models/models.dart';

abstract class ItemState extends Equatable {
  const ItemState();
}

class InitialItemState extends ItemState {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return "#InitialItemState!";
  }
}

class SelectedItemState extends ItemState {
  final Product product;

  SelectedItemState(this.product);

  @override
  List<Object> get props => [product];

  @override
  String toString() {
    return "SELECTEDItemState: ${product.toString()}";
  }
}

class UnselectedItemState extends ItemState {
  final Product product;

  UnselectedItemState(this.product);

  @override
  List<Object> get props => [product];

  @override
  String toString() {
    return "UNSELECTEDItemState: ${product.toString()}";
  }
}
