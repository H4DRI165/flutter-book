// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:flutter_book/ui/ft_auth/pg_forgot_password/page.dart' as _i5;
import 'package:flutter_book/ui/ft_auth/pg_login/page.dart' as _i7;
import 'package:flutter_book/ui/ft_auth/pg_register/page.dart' as _i10;
import 'package:flutter_book/ui/ft_main/pg_landing/page.dart' as _i6;
import 'package:flutter_book/ui/ft_main/pg_splash/page.dart' as _i11;
import 'package:flutter_book/ui/ft_menu/ft_featured/pg_constraints_intro/page.dart'
    as _i1;
import 'package:flutter_book/ui/ft_menu/ft_topics/pg_loose/page.dart' as _i2;
import 'package:flutter_book/ui/ft_menu/ft_topics/pg_tight/page.dart' as _i3;
import 'package:flutter_book/ui/ft_menu/ft_topics/pg_unbounded/page.dart'
    as _i4;
import 'package:flutter_book/ui/ft_menu/pg_main_menu/page.dart' as _i8;
import 'package:flutter_book/ui/ft_profile/pg_profile/page.dart' as _i9;

/// generated route for
/// [_i1.ConstrainIntroPage]
class ConstrainIntroRoute extends _i12.PageRouteInfo<void> {
  const ConstrainIntroRoute({List<_i12.PageRouteInfo>? children})
    : super(ConstrainIntroRoute.name, initialChildren: children);

  static const String name = 'ConstrainIntroRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i1.ConstrainIntroPage();
    },
  );
}

/// generated route for
/// [_i2.ConstrainLoosePage]
class ConstrainLooseRoute extends _i12.PageRouteInfo<ConstrainLooseRouteArgs> {
  ConstrainLooseRoute({
    _i13.Key? key,
    required String topicId,
    bool showNextButton = false,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         ConstrainLooseRoute.name,
         args: ConstrainLooseRouteArgs(
           key: key,
           topicId: topicId,
           showNextButton: showNextButton,
         ),
         initialChildren: children,
       );

  static const String name = 'ConstrainLooseRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ConstrainLooseRouteArgs>();
      return _i2.ConstrainLoosePage(
        key: args.key,
        topicId: args.topicId,
        showNextButton: args.showNextButton,
      );
    },
  );
}

class ConstrainLooseRouteArgs {
  const ConstrainLooseRouteArgs({
    this.key,
    required this.topicId,
    this.showNextButton = false,
  });

  final _i13.Key? key;

  final String topicId;

  final bool showNextButton;

  @override
  String toString() {
    return 'ConstrainLooseRouteArgs{key: $key, topicId: $topicId, showNextButton: $showNextButton}';
  }
}

/// generated route for
/// [_i3.ConstrainTightPage]
class ConstrainTightRoute extends _i12.PageRouteInfo<ConstrainTightRouteArgs> {
  ConstrainTightRoute({
    _i13.Key? key,
    required String topicId,
    bool showNextButton = false,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         ConstrainTightRoute.name,
         args: ConstrainTightRouteArgs(
           key: key,
           topicId: topicId,
           showNextButton: showNextButton,
         ),
         initialChildren: children,
       );

  static const String name = 'ConstrainTightRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ConstrainTightRouteArgs>();
      return _i3.ConstrainTightPage(
        key: args.key,
        topicId: args.topicId,
        showNextButton: args.showNextButton,
      );
    },
  );
}

class ConstrainTightRouteArgs {
  const ConstrainTightRouteArgs({
    this.key,
    required this.topicId,
    this.showNextButton = false,
  });

  final _i13.Key? key;

  final String topicId;

  final bool showNextButton;

  @override
  String toString() {
    return 'ConstrainTightRouteArgs{key: $key, topicId: $topicId, showNextButton: $showNextButton}';
  }
}

/// generated route for
/// [_i4.ConstrainUnboundedPage]
class ConstrainUnboundedRoute
    extends _i12.PageRouteInfo<ConstrainUnboundedRouteArgs> {
  ConstrainUnboundedRoute({
    _i13.Key? key,
    required String topicId,
    bool showNextButton = false,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         ConstrainUnboundedRoute.name,
         args: ConstrainUnboundedRouteArgs(
           key: key,
           topicId: topicId,
           showNextButton: showNextButton,
         ),
         initialChildren: children,
       );

  static const String name = 'ConstrainUnboundedRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ConstrainUnboundedRouteArgs>();
      return _i4.ConstrainUnboundedPage(
        key: args.key,
        topicId: args.topicId,
        showNextButton: args.showNextButton,
      );
    },
  );
}

class ConstrainUnboundedRouteArgs {
  const ConstrainUnboundedRouteArgs({
    this.key,
    required this.topicId,
    this.showNextButton = false,
  });

  final _i13.Key? key;

  final String topicId;

  final bool showNextButton;

  @override
  String toString() {
    return 'ConstrainUnboundedRouteArgs{key: $key, topicId: $topicId, showNextButton: $showNextButton}';
  }
}

/// generated route for
/// [_i5.ForgotPasswordPage]
class ForgotPasswordRoute extends _i12.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i12.PageRouteInfo>? children})
    : super(ForgotPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i5.ForgotPasswordPage();
    },
  );
}

/// generated route for
/// [_i6.LandingPage]
class LandingRoute extends _i12.PageRouteInfo<void> {
  const LandingRoute({List<_i12.PageRouteInfo>? children})
    : super(LandingRoute.name, initialChildren: children);

  static const String name = 'LandingRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i6.LandingPage();
    },
  );
}

/// generated route for
/// [_i7.LoginPage]
class LoginRoute extends _i12.PageRouteInfo<void> {
  const LoginRoute({List<_i12.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i7.LoginPage();
    },
  );
}

/// generated route for
/// [_i8.MainMenuPage]
class MainMenuRoute extends _i12.PageRouteInfo<void> {
  const MainMenuRoute({List<_i12.PageRouteInfo>? children})
    : super(MainMenuRoute.name, initialChildren: children);

  static const String name = 'MainMenuRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i8.MainMenuPage();
    },
  );
}

/// generated route for
/// [_i9.ProfilePage]
class ProfileRoute extends _i12.PageRouteInfo<void> {
  const ProfileRoute({List<_i12.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i9.ProfilePage();
    },
  );
}

/// generated route for
/// [_i10.RegisterPage]
class RegisterRoute extends _i12.PageRouteInfo<void> {
  const RegisterRoute({List<_i12.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i10.RegisterPage();
    },
  );
}

/// generated route for
/// [_i11.SplashPage]
class SplashRoute extends _i12.PageRouteInfo<void> {
  const SplashRoute({List<_i12.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i11.SplashPage();
    },
  );
}
