import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class ProductsLoaded extends ProductsEvent {}

class ProductsFiltered extends ProductsEvent {
  final String query;

  const ProductsFiltered({this.query});

  @override
  List<Object> get props => [];
}
