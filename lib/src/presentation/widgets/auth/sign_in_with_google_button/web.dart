// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'stub.dart';

/// Renders a web-only SIGN IN button.
Widget buildSignInWithGoogleButton({
  required BuildContext context,
  HandleSignInFn? onPressed,
}) {
  return TextButton(
    onPressed: onPressed,
    child: Text('Sign in with Google WEB'),
  );
  /*
  return renderButton(
    configuration: GSIButtonConfiguration(
      theme: GSIButtonTheme.outline,
      shape: GSIButtonShape.pill,
      locale: 'en',
    ),
  );
  */
}
