import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_trace_app/core/constants/app_assets.dart';
import 'package:work_trace_app/core/theme/app_theme.dart';
import 'package:work_trace_app/core/theme/theme_cubit.dart';
import 'package:work_trace_app/injection/injection.dart';
import 'package:work_trace_app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await configureInjection();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: AppAssets.translationsFolder,
      fallbackLocale: const Locale('en'),
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (_) => getIt<ThemeCubit>())],
        child: const WorkTraceApp(),
      ),
    ),
  );
}

class WorkTraceApp extends StatelessWidget {
  const WorkTraceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDark) {
        return MaterialApp.router(
          title: 'WorkTrace',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          routerConfig: appRouter,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          builder: (context, child) {
            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              behavior: HitTestBehavior.translucent,
              child: child,
            );
          },
        );
      },
    );
  }
}
