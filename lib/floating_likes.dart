library;

import 'package:flutter/material.dart';
import 'dart:math';
part 'floating_likes_controller.dart';
part 'like_widget.dart';
part 'animated_translate_widget.dart';
/// A widget that animates floating "likes" (e.g. hearts) on the screen.
///
/// Call `controller.showLike()` to trigger a new floating like animation using [FloatingLikesController].
class FloatingLikes extends StatefulWidget {
  /// Creates a [FloatingLikes] widget.
  ///
  /// The [controller] and [likeWidget] are required.
  /// the controller is [FloatingLikesController] that triggers the like animation.
  /// The [likeWidget] is the widget that will be animated as a like (e.g. an image or icon).
  const FloatingLikes({
    super.key,

    /// The controller used to trigger new like animations externally [FloatingLikesController]
    required this.controller,

    /// The widget to display for each like (e.g. an image or icon).
    ///
    /// Example: `Image.asset('assets/heart.png')`
    required this.likeWidget,

    /// Optional custom width of each like widget. Default is `50`.
    this.widgetWidth,

    /// Optional custom height of each like widget. Default is `50`.
    this.widgetHeight,

    /// Controls the position of the like on the screen using [EdgeInsets].
    ///
    /// For example:
    /// ```dart
    /// EdgeInsets.only(bottom: 20, left: 20)
    /// ```
    /// If not provided, defaults to bottom: 20, right: 20.
    this.likePosition,

    /// The duration of the like widget's scale/fade animation.
    ///
    /// Default: `Duration(milliseconds: 1000)`.
    this.animationDuration,

    /// The duration for the like floating upward animation.
    ///
    /// Default: `Duration(milliseconds: 2400)`.
    this.translateDuration,

    /// The animation curve used for the floating animation.
    ///
    /// Default: `Curves.easeInOut`.
    this.curve,
  });

  /// Triggers likes from the parent widget.
  final FloatingLikesController controller;

  /// The visual widget displayed as a like (e.g. an image or custom icon).
  final Widget likeWidget;

  /// Width of the like widget. Default is 50.
  final double? widgetWidth;

  /// Height of the like widget. Default is 50.
  final double? widgetHeight;

  /// Position of the like widget using EdgeInsets (left, top, right, bottom).
  final EdgeInsets? likePosition;

  /// Duration for the appearance (scale/fade) animation.
  final Duration? animationDuration;

  /// Duration for the upward movement animation.
  final Duration? translateDuration;

  /// Curve for the translation animation.
  final Curve? curve;

  @override
  State<FloatingLikes> createState() => _FloatingLikesState();
}

class _FloatingLikesState extends State<FloatingLikes> {
  final List<_LikeItem> _shownLikes = [];
  int _likeIdCounter = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.attach(_addLike);
  }

  void _addLike() {
    final id = _likeIdCounter++;
    setState(() {
      _shownLikes.add(_LikeItem(id: id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:
          _shownLikes.map((like) {
            return Positioned(
              key: ValueKey(like),
              left: widget.likePosition?.left == 0.0 ? null : widget.likePosition?.left,
              top: widget.likePosition?.top == 0.0 ? null : widget.likePosition?.top,
              right: widget.likePosition?.right == 0.0 ?  null : widget.likePosition?.right ?? 20,
              bottom: widget.likePosition?.bottom == 0.0 ? null : widget.likePosition?.bottom ?? 20,
              child: _AnimatedTranslateWidget(
                curve: widget.curve ?? Curves.easeInOut,
                translateDuration: const Duration(milliseconds: 2400),
                onDispose: () {
                  setState(() {
                    _shownLikes.removeWhere((e) => e.id == like.id);
                  });
                },
                child: _LikeWidget(
                  height: widget.widgetHeight ?? 50,
                  width: widget.widgetWidth ?? 50,
                  animationDuration: const Duration(milliseconds: 1000),
                  child: widget.likeWidget,
                ),
              ),
            );
          }).toList(),
    );
  }
}

class _LikeItem {
  final int id;
  _LikeItem({required this.id});
}
