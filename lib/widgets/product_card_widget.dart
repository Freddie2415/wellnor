import 'package:flutter/material.dart';
import 'package:wellnor/blocs/blocs.dart';
import 'package:wellnor/blocs/cart/cart.dart';
import 'package:wellnor/constants.dart';
import 'package:wellnor/models/models.dart';
import 'package:wellnor/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ItemBloc itemBloc = BlocProvider.of<ItemBloc>(context);
        CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              product: product,
              cartBloc: cartBloc,
              itemBloc: itemBloc..add(UpdateItemEvent(product)),
            ),
          ),
        );
      },
      child: Card(
        color: product.isSelected ? kAccentSecond : Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/img-placeholder.png',
                    image: '${product.image}',
                    width: 105,
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${product.name}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Text(
                          "${product.priceText}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        child: Text(
                          "На складе: ${product.qtyInStock} шт.",
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF3a3a3b),
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        alignment: Alignment.centerRight,
                        child: product.isSelected
                            ? Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove,
                                        color: kAccentColor,
                                      ),
                                      onPressed: () {
                                        BlocProvider.of<ItemBloc>(context)
                                            .add(RemoveItemEvent(product));
                                      },
                                    ),
                                    Text(
                                      "${product.count}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: kAccentColor,
                                      ),
                                      onPressed: () {
                                        BlocProvider.of<ItemBloc>(context)
                                            .add(AddItemEvent(product));
                                      },
                                    )
                                  ],
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
              !product.isSelected
                  ? IconButton(
                      icon: Icon(
                        Icons.add_shopping_cart,
                        color: kAccentColor,
                      ),
                      onPressed: () {
                        BlocProvider.of<ItemBloc>(context)
                            .add(AddItemEvent(product));
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        BlocProvider.of<ItemBloc>(context)
                            .add(ClearItemEvent(product));
                      })
            ],
          ),
        ),
      ),
    );
  }
}
