import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;

  User({@required this.id, @required this.name, @required this.email});

  @override
  List<Object> get props => [id, name, email];

  @override
  String toString() {
    return 'USER {id: $id, name: $name, email: $email }';
  }
}
