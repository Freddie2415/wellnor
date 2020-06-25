import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
