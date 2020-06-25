import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:wellnor/blocs/blocs.dart';
import 'package:wellnor/constants.dart';
import 'package:wellnor/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnor/screens/cart_screen.dart';
import 'package:wellnor/widgets/widgets.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  final ItemBloc itemBloc;
  final CartBloc cartBloc;

  ProductDetailsScreen({
    Key key,
    this.product,
    this.itemBloc,
    this.cartBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('YEAP!');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1.0,
        title: Text(
          '${product.name}',
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Carousel(
                autoplay: true,
                images: [
                  NetworkImage('${product.image}'),
                  NetworkImage('${product.image}'),
                  NetworkImage('${product.image}'),
                ],
                dotSize: 5.0,
                dotSpacing: 20.0,
                indicatorBgPadding: 5.0,
                dotBgColor: Colors.transparent,
                moveIndicatorFromBottom: 180.0,
                noRadiusForIndicator: true,
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      '${product.name}',
                      style: TextStyle(
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    trailing: Text(
                      '${product.priceText}',
                      style: TextStyle(
                          color: kAccentColor, fontWeight: FontWeight.w800),
                    ),
                    subtitle: Text(
                      '${product.inStockText}',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ),
                  _counterWidget(),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Описание: ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${product.description ?? ''}",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
          bloc: cartBloc, builder: _buildCheckoutWidget),
    );
  }

  Widget _counterWidget() {
    return BlocBuilder<ItemBloc, Product>(
      bloc: this.itemBloc,
      builder: (context, state) {
        Product product = state ?? this.product;
        if (state.isSelected) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.remove,
                  color: kAccentColor,
                ),
                onPressed: onPressRemoveButton,
              ),
              Text(
                '${product.count}',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
              ),
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: kAccentColor,
                ),
                onPressed: onPressAddButton,
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: kAccentColor,
                ),
                onPressed: onPressClearButton,
              )
            ],
          );
        }

        return MaterialButton(
          minWidth: MediaQuery.of(context).size.width - 20.0,
          textColor: Colors.white,
          color: kAccentColor,
          child: Text(
            'Добавить в корзину',
            style: TextStyle(fontSize: 16.0),
          ),
          onPressed: onPressAddButton,
        );
      },
    );
  }

  Widget _buildCheckoutWidget(context, state) {
    if (state is FullCartState) {
      return CheckoutPanelWidget(
        onCartButtonPress: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartScreen(cartBloc: cartBloc),
            ),
          );
          cartBloc.productsBloc.add(ProductsFiltered(query: ''));
          Navigator.pop(context);
        },
        amountText: state.totalText,
        countText: state.countText,
      );
    }
    return Container(
      width: 0.0,
      height: 0.0,
    );
  }

  void onPressRemoveButton() {
    this.itemBloc.add(RemoveItemEvent(this.itemBloc.state));
  }

  void onPressAddButton() {
    this.itemBloc.add(AddItemEvent(this.itemBloc.state));
  }

  void onPressClearButton() {
    this.itemBloc.add(ClearItemEvent(this.itemBloc.state));
  }
}
