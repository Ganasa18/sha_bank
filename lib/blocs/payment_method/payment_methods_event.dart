part of 'payment_methods_bloc.dart';

abstract class PaymentMethodsEvent extends Equatable {
  const PaymentMethodsEvent();

  @override
  List<Object> get props => [];
}

class PaymentMethodsGet extends PaymentMethodsEvent {}
