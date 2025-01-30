import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'equal_password_validation_event.dart';

class EqualPasswordValidationBloc
    extends Bloc<EqualPasswordValidationEvent, String> {
  EqualPasswordValidationBloc() : super('') {
    on<UpdateEqualPasswordValidation>((event, emit) {
      emit(event.password);
    });
  }
}
