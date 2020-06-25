import 'package:equatable/equatable.dart';

abstract class CustomerOrderState extends Equatable {
  const CustomerOrderState();

  @override
  List<Object> get props => [];
}

class InitialCustomerOrderState extends CustomerOrderState {}

class InProgressCustomerOrderState extends CustomerOrderState {}

class SuccessLoadCustomerOrderState extends CustomerOrderState {}

class FailureLoadCustomerOrderState extends CustomerOrderState {}
