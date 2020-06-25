import 'package:equatable/equatable.dart';

abstract class CustomerOrderEvent extends Equatable {
  const CustomerOrderEvent();

  @override
  List<Object> get props => [];
}

class LoadCustomerOrderEvent extends CustomerOrderEvent {}

class FilterCustomerOrderEvent extends CustomerOrderEvent {}
