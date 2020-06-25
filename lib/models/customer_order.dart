import 'package:equatable/equatable.dart';

class CustomerOrder extends Equatable {
  final id;
  final comment;
  final createdAt;
  final status;
  final orderType;
  final discount;
  final shopId;
  final customerId;

  const CustomerOrder({
    this.id,
    this.comment,
    this.createdAt,
    this.status,
    this.orderType,
    this.discount,
    this.shopId,
    this.customerId,
  });

  @override
  List<Object> get props => [
        comment,
        createdAt,
        status,
        orderType,
        discount,
        shopId,
        customerId,
      ];

  static CustomerOrder fromJson({jsonData}) {
    return CustomerOrder(
      id: jsonData['id'],
      comment: jsonData['comment'],
      createdAt: jsonData['created_at'],
      status: jsonData['status'],
      orderType: jsonData['order_type'],
      discount: jsonData['discount'],
      shopId: jsonData['shop_id'],
      customerId: jsonData['customer_id'],
    );
  }
}
