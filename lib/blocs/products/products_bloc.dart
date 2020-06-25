import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:wellnor/models/models.dart';
import 'package:wellnor/repositories/repositories.dart';

import 'products.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository productRepository = ProductRepository();
  List<Product> _products = List<Product>();

  @override
  ProductsState get initialState => ProductsInProgress();

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is ProductsLoaded) {
      yield* _mapProductsLoadedToState();
    }

    if (event is ProductsFiltered) {
      yield* _mapProductsFilteredToState(query: event.query);
    }
  }

  Stream<ProductsState> _mapProductsLoadedToState() async* {
    try {
      yield ProductsInProgress();
      final productsEntity = await this.productRepository.loadProducts();
      _products = productsEntity.map(Product.fromEntity).toList();
      yield ProductsLoadSuccess(_products);
    } catch (e) {
      yield ProductsLoadFailure(e.toString());
    }
  }

  Stream<ProductsState> _mapProductsFilteredToState({String query}) async* {
    yield ProductsInProgress();

    await Future.delayed(Duration(milliseconds: 300));

    if (query.isNotEmpty) {
      List<Product> resultList = _products
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      yield ProductsLoadSuccess(resultList);
    } else {
      yield ProductsLoadSuccess(_products);
    }
  }

  List<Product> changeProduct(Product product) {
    this._products =
        this._products.map((p) => p.id == product.id ? product : p).toList();

    print('CHANGE PRODUCT LIST $product');
    print('$_products');
    return _products;
  }

  Product getById(id) {
    return _products.firstWhere((element) => element.id == id);
  }
}
