import 'package:flutter/material.dart' show BuildContext;
import 'package:form_builder_validators/form_builder_validators.dart';

class ValidatorUtil {
  static const int minLengthPassword = 6;
  static const String lowercasePattern = '.*[a-z].*';
  static const String uppercasePattern = '.*[A-Z].*';
  static const String numericPattern = '.*[0-9].*';
  static const String symbolPattern = r'[^\w\s]+';

  static String? Function(String?) passwordValidator(BuildContext context) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: 'This field is required',
      ),
      FormBuilderValidators.minLength(
        minLengthPassword,
        errorText:
            'Password must be at least $minLengthPassword characters long',
      ),
      FormBuilderValidators.match(
        numericPattern,
        errorText: 'Password must contain at least one number',
      ),
      FormBuilderValidators.match(
        lowercasePattern,
        errorText: 'Password must contain at least one lowercase letter',
      ),
      FormBuilderValidators.match(
        uppercasePattern,
        errorText: 'Password must contain at least one uppercase letter',
      ),
      FormBuilderValidators.match(
        symbolPattern,
        errorText: 'Password must contain at least one symbol',
      ),
    ]);
  }
}
