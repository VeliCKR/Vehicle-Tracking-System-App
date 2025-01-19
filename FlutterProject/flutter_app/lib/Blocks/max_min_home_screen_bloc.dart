import 'package:flutter_bloc/flutter_bloc.dart';

class MaxMinHomeScreenBloc extends Bloc<MaxMinHomeScreenBlocEvent, bool> {
  MaxMinHomeScreenBloc() : super(false) {
    on<MaxMinHomeScreenBlocEvent>(mapEventToState);
  }

  bool get initialState => false;

  void mapEventToState(
      MaxMinHomeScreenBlocEvent event, Emitter<bool> emit) async {
    switch (event) {
      case MaxMinHomeScreenBlocEvent.maximise:
        emit(false);
        break;
      case MaxMinHomeScreenBlocEvent.minimise:
        emit(true);
        break;
    }
  }
}

enum MaxMinHomeScreenBlocEvent { maximise, minimise }
