import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../constants/app_styles.dart';

Future<T?> showInputDialog<T>(
  BuildContext context,
  Widget input,
  List<Widget> actions, {
  Widget? header,
  double? maxDialogWidth,
  bool barrierDismissible = true,
}) async {
  final content = Wrap(
    children: [
      header == null
          ? const SizedBox()
          : Container(
              padding: const EdgeInsets.only(
                top: AppStyles.mainPadding,
                left: AppStyles.mainPadding,
                right: AppStyles.mainPadding,
              ),
              child: Stack(
                children: [
                  Center(child: header),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            ),
      Container(
        padding: const EdgeInsets.all(AppStyles.mainPadding),
        child: input,
      ),
      actions.isEmpty
          ? const SizedBox()
          : Container(
              padding: const EdgeInsets.only(
                left: AppStyles.mainPadding,
                right: AppStyles.mainPadding,
                bottom: AppStyles.mainPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: actions,
              ),
            ),
    ],
  );

  return await showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return Dialog(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: AppConstants.minDialogWidth,
            maxWidth: maxDialogWidth ?? AppConstants.maxDialogWidth,
          ),
          child: content,
        ),
      );
    },
  );
}
