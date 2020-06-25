import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wellnor/blocs/auth/auth.dart';
import 'package:wellnor/blocs/login/login.dart';
import 'package:wellnor/constants.dart';
import 'package:wellnor/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;

  LoginScreen({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            userRepository: this.userRepository,
            authBloc: BlocProvider.of<AuthBloc>(context),
          );
        },
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
          width: double.infinity,
          height: double.infinity,
          color: Colors.white70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: SingleChildScrollView(
                  child: LoginForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      if (widget._formKey.currentState.validate()) {
        BlocProvider.of<LoginBloc>(context).add(
          LoginButtonPressed(
            username: _usernameController.text,
            password: _passwordController.text,
          ),
        );
      }
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return Form(
          key: widget._formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 170,
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/logo.jpg",
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _usernameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Введите номер телефона';
                  }
                  return null;
                },
                showCursor: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Color(0xFF666666),
                    size: kDefaultIconSize,
                  ),
                  fillColor: Color(0xFFF2F3F5),
                  hintStyle: TextStyle(
                      color: Color(0xFF666666),
                      fontFamily: kDefaultFontFamily,
                      fontSize: kDefaultFontSize),
                  hintText: "Номер телефона",
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Введите пароль';
                  }
                  return null;
                },
                showCursor: true,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  prefixIcon: IconButton(
                      icon: Icon(
                        Icons.lock_outline,
                        color: Color(0xFF666666),
                        size: kDefaultIconSize,
                      ),
                      onPressed: () {}),
                  suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Color(0xFF666666),
                        size: kDefaultIconSize,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      }),
                  fillColor: Color(0xFFF2F3F5),
                  hintStyle: TextStyle(
                    color: Color(0xFF666666),
                    fontFamily: kDefaultFontFamily,
                    fontSize: kDefaultFontSize,
                  ),
                  hintText: "Пароль",
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                child: ButtonTheme(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed:
                        state is! LoginLoading ? _onLoginButtonPressed : null,
                    color: kAccentColor,
                    child: Text(
                      'Войти',
                      style: TextStyle(fontSize: 16.0, color: kPrimeryColor),
                    ),
                  ),
                ),
              ),
              Container(
                child:
                    state is LoginLoading ? CircularProgressIndicator() : null,
              )
            ],
          ),
        );
      }),
    );
  }
}
