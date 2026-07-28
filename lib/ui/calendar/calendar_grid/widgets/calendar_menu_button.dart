import 'package:flutter/material.dart';

/// A floating burger button that opens the calendar drawer without an AppBar,
/// keeping the maximum screen area free for the calendar grid.
///
/// The glass look is built from layered gradients only — a tint sheen, a
/// specular pool and a light-catching rim. There is deliberately no
/// [BackdropFilter]: a real backdrop blur costs a saveLayer plus a backdrop
/// read on every frame, which janks over the calendar. Re-add it only if a
/// genuinely frosted look is wanted, and measure in profile mode.
class CalendarMenuButton extends StatelessWidget {
  const CalendarMenuButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  // Glass knobs — tune these to taste.
  static const _fillAlpha = 0.5; // tint opacity (top of the sheen)
  static const _iconAlpha = 0.55; // icon opacity; lower = more "glassy"
  static const _rimAlpha = 0.7; // specular edge brightness

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.of(context);

    return DecoratedBox(
      // Circle-shaped decorations clip their own gradient, so no ClipOval
      // layer is needed.
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colors.surface.withValues(alpha: _fillAlpha),
            colors.surface.withValues(alpha: _fillAlpha * 0.4),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.18),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DecoratedBox(
        // Specular pooling of light near the top-left.
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            center: Alignment(-0.4, -0.6),
            colors: [Color(0x40FFFFFF), Color(0x00FFFFFF)],
          ),
        ),
        child: CustomPaint(
          foregroundPainter: _GlassRimPainter(
            highlight: Colors.white.withValues(alpha: _rimAlpha),
            shadow: Colors.black.withValues(alpha: 0.15),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.menu,
                  color: colors.onSurface.withValues(alpha: _iconAlpha),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Strokes a hairline ring whose brightness sweeps from a specular highlight on
/// the top-left to a soft shadow on the bottom-right — the glassy bevel edge.
class _GlassRimPainter extends CustomPainter {
  const _GlassRimPainter({required this.highlight, required this.shadow});

  final Color highlight;
  final Color shadow;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    const strokeWidth = 1.5;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [highlight, const Color(0x00FFFFFF), shadow],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(rect);

    canvas.drawCircle(rect.center, size.width / 2 - strokeWidth / 2, paint);
  }

  @override
  bool shouldRepaint(covariant _GlassRimPainter oldDelegate) =>
      oldDelegate.highlight != highlight || oldDelegate.shadow != shadow;
}
