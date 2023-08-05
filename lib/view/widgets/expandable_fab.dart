import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:rse/all.dart';

@immutable
class ActionButton extends StatelessWidget {
  final Widget icon;

  final String title;
  final VoidCallback? onPressed;
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shape: const CircleBorder(),
      child: TextButton(
        onPressed: () {
          logEvent({'name': 'asset_trade_option_selected', 'option': title});
          onPressed!();
        },
        style: TextButton.styleFrom(
          shape: const CircleBorder(),
          minimumSize: const Size(56, 56),
          padding: const EdgeInsets.all(16),
        ),
        child: Text(title),
      ),
    );
  }
}

@immutable
class ExpandableFab extends StatefulWidget {
  final String sym;

  final double distance;
  final bool? initialOpen;
  final List<Widget> children;
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.sym,
    required this.distance,
    required this.children,
  });

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

@immutable
class FakeItem extends StatelessWidget {
  final bool isBig;

  const FakeItem({
    super.key,
    required this.isBig,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isBig ? 128 : 36,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
    );
  }
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomRight,
        children: [
          _buildTapToCloseFab(context),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(context),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      vsync: this,
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          progress: _expandAnimation,
          maxDistance: widget.distance,
          directionInDegrees: angleInDegrees,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToCloseFab(context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: Center(
        child: Material(
          elevation: 4,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.close,
                color: C(context, 'primary'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTapToOpenFab(context) {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 250),
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          child: FloatingActionButton(
            onPressed: _toggle,
            backgroundColor: C(context, 'surface'),
            child: Icon(Icons.create, color: C(context, 'primary')),
          ),
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        logEvent({'name': 'asset_trade_select', 'sym': widget.sym});
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  final Widget child;

  final double maxDistance;
  final Animation<double> progress;
  final double directionInDegrees;
  const _ExpandingActionButton({
    required this.child,
    required this.progress,
    required this.maxDistance,
    required this.directionInDegrees,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}
