part of 'transfer_bloc.dart';

abstract class TransferState extends Equatable {
  const TransferState();

  @override
  List<Object> get props => [];
}

class TransferInitial extends TransferState {}

class TransferLoading extends TransferState {}

class TransferFailed extends TransferState {
  final String e;

  const TransferFailed(this.e);

  @override
  List<Object> get props => [e];
}

// tidak perlu paramater karena tidak mengembalikan apapun
class TransferSuccess extends TransferState {}
