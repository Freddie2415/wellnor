import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:wellnor/constants.dart';
import 'package:wellnor/entities/product_entity.dart';
import 'package:wellnor/keystore.dart';

class ProductRepository {
  final String _url = "$kApiUrl/api/v1/product/";

  Future<List<ProductEntity>> loadProducts() async {
    var jwt = JwtTokenStore();
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${jwt.getToken()}'
    };
    var response = await http.get(_url, headers: headers);
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body)['results'] as List;
      List<ProductEntity> productsEntity = data.map((rawData) {
        return ProductEntity(
          id: rawData['id'],
          price: rawData['price'],
          description: rawData['description'],
          image: rawData['image'],
          name: rawData['name'],
          category_id: rawData['category_id'],
          discount_begin: rawData['discount_begin'],
          discount_end: rawData['discount_end'],
          discount_percent: rawData['discount_percent'],
          product_type: rawData['product_type'],
          status: rawData['status'],
        );
      }).toList();

      return productsEntity;
    } else {
      print('UPPPPS');
    }

    return [];
  }
}
