import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SectionNavigator extends StatefulWidget {
  const SectionNavigator({
    super.key,
    required this.children,
    this.snapIdleDelay = const Duration(milliseconds: 120),
    this.snapDuration = const Duration(milliseconds: 360),
    this.snapCurve = Curves.easeOutCubic,
    this.physics,
  });

  final List<Widget> children;
  final Duration snapIdleDelay;
  final Duration snapDuration;
  final Curve snapCurve;
  final ScrollPhysics? physics;

  @override
  State<SectionNavigator> createState() => _SectionNavigatorState();
}

class _SectionNavigatorState extends State<SectionNavigator> {
  final _scrollController = ScrollController();
  final _focusNode = FocusNode(debugLabel: 'SectionNavigator');

  Timer? _snapTimer;
  var _isSnapping = false;
  var _snapVersion = 0;
  int? _activeSnapPage;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _snapTimer?.cancel();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (_) => _handleUserInput(),
        onPointerSignal: _handlePointerSignal,
        child: ScrollConfiguration(
          behavior: const _SectionNavigatorScrollBehavior(),
          child: NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: ListView(
              controller: _scrollController,
              padding: EdgeInsets.zero,
              physics: widget.physics ?? const ClampingScrollPhysics(),
              children: widget.children,
            ),
          ),
        ),
      ),
    );
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }

    final key = event.logicalKey;

    if (key == LogicalKeyboardKey.arrowDown ||
        key == LogicalKeyboardKey.pageDown) {
      _snapToAdjacentPage(1);

      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowUp || key == LogicalKeyboardKey.pageUp) {
      _snapToAdjacentPage(-1);

      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.space) {
      final direction = HardwareKeyboard.instance.isShiftPressed ? -1 : 1;
      _snapToAdjacentPage(direction);

      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.home) {
      _snapToPage(0);

      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.end) {
      _snapToPage(widget.children.length - 1);

      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth != 0 || notification.metrics.axis != Axis.vertical) {
      return false;
    }

    if (notification is ScrollStartNotification && !_isSnapping) {
      _snapTimer?.cancel();
    }

    if (notification is ScrollUpdateNotification && !_isSnapping) {
      _scheduleSnap();
    }

    if (notification is ScrollEndNotification && !_isSnapping) _scheduleSnap();

    return false;
  }

  void _handlePointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      _handleUserInput();
      _scheduleSnap();
    }
  }

  void _handleUserInput() {
    _focusNode.requestFocus();
    _cancelSnap(stopAnimation: true);
  }

  void _cancelSnap({bool stopAnimation = false}) {
    _snapTimer?.cancel();
    _snapTimer = null;
    _snapVersion++;
    _activeSnapPage = null;

    if (!_isSnapping) return;

    _isSnapping = false;

    if (!stopAnimation || !_scrollController.hasClients) return;

    final position = _scrollController.position;
    final offset = _scrollController.offset
        .clamp(position.minScrollExtent, position.maxScrollExtent)
        .toDouble();

    _scrollController.jumpTo(offset);
  }

  void _scheduleSnap([Duration? delay]) {
    if (_isSnapping) return;

    _snapTimer?.cancel();
    _snapTimer = Timer(delay ?? widget.snapIdleDelay, _snapToNearestPage);
  }

  void _snapToNearestPage() {
    if (!_hasScrollableViewport || _isSnapping || widget.children.isEmpty) {
      return;
    }

    _snapToPage(_nearestPage);
  }

  void _snapToAdjacentPage(int direction) {
    if (!_hasScrollableViewport || widget.children.isEmpty) return;

    final activeSnapPage = _activeSnapPage;
    final targetPage = activeSnapPage == null
        ? _pageInDirection(direction)
        : _clampPage(activeSnapPage + direction);

    _snapToPage(targetPage);
  }

  void _snapToPage(int page) {
    if (!_hasScrollableViewport || widget.children.isEmpty) return;

    _snapTimer?.cancel();

    final targetPage = _clampPage(page);
    final target = _targetForPage(targetPage);

    if ((_scrollController.offset - target).abs() < 1) {
      _isSnapping = false;
      _activeSnapPage = null;

      return;
    }

    unawaited(_animateToPage(targetPage, target));
  }

  Future<void> _animateToPage(int page, double target) async {
    final version = ++_snapVersion;
    _isSnapping = true;
    _activeSnapPage = page;

    await _scrollController.animateTo(
      target,
      duration: widget.snapDuration,
      curve: widget.snapCurve,
    );

    if (!mounted || version != _snapVersion) return;

    _isSnapping = false;
    _activeSnapPage = null;
  }

  bool get _hasScrollableViewport {
    return _scrollController.hasClients &&
        _scrollController.position.viewportDimension > 0;
  }

  int get _nearestPage {
    final page =
        _scrollController.offset / _scrollController.position.viewportDimension;

    return _clampPage(page.round());
  }

  int _pageInDirection(int direction) {
    final page =
        _scrollController.offset / _scrollController.position.viewportDimension;

    if (direction > 0) return _clampPage(page.floor() + 1);
    if (direction < 0) return _clampPage(page.ceil() - 1);

    return _nearestPage;
  }

  double _targetForPage(int page) {
    final position = _scrollController.position;
    final target = page * position.viewportDimension;

    return target
        .clamp(position.minScrollExtent, position.maxScrollExtent)
        .toDouble();
  }

  int _clampPage(num page) {
    return page.clamp(0, widget.children.length - 1).toInt();
  }
}

class _SectionNavigatorScrollBehavior extends MaterialScrollBehavior {
  const _SectionNavigatorScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices {
    return {
      ...super.dragDevices,
      PointerDeviceKind.mouse,
      PointerDeviceKind.trackpad,
      PointerDeviceKind.stylus,
      PointerDeviceKind.invertedStylus,
    };
  }
}
