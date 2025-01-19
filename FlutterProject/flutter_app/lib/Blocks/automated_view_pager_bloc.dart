import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class AutomatedViewPagerBloc extends Bloc<AutomatedViewPagerBlocEvent, int> {
  // TODO: implement initialState
  bool looper = false;

  AutomatedViewPagerBloc() : super(0) {
    on<AutomatedViewPagerBlocEvent>(mapEventToState);
  }

  void mapEventToState(
      AutomatedViewPagerBlocEvent event, Emitter<int> emit) async {
    switch (event) {
      case AutomatedViewPagerBlocEvent.start:
        looper = true;

        await Future.delayed(const Duration(seconds: 4));
        if (state >= 2) {
          emit(0);
        } else {
          emit(state + 1);
        }
        add(AutomatedViewPagerBlocEvent.loop);

        break;
      case AutomatedViewPagerBlocEvent.loop:
        if (looper) {
          await Future.delayed(const Duration(seconds: 4));
          if (state >= 2) {
            emit(0);
          } else {
            emit(state + 1);
          }
          add(AutomatedViewPagerBlocEvent.loop);
        }
        break;
      case AutomatedViewPagerBlocEvent.stop:
        looper = false;
        break;
    }
  }
}

enum AutomatedViewPagerBlocEvent { start, stop, loop }
