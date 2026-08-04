import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeBloc {
  // #region Configuration

  static const _sectionsCount = 5;
  static const _snapIdleDelay = Duration(milliseconds: 80);
  static const _snapDuration = Duration(seconds: 2);
  static const _snapCurve = Curves.easeOutCubic;
  static const _minimumScrollDelta = 0.5;
  static const _dragDevices = {
    PointerDeviceKind.mouse,
    PointerDeviceKind.touch,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
    PointerDeviceKind.invertedStylus,
  };

  Set<PointerDeviceKind> get dragDevices => _dragDevices;

  // #endregion

  // #region Controllers

  final scrollController = ScrollController();
  final focusNode = FocusNode();

  // #endregion

  // #region Internal state

  Timer? _snapTimer;
  var _isSnapping = false;
  var _isPointerSignalScrolling = false;
  var _isMouseDragging = false;
  var _mouseDragMoved = false;
  var _lastScrollDirection = 0;
  var _snapVersion = 0;
  int? _activeSnapPage;

  // #endregion

  // #region Lifecycle

  void dispose() {
    _snapTimer?.cancel();
    scrollController.dispose();
    focusNode.dispose();
  }

  // #endregion

  // #region Pointer input

  void handlePointerDown(PointerDownEvent event) {
    focusNode.requestFocus();

    if (!_isPrimaryMouseButton(event.kind, event.buttons)) return;

    _isPointerSignalScrolling = false;
    _isMouseDragging = true;
    _mouseDragMoved = false;
    _handleUserInteraction();
  }

  void handlePointerMove(PointerMoveEvent event) {
    if (!_isMouseDragging ||
        !_isPrimaryMouseButton(event.kind, event.buttons)) {
      return;
    }

    final delta = -event.delta.dy;

    if (delta.abs() < _minimumScrollDelta) return;

    _mouseDragMoved = true;
    _recordScrollDelta(delta);
  }

  void handlePointerUp(PointerEvent event) {
    if (!_isMouseDragging) return;

    _isMouseDragging = false;
    _isPointerSignalScrolling = false;

    if (_mouseDragMoved) _scheduleMouseDragSnap();

    _mouseDragMoved = false;
  }

  void handlePointerSignal(PointerSignalEvent event) {
    if (event is! PointerScrollEvent) return;

    _recordScrollDelta(event.scrollDelta.dy);
    _isPointerSignalScrolling = true;
    _handleUserInteraction();
    _scheduleSnap();
  }

  bool _isPrimaryMouseButton(PointerDeviceKind kind, int buttons) {
    return kind == PointerDeviceKind.mouse &&
        (buttons & kPrimaryMouseButton) != 0;
  }

  // #endregion

  // #region Keyboard input

  KeyEventResult handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }

    if (event.logicalKey == LogicalKeyboardKey.arrowDown ||
        event.logicalKey == LogicalKeyboardKey.pageDown) {
      _snapToAdjacentSection(1);

      return KeyEventResult.handled;
    }

    if (event.logicalKey == LogicalKeyboardKey.arrowUp ||
        event.logicalKey == LogicalKeyboardKey.pageUp) {
      _snapToAdjacentSection(-1);

      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  // #endregion

  // #region Scroll notifications

  bool handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollStartNotification &&
        notification.dragDetails != null) {
      _isPointerSignalScrolling = false;
      _handleUserInteraction();
    }

    if (notification is ScrollUpdateNotification && !_isSnapping) {
      _recordScrollDelta(notification.scrollDelta);
    }

    if (notification is ScrollEndNotification &&
        !_isSnapping &&
        !_isPointerSignalScrolling) {
      _snapToDirectedSection();
    }

    return false;
  }

  // #endregion

  // #region Snap orchestration

  void _handleUserInteraction() {
    _snapTimer?.cancel();
    _snapVersion++;

    if (!_isSnapping || !scrollController.hasClients) return;

    _isSnapping = false;
    _activeSnapPage = null;
    scrollController.jumpTo(scrollController.offset);
  }

  void _scheduleSnap() {
    if (_isSnapping) return;

    _snapTimer?.cancel();
    _snapTimer = Timer(_snapIdleDelay, () {
      _isPointerSignalScrolling = false;
      _snapToDirectedSection();
    });
  }

  void _scheduleMouseDragSnap() {
    _snapTimer?.cancel();
    _snapTimer = Timer(Duration.zero, _snapToDirectedSection);
  }

  void _snapToDirectedSection() {
    if (!_hasScrollableViewport || _isSnapping) return;

    _animateToSection(_sectionForDirection(_lastScrollDirection));
  }

  void _snapToAdjacentSection(int direction) {
    if (!_hasScrollableViewport) return;

    final activeSnapPage = _activeSnapPage;
    _isPointerSignalScrolling = false;
    _handleUserInteraction();

    final targetPage = activeSnapPage == null
        ? _sectionForDirection(direction)
        : _clampPage(activeSnapPage + direction);

    _animateToSection(targetPage);
  }

  void _animateToSection(int page) {
    final target = _targetForPage(page);

    if ((scrollController.offset - target).abs() < 1) return;

    _animateToSnapTarget(page, target);
  }

  Future<void> _animateToSnapTarget(int page, double target) async {
    final version = ++_snapVersion;
    _isSnapping = true;
    _activeSnapPage = page;

    await scrollController.animateTo(
      target,
      duration: _snapDuration,
      curve: _snapCurve,
    );

    if (version != _snapVersion) return;

    _isSnapping = false;
    _activeSnapPage = null;
    _lastScrollDirection = 0;
  }

  // #endregion

  // #region Scroll math

  bool get _hasScrollableViewport {
    return scrollController.hasClients &&
        scrollController.position.viewportDimension > 0;
  }

  int _sectionForDirection(int direction) {
    final rawPage =
        scrollController.offset / scrollController.position.viewportDimension;

    if (direction > 0) return _clampPage(rawPage.floor() + 1);

    if (direction < 0) return _clampPage(rawPage.ceil() - 1);

    return _clampPage(rawPage.round());
  }

  double _targetForPage(int page) {
    final position = scrollController.position;
    final target = page * position.viewportDimension;

    return target.clamp(0, position.maxScrollExtent).toDouble();
  }

  int _clampPage(num page) => page.clamp(0, _sectionsCount - 1).toInt();

  void _recordScrollDelta(double? delta) {
    if (delta == null || delta.abs() < _minimumScrollDelta) return;
    _lastScrollDirection = delta.isNegative ? -1 : 1;
  }

  // #endregion
}
