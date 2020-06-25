import 'package:flutter/material.dart';
import 'package:wellnor/blocs/blocs.dart';
import 'package:wellnor/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget();

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController controller = TextEditingController();
  bool showClearButton = false;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        showClearButton = !(controller.text != null && controller.text != '');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
      child: Theme(
        data: ThemeData(primaryColor: kAccentColor),
        child: TextField(
          autofocus: false,
          controller: controller,
          onChanged: (value) {
            BlocProvider.of<ProductsBloc>(context)
                .add(ProductsFiltered(query: value));
          },
          cursorColor: kAccentColor,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                style: BorderStyle.solid,
              ),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: kAccentColor,
            ),
            suffixIcon: showClearButton
                ? null
                : IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      controller.clear();
                      FocusScope.of(context).unfocus();
                      BlocProvider.of<ProductsBloc>(context)
                          .add(ProductsFiltered(query: ''));
                    }),
            hintText: "Поиск по названию товара",
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
