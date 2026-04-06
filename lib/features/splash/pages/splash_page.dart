import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:work_trace_app/core/constants/app_assets.dart';
import 'package:work_trace_app/core/widgets/common_image_view.dart';
import 'package:work_trace_app/routes/route_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../injection/injection.dart';
import '../../../core/widgets/common_text.dart';
import '../cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SplashCubit>()..init(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToOnboarding) {
            context.go(RouteConstants.onboarding);
          } else if (state is SplashNavigateToLogin) {
            context.go(RouteConstants.login);
          } else if (state is SplashNavigateToHome) {
            context.go(RouteConstants.home);
          }
        },
        child: const _SplashView(),
      ),
    );
  }
}

class _SplashView extends StatefulWidget {
  const _SplashView();

  @override
  State<_SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<_SplashView>
    with TickerProviderStateMixin {
  // ── Animation controllers ──────────────────────────────────────────────────
  late final AnimationController _logoController;
  late final AnimationController _textController;
  late final AnimationController _pulseController;
  late final AnimationController _dotsController;

  // ── Animations ─────────────────────────────────────────────────────────────
  late final Animation<double> _logoFade;
  late final Animation<Offset> _logoSlide;
  late final Animation<double> _textFade;
  late final Animation<Offset> _textSlide;
  late final Animation<double> _pulseScale;
  late final Animation<double> _pulseOpacity;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startAnimationSequence();
  }

  void _initAnimations() {
    // Logo: fades + slides up
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _logoFade = CurvedAnimation(parent: _logoController, curve: Curves.easeOut);
    _logoSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeOut));

    // Text: fades in slightly after logo
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _textFade = CurvedAnimation(parent: _textController, curve: Curves.easeOut);
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    // Pulse ring: continuous breathe effect
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _pulseScale = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseOpacity = Tween<double>(begin: 0.15, end: 0.45).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Loading dots
    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  Future<void> _startAnimationSequence() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 350));
    _textController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _pulseController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // ── Background grid ────────────────────────────────────────────────
          _GridBackground(
            color: theme.colorScheme.primary.withValues(alpha: 0.05),
          ),

          // ── Main content ───────────────────────────────────────────────────
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Pulse rings + logo icon
                _PulseRings(
                  scaleAnimation: _pulseScale,
                  opacityAnimation: _pulseOpacity,
                  child: _LogoIcon(
                    fadeAnimation: _logoFade,
                    slideAnimation: _logoSlide,
                  ),
                ),
                const SizedBox(height: 28),

                // App name + tagline
                _AppName(fadeAnimation: _textFade, slideAnimation: _textSlide),
                const SizedBox(height: 48),

                // Loading indicator
                _LoadingDots(controller: _dotsController),
              ],
            ),
          ),

          // ── Version tag ────────────────────────────────────────────────────
          const Positioned(bottom: 32, left: 0, right: 0, child: _VersionTag()),
        ],
      ),
    );
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _GridBackground extends StatelessWidget {
  final Color color;
  const _GridBackground({required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: _GridPainter(color: color),
    );
  }
}

class _GridPainter extends CustomPainter {
  final Color color;
  _GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    const spacing = 60.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PulseRings extends StatelessWidget {
  final Animation<double> scaleAnimation;
  final Animation<double> opacityAnimation;
  final Widget child;

  const _PulseRings({
    required this.scaleAnimation,
    required this.opacityAnimation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: scaleAnimation,
      builder: (context, _) {
        return SizedBox(
          width: 160,
          height: 160,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer ring
              Transform.scale(
                scale: scaleAnimation.value * 1.1,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(
                        alpha: opacityAnimation.value * 0.5,
                      ),
                      width: 1,
                    ),
                  ),
                ),
              ),
              // Inner ring
              Transform.scale(
                scale: scaleAnimation.value,
                child: Container(
                  width: 118,
                  height: 118,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(
                        alpha: opacityAnimation.value,
                      ),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              // Logo icon centered
              child,
            ],
          ),
        );
      },
    );
  }
}

class _LogoIcon extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;

  const _LogoIcon({required this.fadeAnimation, required this.slideAnimation});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                offset: Offset(0, 1),
                blurRadius: 20,
              ),
            ],
          ),
          child: CommonImageView(
            imagePath: AppAssets.appLogo,
            width: 80,
            height: 80,
          ),
        ),
      ),
    );
  }
}

class _AppName extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;

  const _AppName({required this.fadeAnimation, required this.slideAnimation});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Column(
          children: [
            // "Work" + "Trace" — two-tone name
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Work',
                    style: AppTextStyles.splashAppName.copyWith(
                      color: theme.textTheme.displayLarge?.color,
                    ),
                  ),
                  TextSpan(
                    text: 'Trace',
                    style: AppTextStyles.splashAppName.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Tagline
            CommonText(
              'TRACK YOUR WORKDAY',
              style: AppTextStyles.splashTagline.copyWith(
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingDots extends StatelessWidget {
  final AnimationController controller;

  const _LoadingDots({required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            final double opacity = ((controller.value * 3 - index) % 3).clamp(
              0.2,
              1.0,
            );
            return Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: opacity),
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      },
    );
  }
}

class _VersionTag extends StatelessWidget {
  const _VersionTag();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.2),
            width: 0.8,
          ),
        ),
        child: CommonText(
          'V 1.0.0',
          style: AppTextStyles.labelSmall.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontSize: 9,
          ),
        ),
      ),
    );
  }
}
