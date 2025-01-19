import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateOtpBloc extends Bloc<UpdateOtpBlocEvent, List<String>> {
  UpdateOtpBloc() : super(["•", "•", "•", "•", "•", "•"]) {
    on<UpdateOtpBlocEvent>(mapEventToState);
  }

  void mapEventToState(
      UpdateOtpBlocEvent event, Emitter<List<String>> emit) async {
    if (event.string.trim() == "<") {
      emit(List.from(removeString(state)));
    } else if (event.string.trim() == "") {
      emit(List.from(state));
    } else {
      emit(List.from(addString(state, event.string)));
    }
  }

  List<String> addString(List<String> str, String data) {
    for (int i = 0; i < 6; i++) {
      if (str[i] == "•") {
        str[i] = data;
        break;
      }
    }

    return str;
  }

  List<String> removeString(List<String> str) {
    for (int i = 5; i >= 0; i--) {
      if (str[i] != "•") {
        str[i] = "•";
        break;
      }
    }
    return str;
  }
}

class UpdateOtpBlocEvent {
  UpdateOtpBlocEvent({required this.string});
  final String string;
}
