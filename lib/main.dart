import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod_provider;
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/providers/providers.dart';
import 'ui/theme.dart';
import 'ui/views/views.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://nrryrgcadtcujlqmxytq.supabase.co',
    anonKey: 'sb_publishable_4MRahouxmAMGtM9FDPL29A_Jkx4H8R7',
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const riverpod_provider.ProviderScope(child: MyApp()));
  FlutterNativeSplash.remove();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends riverpod_provider.ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, riverpod_provider.WidgetRef ref) {
    ThemeMode themeMode = ref.watch(themeModeProvider);
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<AppProvider>(create: (_) => AppProvider()),
      ],
      child: MaterialApp(
        title: 'App Track',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        darkTheme: appDarkTheme,
        themeMode: themeMode,
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Provider.of<AppProvider>(context).isLoggedIn;
    return isLoggedIn ? const DashboardScreen() : const LoginScreen();
  }
}
