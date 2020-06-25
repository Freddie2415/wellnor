import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wellnor/repositories/repositories.dart';
import 'package:wellnor/services/print_service.dart';
import './bloc.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  @override
  CheckoutState get initialState => InitialCheckoutState();

  @override
  Stream<CheckoutState> mapEventToState(
    CheckoutEvent event,
  ) async* {
    if (event is CheckoutCustomerOrderEvent) {
      yield* _mapCheckoutCustomerOrderToState(event);
    }
  }

  Stream<CheckoutState> _mapCheckoutCustomerOrderToState(
      CheckoutCustomerOrderEvent event) async* {
    CustomerOrderRepository customerOrderRepository = CustomerOrderRepository();

    try {
      //Переходим в состояние загрузки
      yield CheckoutInProgressState();
      //Отпавляем корзину базу
      await Future.delayed(Duration(seconds: 1));

      await customerOrderRepository.addSaleOrder(
        products: event.products,
        comment: event.comment,
        discount: event.discount,
      );

      //Печать чека
/*      String result =
          await PrintService.printReceipt(event.products, event.discount);
      print("PRINT RESULT: $result");*/

      //Переходим в состояние успешной отправки заявки
      yield CheckoutSuccessState();
    } catch (e) {
      yield CheckoutFailureState(message: e.toString());
      yield InitialCheckoutState();
    }
  }
}
