// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../bloc/auth/auth_bloc.dart';
import 'stub.dart';

/// Renders a SIGN IN button that calls `handleSignIn` onclick.
Widget buildSignInWithGoogleButton({
  required BuildContext context,
  HandleSignInFn? onPressed,
}) {
  return ElevatedButton(
    onPressed: () => context.read<AuthBloc>().add(SignInWithGoogle()),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        const FaIcon(FontAwesomeIcons.google),
        Text('Sign in with Google'),
      ],
    ),
  );
}
