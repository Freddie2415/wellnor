import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:wellnor/blocs/blocs.dart';
import 'package:wellnor/models/models.dart';

import './item.dart';

class ItemBloc extends Bloc<ItemEvent, Product> {
  final ProductsBloc productsBloc;

  ItemBloc({this.productsBloc});

  @override
  Product get initialState => Product(id: 0);

  @override
  Stream<Product> mapEventToState(
    ItemEvent event,
  ) async* {
    Product newProductState;
    if (event is UpdateItemEvent) {
      newProductState = event.product.copyWith();
      yield newProductState;
    }

    if (event is AddItemEvent) {
      newProductState = event.product.copyWith(count: event.product.count + 1);
      yield newProductState;
    }

    if (event is RemoveItemEvent) {
      newProductState = event.product.copyWith(count: event.product.count - 1);
      yield newProductState;
    }

    if (event is ClearItemEvent) {
      newProductState = event.product.copyWith(count: 0);
      yield newProductState;
    }

    productsBloc.changeProduct(newProductState);
  }

  @override
  Future<void> close() {
    print('close itemBloc');
    return super.close();
  }
}
