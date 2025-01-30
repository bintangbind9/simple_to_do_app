import 'package:flutter/widgets.dart' show SizedBox;

extension DoubleExtension on double {
  SizedBox get sizedBoxHeight {
    return SizedBox(height: this);
  }

  SizedBox get sizedBoxWidth {
    return SizedBox(width: this);
  }
}
