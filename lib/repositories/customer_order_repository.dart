import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:meta/meta.dart';
import 'package:wellnor/constants.dart';
import 'package:wellnor/keystore.dart';
import 'package:wellnor/models/customer_order_item.dart';
import 'package:wellnor/models/models.dart';

class CustomerOrderRepository {
  /// Добавление Заявки клиента! [POST request]
  Future<void> addSaleOrder({
    @required List<Product> products,
    String comment = 'Новая заявка',
    double discount = 0.0,
  }) async {
    JwtTokenStore jwtTokenStore = JwtTokenStore();

    const customerOrdersUrl = '$kApiUrl/api/v1/customer_orders/';
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${jwtTokenStore.getToken()}'
    };

    final shopId = 1;
    final Map customerOrderBody = {
      "comment": "Новая продажа ${DateTime.now()}",
      "discount": discount,
      "shop_id": shopId,
      "customer_id": 1
    };

    //  Добавляем customer_order Заявку Клиента
    final response = await http.post(
      customerOrdersUrl,
      body: convert.jsonEncode(customerOrderBody),
      headers: headers,
    );

    if (response.statusCode == 201) {
      final CustomerOrder customerOrder =
          CustomerOrder.fromJson(jsonData: convert.jsonDecode(response.body));

      for (var product in products) {
        // Добавляем  customer_order_item Заявку Товара Клиента
        await _addCustomerOrderItem(
            product: product, customerOrderId: customerOrder.id);
      }
    } else {
      return throw 'Ошибка добавления CustomerOrder';
    }
  }

  /// Добавление продуктов(items) в заявке клента [Post request]
  Future<CustomerOrderItem> _addCustomerOrderItem(
      {Product product, int customerOrderId}) async {
    JwtTokenStore jwtTokenStore = JwtTokenStore();
    const customerOrderItemsUrl = '$kApiUrl/api/v1/customer_order_items/';
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${jwtTokenStore.getToken()}'
    };

    Map itemBody = {
      "items_count": product.count,
      "price": product.price,
      "comment": product.name,
      "products_id": product.id,
      "customer_order_id": customerOrderId,
    };
    final response = await http.post(
      customerOrderItemsUrl,
      body: convert.jsonEncode(itemBody),
      headers: headers,
    );
    if (response.statusCode == 201) {
      return CustomerOrderItem.fromJson(
          jsonData: convert.jsonDecode(response.body));
    } else {
      return throw 'Проблема с отправкой товаров!!!';
    }
  }

  /// Получение списка заявок клиента(продажи) [Get request]
  Future<List<CustomerOrder>> getAll() async {
    List<CustomerOrder> list;

    JwtTokenStore jwtTokenStore = JwtTokenStore();

    const customerOrdersUrl = '$kApiUrl/api/v1/customer_orders';
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${jwtTokenStore.getToken()}'
    };

    final response = await http.get(customerOrdersUrl, headers: headers);

    return list;
  }
}
