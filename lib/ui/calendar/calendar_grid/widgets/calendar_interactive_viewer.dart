import 'package:flutter/material.dart';

class CalendarInteractiveViewer extends StatefulWidget {
  const CalendarInteractiveViewer({
    super.key,
    required this.controller,
    required this.maxDragDistance,
    required this.onDragStart,
    required this.onDrag,
    required this.onDragEnd,
    required this.child,
  });

  final TransformationController controller;
  final double maxDragDistance;
  final void Function() onDragStart;
  final void Function(double dragDistance) onDrag;
  final void Function(double dragDistance) onDragEnd;
  final Widget child;

  @override
  State<CalendarInteractiveViewer> createState() =>
      _CalendarInteractiveViewerState();
}

class _CalendarInteractiveViewerState extends State<CalendarInteractiveViewer>
    with SingleTickerProviderStateMixin {
  Offset? _initialFocalPoint;
  double? _scale = 1;
  double _dragDistance = 0;

  late final AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_controllerListener);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _controllerListener() {
    _scale = widget.controller.value.getMaxScaleOnAxis();
  }

  bool get _isAtRestScale => ((_scale ?? 1) - 1).abs() < 0.001;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: widget.controller,
      onInteractionStart: (details) {
        _initialFocalPoint = details.focalPoint;
        _dragDistance = 0;
        widget.onDragStart();
      },
      onInteractionUpdate: (details) {
        if (_isAtRestScale && details.pointerCount == 1) {
          _dragDistance =
              details.focalPoint.dy -
              (_initialFocalPoint?.dy ?? details.focalPoint.dy);

          _dragDistance = _dragDistance.clamp(
            -widget.maxDragDistance,
            widget.maxDragDistance,
          );
          widget.onDrag(_dragDistance);
        }
      },
      onInteractionEnd: (details) {
        final dragDistance = _dragDistance;
        if (_isAtRestScale) {
          _animation = Tween<double>(begin: _dragDistance, end: 0).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeOut,
            ),
          )..addListener(() {
            _dragDistance = _animation.value;
            widget.onDrag(_animation.value);
          });
          _animationController.forward(from: 0);
        }
        widget.onDragEnd(dragDistance);
      },
      minScale: 1,
      maxScale: 5,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_controllerListener);
    _animationController.dispose();
    super.dispose();
  }
}
