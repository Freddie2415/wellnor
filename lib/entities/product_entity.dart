import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final int product_type;
  final String name;
  final double price;
  final int status;
  final int discount_percent;
  final discount_begin;
  final discount_end;
  final String image;
  final String description;
  final int category_id;

  ProductEntity({
    this.id,
    this.product_type,
    this.name,
    this.price,
    this.status,
    this.discount_percent,
    this.discount_begin,
    this.discount_end,
    this.image,
    this.description,
    this.category_id,
  });

  @override
  List<Object> get props => [
        id,
        product_type,
        name,
        price,
        status,
        discount_percent,
        discount_begin,
        discount_end,
        image,
        description,
        category_id,
      ];
}
