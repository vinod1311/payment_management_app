
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment_management_app/controllers/payment/payment_controller.dart';
import 'package:payment_management_app/controllers/theme/theme_controller.dart';
import 'package:payment_management_app/database/payment_database.dart';
import 'package:payment_management_app/screens/splash_screen.dart';
import 'package:payment_management_app/utils/shared_preferences_helper.dart';
import 'package:payment_management_app/utils/theme_data_style.dart';
import 'package:provider/provider.dart';


void main() async{

  ///------ widget binding
  WidgetsFlutterBinding.ensureInitialized();

  ///------- shared pref init
  await SharedPreferencesHelper.init();

  ///------- payment database init
  final paymentDatabase = PaymentDatabase();
  await paymentDatabase.initializeDatabase();

  ///------- theme mode init
  final themeController = ThemeController();
  await themeController.initTheme();

  ///------- device orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);


  runApp(

    ///---------- list of all provider
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeController),
        ChangeNotifierProvider(create: (_) => PaymentController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ThemeController themeController = ThemeController();
  @override
  Widget build(BuildContext context) {
    ///------controller
    themeController =  Provider.of<ThemeController>(context);

    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'PAYMENT APP',
        debugShowCheckedModeBanner: false,
        theme: ThemeDataStyle.light,
        darkTheme: ThemeDataStyle.dark,
        themeMode: themeController.isDarkMode
            ? ThemeMode.dark
            : ThemeMode.light,
        home: const SplashScreen(),
      ),
    );
  }
}
