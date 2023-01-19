part of 'payment_methods_bloc.dart';

abstract class PaymentMethodsState extends Equatable {
  const PaymentMethodsState();

  @override
  List<Object> get props => [];
}

class PaymentMethodsInitial extends PaymentMethodsState {}

class PaymentMethodsLoading extends PaymentMethodsState {}

class PaymentMethodsFailed extends PaymentMethodsState {
  final String e;

  const PaymentMethodsFailed(this.e);

  @override
  List<Object> get props => [e];
}

class PaymentMethodsSuccess extends PaymentMethodsState {
  final List<PaymentMethodModel> paymentMethods;
  const PaymentMethodsSuccess(this.paymentMethods);
  @override
  List<Object> get props => [paymentMethods];
}
