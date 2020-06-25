import 'package:equatable/equatable.dart';
import 'package:wellnor/models/models.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class InitialProductsState extends ProductsState {
  @override
  List<Object> get props => [];
}

//ProductsLoadInProgress - состояние, когда наше приложение выбирает задачи из репозитория.
//ProductsLoadSuccess - состояние нашего приложения после успешной загрузки задач.
//ProductsLoadFailure - состояние нашего приложения, если задачи не были успешно загружены.

class ProductsInProgress extends ProductsState {}

class ProductsLoadSuccess extends ProductsState {
  final List<Product> products;

  ProductsLoadSuccess([this.products = const []]);

  @override
  List<Object> get props => [products];

  @override
  String toString() => 'ProductsLoadSuccess { products: ${products.length} }';
}

class ProductsLoadFailure extends ProductsState {
  final String message;

  ProductsLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}
