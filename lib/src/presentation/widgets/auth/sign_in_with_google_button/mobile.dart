// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../common_button.dart';
import 'stub.dart';

/// Renders a SIGN IN button that calls `handleSignIn` onclick.
Widget buildSignInWithGoogleButton({
  required BuildContext context,
  HandleSignInFn? onPressed,
}) {
  return CommonButton(
    text: 'Sign in with Google',
    onPressed: () => context.read<AuthBloc>().add(SignInWithGoogle()),
    icon: FontAwesomeIcons.google,
    textColor: Colors.black54,
    backgroundColor: Colors.white,
    borderColor: Colors.black54,
  );
}
