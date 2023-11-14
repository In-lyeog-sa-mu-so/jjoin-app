import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jjoin/screen/application/club_application_screen.dart';
import 'package:jjoin/screen/club/club_notice_screen.dart';
import 'package:jjoin/screen/club/club_plan_screen.dart';
import 'package:jjoin/screen/club/club_screen.dart';
import 'package:jjoin/screen/root_screen.dart';

void main() {
  initializeDateFormatting()
      .then((_) => dotenv.load(fileName: 'assets/config/.env'))
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Remove splash
    FlutterNativeSplash.remove();

    // 상태바 투명화
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // 투명색
      statusBarIconBrightness: Brightness.dark, // 아이콘 색
    ));

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
              name: '/application',
              page: () => const ClubApplicationScreen(),
            ),
            GetPage(
              name: '/plan',
              page: () => const ClubPlanScreen(),
            ),
            GetPage(
              name: '/notices',
              page: () => const ClubNoticeScreen(),
            )
          ],
        ),
      ],
    );
  }
}
