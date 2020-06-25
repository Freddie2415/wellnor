import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wellnor/repositories/customer_order_repository.dart';
import 'customer_order.dart';

class CustomerOrderBloc extends Bloc<CustomerOrderEvent, CustomerOrderState> {
  @override
  CustomerOrderState get initialState => InitialCustomerOrderState();

  @override
  Stream<CustomerOrderState> mapEventToState(
    CustomerOrderEvent event,
  ) async* {
    if (event is LoadCustomerOrderEvent) {
      yield* _mapLoadCustomerToState();
    }
  }

  Stream<CustomerOrderState> _mapLoadCustomerToState() async* {
    yield InProgressCustomerOrderState();
    CustomerOrderRepository customerOrderRepository = CustomerOrderRepository();
  }
}
