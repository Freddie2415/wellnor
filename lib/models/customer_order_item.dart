import 'package:equatable/equatable.dart';

class CustomerOrderItem extends Equatable {
  final id;
  final itemsCount;
  final price;
  final shopType;
  final comment;
  final productsId;
  final customerOrderId;

  CustomerOrderItem(
      {this.id,
      this.itemsCount,
      this.price,
      this.shopType,
      this.comment,
      this.productsId,
      this.customerOrderId});

  @override
  List<Object> get props => [
        this.id,
        this.itemsCount,
        this.price,
        this.shopType,
        this.comment,
        this.productsId,
        this.customerOrderId
      ];

  static CustomerOrderItem fromJson({jsonData}) {
    return CustomerOrderItem(
      id: jsonData['id'],
      itemsCount: jsonData['items_count'],
      price: jsonData['price'],
      shopType: jsonData['shop_type'],
      comment: jsonData['comment'],
      customerOrderId: jsonData['customer_order_id'],
      productsId: jsonData['products_id'],
    );
  }
}
