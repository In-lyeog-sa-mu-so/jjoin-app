import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jjoin/screen/club_application_screen.dart';
import 'package:jjoin/screen/calendar_screen.dart';
import 'package:jjoin/screen/club_screen.dart';
import 'package:jjoin/screen/home_screen.dart';
import 'package:jjoin/screen/profile_screen.dart';
import 'package:jjoin/screen/root_screen.dart';
import 'package:jjoin/screen/search_club_screen.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Remove splash
    FlutterNativeSplash.remove();

    return GetMaterialApp(
      title: "JJoin",
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFf6f6f8),
      ),
      initialRoute: "/",
      getPages: [
        GetPage(
          name: '/',
          page: () => const RootScreen(),
        ),
        GetPage(
          name: '/clubs',
          // 신청 및 검색 화면
          page: () => const ClubScreen(),
          children: [
            GetPage(
              name: '/clubs/application',
              page: () => const ClubApplicationScreen(),
            ),
          ],
        ),
      ],
    );
  }
}
