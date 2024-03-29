import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:papa_burger_admin_panel/src/config/theme/theme.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    required this.body,
    super.key,
    this.onWillPop,
    this.withSafeArea = false,
    this.top = true,
    this.bottom = true,
    this.left = true,
    this.right = true,
    this.withReleaseFocus = false,
    this.resizeToAvoidBottomInset = false,
    this.backroundColor,
    this.floatingActionButton,
    this.appBar,
    this.bottomNavigationBar,
    this.drawer,
    this.bottomSheet,
    this.themeData,
  });

  final Future<bool> Function()? onWillPop;
  final bool withSafeArea;
  final bool top;
  final bool bottom;
  final bool right;
  final bool left;
  final bool withReleaseFocus;
  final bool resizeToAvoidBottomInset;
  final Widget body;
  final Color? backroundColor;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final AppBar? appBar;
  final Widget? drawer;
  final Widget? bottomSheet;
  final SystemUiOverlayStyle? themeData;

  @override
  Widget build(BuildContext context) {
    return withReleaseFocus
        ? GestureDetector(
            onTap: () => _releaseFocus(context),
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: themeData ?? SystemUiOverlayTheme.mainOverlayStyle,
              child: Scaffold(
                resizeToAvoidBottomInset: resizeToAvoidBottomInset,
                backgroundColor: backroundColor,
                body: withSafeArea
                    ? SafeArea(
                        top: top,
                        bottom: bottom,
                        right: right,
                        left: left,
                        child: body,
                      )
                    : body,
                floatingActionButton: floatingActionButton,
                bottomNavigationBar: bottomNavigationBar,
                appBar: appBar,
                drawer: drawer,
                bottomSheet: bottomSheet,
              ),
            ),
          )
        : AnnotatedRegion<SystemUiOverlayStyle>(
            value: themeData ?? SystemUiOverlayTheme.mainOverlayStyle,
            child: Scaffold(
              body: withSafeArea
                  ? SafeArea(
                      top: top,
                      bottom: bottom,
                      right: right,
                      left: left,
                      child: body,
                    )
                  : body,
              backgroundColor: backroundColor,
              floatingActionButton: floatingActionButton,
              bottomNavigationBar: bottomNavigationBar,
              appBar: appBar,
              drawer: drawer,
              bottomSheet: bottomSheet,
            ),
          );
  }

  void _releaseFocus(BuildContext context) => FocusScope.of(context).unfocus();
}
