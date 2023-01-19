import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sha_bank/models/tip_model.dart';
import 'package:sha_bank/services/tip_service.dart';

part 'tip_event.dart';
part 'tip_state.dart';

class TipBloc extends Bloc<TipEvent, TipState> {
  TipBloc() : super(TipInitial()) {
    on<TipEvent>((event, emit) async {
      if (event is TipGet) {
        try {
          emit(TipLoading());
          final tips = await TipService().getTip();
          emit(TipSuccess(tips));
        } catch (e) {
          emit(
            TipFailed(e.toString()),
          );
        }
      }
    });
  }
}
