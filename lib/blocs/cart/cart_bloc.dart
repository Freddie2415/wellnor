import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:wellnor/blocs/blocs.dart';
import 'package:wellnor/blocs/products/products_bloc.dart';
import 'package:wellnor/models/models.dart';

import './cart.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this.productsBloc);

  List<Product> _cartProducts = List<Product>();
  double _discount = 0.0;
  final ProductsBloc productsBloc;

  @override
  CartState get initialState => InitialCartState();

  @override
  Future<void> close() {
    _cartProducts = [];
    return super.close();
  }

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is UpdateCartEvent) {
      yield* _mapUpdateCartToState(event);
    }
    if (event is ClearCartEvent) {
      yield* _mapClearCartToState(event);
    }

    if (event is SetDiscountCartEvent) {
      yield* _mapSetDiscountToState(event);
    }
  }

  Stream<CartState> _mapUpdateCartToState(UpdateCartEvent event) async* {
    yield InitialCartState();
    _cartProducts = _cartProducts
        .map((p) => event.product.id == p.id ? event.product : p)
        .toList();

    if (!_cartProducts.any((element) => element.id == event.product.id)) {
      _cartProducts.add(event.product);
    }

    _cartProducts.removeWhere((element) => element.isSelected == false);
    _cartProducts = List<Product>()..addAll(_cartProducts);

    var count = _getCount(_cartProducts);
    var amount = _getAmount(_cartProducts);
    String countText = count.toString();
    String discountText = _getDiscountText(_discount);
    String amountText = _getAmountText(amount);
    String totalText = _getTotalText(amount, _discount);

    yield _cartProducts.length == 0
        ? EmptyCartState()
        : FullCartState(
            cartProducts: _cartProducts,
            countText: countText,
            amountText: amountText,
            totalText: totalText,
            discountText: discountText,
            discount: _discount,
          );
  }

  Stream<CartState> _mapClearCartToState(ClearCartEvent event) async* {
    for (var value in _cartProducts) {
      productsBloc.changeProduct(value.copyWith(count: 0));
    }
    _cartProducts.clear();
    _discount = 0.0;
    yield EmptyCartState();
  }

  Stream<CartState> _mapSetDiscountToState(SetDiscountCartEvent event) async* {
    yield InitialCartState();
    _discount = event.discount;

    var count = _getCount(_cartProducts);
    var amount = _getAmount(_cartProducts);
    String countText = count.toString();
    String discountText = _getDiscountText(_discount);
    String amountText = _getAmountText(amount);
    String totalText = _getTotalText(amount, _discount);

    yield _cartProducts.length == 0
        ? EmptyCartState()
        : FullCartState(
            cartProducts: _cartProducts,
            countText: countText,
            amountText: amountText,
            totalText: totalText,
            discountText: discountText,
            discount: _discount,
          );
  }

  _getCount(List<Product> products) => products.fold(
      0, (previousValue, product) => product.count + previousValue);

  _getAmount(List<Product> products) => products.fold(
      0,
      (previousValue, product) =>
          product.count * product.price + previousValue);

  String _getDiscountText(discount) =>
      "${NumberFormat('#,###').format(discount)} %".replaceAll(',', ' ');

  String _getAmountText(amount) =>
      "${NumberFormat('#,###').format(amount)} сум".replaceAll(',', ' ');

  String _getTotalText(amount, discount) =>
      "${NumberFormat('#,###').format(amount * (100.0 - discount) / 100)} сум"
          .replaceAll(',', ' ');
}
