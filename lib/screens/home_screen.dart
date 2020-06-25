import 'package:flutter/material.dart';
import 'package:wellnor/blocs/blocs.dart';
import 'package:wellnor/blocs/cart/cart.dart';
import 'package:wellnor/blocs/products/products.dart';
import 'package:wellnor/constants.dart';
import 'package:wellnor/models/models.dart';
import 'package:wellnor/models/product.dart';
import 'package:wellnor/screens/screens.dart';
import 'package:wellnor/widgets/loading_indicator.dart';
import 'package:wellnor/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text(
          "WellNor",
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
            ),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LoggedOut());
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: kPrimeryColor,
              ),
              child: Text(
                '${user.name}',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.add_comment,
                color: kPrimeryVariant,
              ),
              title: Text('Поставка товаров'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsSupplyScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.receipt,
                color: kPrimeryVariant,
              ),
              title: Text('Отчёты'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReportScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_cart,
                color: kPrimeryVariant,
              ),
              title: Text('Корзина'),
              trailing: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is FullCartState) {
                    return Text('${state.countText}');
                  }
                  return Container(width: 0.0, height: 0.0);
                },
              ),
              onTap: () async {
                CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(cartBloc: cartBloc),
                  ),
                );
                cartBloc.productsBloc.add(ProductsFiltered(query: ''));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: kPrimeryVariant,
              ),
              title: Text('Настройки'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SearchWidget(),
          Container(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 10.0,
              top: 10.0,
              bottom: 10.0,
            ),
            child: Text(
              "Список товаров",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, productsState) {
                if (productsState is ProductsInProgress) {
                  return LoadingIndicator();
                }
                if (productsState is ProductsLoadSuccess) {
                  return _createList(
                      products: productsState.products, context: context);
                }
                String message = 'Проверьте подключение к интернету!';
                if (productsState is ProductsLoadFailure) {
                  message = productsState.message;
                }

                return Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(message),
                        FlatButton(
                          color: kAccentColor,
                          textColor: Colors.white,
                          onPressed: () {
                            BlocProvider.of<ProductsBloc>(context)
                                .add(ProductsLoaded());
                          },
                          child: Text('Перезагрузить'),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar:
          BlocBuilder<CartBloc, CartState>(builder: _buildCheckoutWidget),
    );
  }

  Widget _createList({BuildContext context, List<Product> products}) {
    return ListView(
      children: List.generate(products.length, (index) {
        Product product = products[index];
        return BlocProvider<ItemBloc>(
          create: (context) {
            ItemBloc itemBloc =
                ItemBloc(productsBloc: BlocProvider.of<ProductsBloc>(context));
            return itemBloc;
          },
          child: BlocBuilder<ItemBloc, Product>(
            builder: (BuildContext context, Product productState) {
              if (productState.id != 0) {
                product = productState;
              }
              BlocProvider.of<CartBloc>(context).add(UpdateCartEvent(product));
              return ProductCard(product: product);
            },
          ),
        );
      }),
    );
  }

  Widget _buildCheckoutWidget(context1, state) {
    if (state is FullCartState) {
      CartBloc cartBloc = BlocProvider.of<CartBloc>(context1);
      return CheckoutPanelWidget(
        onCartButtonPress: () async {
          await Navigator.push(
            context1,
            MaterialPageRoute(
              builder: (context) => CartScreen(cartBloc: cartBloc),
            ),
          );
          cartBloc.productsBloc.add(ProductsFiltered(query: ''));
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
}
