import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef ScrollTrackerCallback = void Function(
    int scrollPercent, String typeOfScroll);

mixin TrackingScroll {
  ScrollController? _scrollController;
  Axis? _scrollDirection;
  ScrollTrackerCallback? _onScrolled;

  void initiateTracking(
    ScrollController scrollController,
    Axis scrollDirection,
    ScrollTrackerCallback? onScrolled,
  ) {
    _scrollController = scrollController;
    _scrollDirection = scrollDirection;
    _onScrolled = onScrolled;

    _scrollController?.position.isScrollingNotifier
        .addListener(_scrollChangeListener);
  }

  void _scrollChangeListener() {
    if (_scrollController == null) return;
    final scrollController = _scrollController!;
    if (!scrollController.position.isScrollingNotifier.value) {
      final percent = scrollController.position.pixels *
          100 ~/
          scrollController.position.maxScrollExtent;
      var typeOfScroll = '';
      if (_scrollDirection == Axis.horizontal) {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          typeOfScroll = 'sroll left';
        } else if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          typeOfScroll = 'sroll right';
        }
      } else {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          typeOfScroll = 'sroll up';
        } else if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          typeOfScroll = 'sroll down';
        }
      }
      _onScrolled?.call(percent, typeOfScroll);
    }
  }
}
