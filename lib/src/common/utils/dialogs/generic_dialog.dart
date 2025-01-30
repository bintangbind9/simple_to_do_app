import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

Future<T?> showGenericDialog<T>(
  BuildContext context,
  String text,
  List<Widget> actions,
) async {
  return await showDialog<T>(
    context: context,
    builder: (context) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: AppConstants.minDialogWidth,
            maxWidth: AppConstants.maxDialogWidth,
          ),
          child: Wrap(
            children: [
              Column(
                children: [
                  const SizedBox(height: 32),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: actions,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
