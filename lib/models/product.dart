import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:wellnor/entities/entities.dart';

class Product extends Equatable {
  const Product({
    this.name = '',
    this.price = 0.0,
    this.count = 0,
    this.qtyInStock = 0,
    this.image = '',
    this.id = 0,
    this.description = '',
  });

  final int id;
  final String name;
  final double price;
  final int count;
  final int qtyInStock;
  final String image;
  final String description;

  get isSelected => count > 0;

  get priceText =>
      "${NumberFormat('#,###').format(this.price)} сум".replaceAll(',', ' ');

  get totalText =>
      "${NumberFormat('#,###').format(this.price * this.count)} сум"
          .replaceAll(',', ' ');

  get inStockText => "На складе: ${this.qtyInStock} шт.";

  Product copyWith({
    id,
    String name,
    price,
    count,
    qtyInStock,
    String image,
    String description,
  }) {
    return Product(
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      image: image ?? this.image,
      qtyInStock: qtyInStock ?? this.qtyInStock,
      id: id ?? this.id,
      count: count ?? this.count,
    );
  }

  static Product fromEntity(ProductEntity productEntity) {
    return Product(
      id: productEntity.id,
      name: productEntity.name,
      image: productEntity.image,
      qtyInStock: 0,
      price: productEntity.price,
      count: 0,
      description: productEntity.description,
    );
  }

  @override
  List<Object> get props =>
      [id, name, image, count, qtyInStock, description, price];

  @override
  String toString() {
    return "[$id,$name,$count]";
  }
}
