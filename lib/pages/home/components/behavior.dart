import 'package:flutter/material.dart';

import '../home_bloc.dart';

class HomeBehavior extends StatelessWidget {
  const HomeBehavior({
    super.key,
    required this.bloc,
    required this.backgroundColor,
    required this.builder,
  });

  final HomeBloc bloc;
  final Color backgroundColor;
  final Widget Function(BuildContext context, double sectionHeight) builder;

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: bloc.focusNode,
      autofocus: true,
      onKeyEvent: bloc.handleKeyEvent,
      child: ColoredBox(
        color: backgroundColor,
        child: Listener(
          onPointerDown: bloc.handlePointerDown,
          onPointerMove: bloc.handlePointerMove,
          onPointerUp: bloc.handlePointerUp,
          onPointerCancel: bloc.handlePointerUp,
          onPointerSignal: bloc.handlePointerSignal,
          child: NotificationListener<ScrollNotification>(
            onNotification: bloc.handleScrollNotification,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ScrollConfiguration(
                  behavior: ScrollConfiguration.of(
                    context,
                  ).copyWith(dragDevices: bloc.dragDevices),
                  child: builder(context, constraints.maxHeight),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
