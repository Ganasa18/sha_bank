import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sha_bank/models/payment_method_model.dart';

import '../../services/payment_method_service.dart';

part 'payment_methods_event.dart';
part 'payment_methods_state.dart';

class PaymentMethodsBloc
    extends Bloc<PaymentMethodsEvent, PaymentMethodsState> {
  PaymentMethodsBloc() : super(PaymentMethodsInitial()) {
    on<PaymentMethodsEvent>((event, emit) async {
      if (event is PaymentMethodsGet) {
        try {
          emit(PaymentMethodsLoading());
          final paymentMethods =
              await PaymentMethodService().getPaymentMethods();

          emit(PaymentMethodsSuccess(paymentMethods));
        } catch (e) {
          emit(PaymentMethodsFailed(e.toString()));
        }
      }
    });
  }
}
