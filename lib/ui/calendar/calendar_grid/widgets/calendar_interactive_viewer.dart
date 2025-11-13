import 'package:flutter/material.dart';

class CalendarInteractiveViewer extends StatefulWidget {
  const CalendarInteractiveViewer({
    super.key,
    required this.onDragStart,
    required this.onDrag,
    required this.onDragEnd,
    required this.child,
  });

  final void Function() onDragStart;
  final void Function(double dragDistance) onDrag;
  final void Function() onDragEnd;
  final Widget child;

  @override
  State<CalendarInteractiveViewer> createState() =>
      _CalendarInteractiveViewerState();
}

class _CalendarInteractiveViewerState extends State<CalendarInteractiveViewer>
    with SingleTickerProviderStateMixin {
  final _controller = TransformationController();
  Offset? _initialFocalPoint;
  double? _scale = 1;
  double _dragDistance = 0;

  late final AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_controllerListener);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _controllerListener() {
    _scale = _controller.value.getMaxScaleOnAxis();
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: _controller,
      onInteractionStart: (details) {
        _initialFocalPoint = details.focalPoint;
        widget.onDragStart();
      },
      onInteractionUpdate: (details) {
        if (_scale == 1.0 && details.pointerCount == 1) {
          _dragDistance =
              details.focalPoint.dy -
              (_initialFocalPoint?.dy ?? details.focalPoint.dy);

          _dragDistance = _dragDistance.clamp(0, 150);
          widget.onDrag(_dragDistance);
        }
      },
      onInteractionEnd: (details) {
        if (_scale == 1) {
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
        widget.onDragEnd();
      },
      minScale: 1,
      maxScale: 5,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
