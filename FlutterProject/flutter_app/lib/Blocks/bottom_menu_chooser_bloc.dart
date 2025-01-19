import 'package:flutter_bloc/flutter_bloc.dart';

class BottomMenuChooserBloc
    extends Bloc<BottomMenuChooserBlocEvent, BottomMenuChooserBlocEvent> {
  BottomMenuChooserBloc() : super(BottomMenuChooserBlocEvent.home) {
    on<BottomMenuChooserBlocEvent>(mapEventToState);
  }

  void mapEventToState(BottomMenuChooserBlocEvent event,
      Emitter<BottomMenuChooserBlocEvent> emit) async {
    emit(event);
  }
}

enum BottomMenuChooserBlocEvent { home, cards, history, profile }
