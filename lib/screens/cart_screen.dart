import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wellnor/blocs/blocs.dart';
import 'package:wellnor/blocs/checkout/bloc.dart';
import 'package:wellnor/models/models.dart';
import 'package:wellnor/widgets/loading_indicator.dart';
import 'package:wellnor/widgets/total_calculation_widget.dart';
import 'package:wellnor/constants.dart';

class CartScreen extends StatelessWidget {
  final CartBloc cartBloc;

  const CartScreen({Key key, this.cartBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutBloc(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          title: Center(
            child: Text("Корзина"),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.percent,
                size: 18.0,
              ),
              onPressed: () {
                _onSetDiscountPress(context).then(
                  (discount) => cartBloc.add(SetDiscountCartEvent(discount)),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_shopping_cart),
              onPressed: () {
                cartBloc.add(ClearCartEvent());
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: BlocListener<CheckoutBloc, CheckoutState>(
          listener: (context, state) {
            if (state is CheckoutSuccessState) {
              cartBloc.add(ClearCartEvent());
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.message}'),
                  backgroundColor: kAccentColor,
                ),
              );
            }
            if (state is CheckoutFailureState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              if (state is CheckoutInProgressState) {
                return LoadingIndicator();
              }
              if (state is CheckoutSuccessState) {
                return _cartEmptyImage();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: 15.0,
                      right: 10.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Text(
                      "Список выбранных товаров",
                      style: TextStyle(
                          color: Color(0xFF3a3a3b),
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: BlocBuilder<CartBloc, CartState>(
                        bloc: cartBloc,
                        builder: (context, state) {
                          if (state is FullCartState) {
                            return _createList(products: state.cartProducts);
                          }
                          return _cartEmptyImage();
                        },
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: _bottomNavigatorBar(),
      ),
    );
  }

  Widget _cartEmptyImage() {
    return Center(
      child: Image.asset('assets/images/empty_cart.png'),
    );
  }

  Widget _createList({BuildContext context, List<Product> products}) {
    return ListView(
      children: List.generate(products.length, (index) {
        Product product = products[index];
        return BlocProvider<ItemBloc>(
          create: (context) {
            ItemBloc itemBloc = ItemBloc(productsBloc: cartBloc.productsBloc);
            return itemBloc;
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
                              "${product.totalText}",
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
                                            Product p = product.copyWith(
                                                count: product.count - 1);
                                            cartBloc.add(UpdateCartEvent(p));
                                            cartBloc.productsBloc
                                                .changeProduct(p);
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
                                            Product p = product.copyWith(
                                                count: product.count + 1);
                                            cartBloc.add(UpdateCartEvent(p));
                                            cartBloc.productsBloc
                                                .changeProduct(p);
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
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Product p = product.copyWith(count: 0);
                        cartBloc
                            .add(UpdateCartEvent(product.copyWith(count: 0)));
                        cartBloc.productsBloc.changeProduct(p);
                      }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _bottomNavigatorBar() {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        if (state is CheckoutInProgressState) {
          return Container(height: 0.0, width: 0.0);
        } else if (state is CheckoutSuccessState) {
          return BlocBuilder(
            bloc: cartBloc,
            builder: (context, state) {
              if (state is FullCartState) {
                return TotalCalculationWidget(
                  onCheckoutPress: null,
                  count: state.countText,
                  total: state.totalText,
                  discount: state.discountText,
                  amount: state.amountText,
                );
              } else {
                return Container(width: 0.0, height: 0.0);
              }
            },
          );
        }
        return BlocBuilder(
          bloc: cartBloc,
          builder: (context, state) {
            if (state is FullCartState) {
              return TotalCalculationWidget(
                onCheckoutPress: () => _onCheckoutPress(context, state),
                count: state.countText,
                total: state.totalText,
                discount: state.discountText,
                amount: state.amountText,
              );
            } else {
              return Container(width: 0.0, height: 0.0);
            }
          },
        );
      },
    );
  }

  _onCheckoutPress(BuildContext context, FullCartState state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text('Подтверждение продажи'),
        content: Text('Оформить продажу?'),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Отмена')),
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                BlocProvider.of<CheckoutBloc>(context).add(
                  CheckoutCustomerOrderEvent(
                    products: state.cartProducts,
                    discount: state.discount,
                  ),
                );
              },
              child: Text('Да')),
        ],
        elevation: 24.0,
      ),
    );
  }

  Future<double> _onSetDiscountPress(BuildContext context) {
    final discountTextController = TextEditingController();
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text('Введите процент скидки'),
        content: TextField(
          controller: discountTextController,
          keyboardType: TextInputType.number,
        ),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                double discount =
                    double.parse(discountTextController.text.toString());
                Navigator.pop(context, discount);
              },
              child: Text('OK')),
        ],
        elevation: 24.0,
      ),
    );
  }
}
