import 'package:flutter/material.dart';
import 'layout/home_layout.dart';
import 'shared/compontents/imports.dart';
bool get isRunningOnSimulator {
  final platform = Platform.isAndroid ? 'android' : 'iOS';
  final script = Platform.script;
  final isRunningOnSimulator = script.scheme == 'file' &&
      script.pathSegments.contains('flutter_tools') &&
      script.pathSegments.contains('simulator') &&
      script.pathSegments.contains(platform);
  return isRunningOnSimulator;
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    bool jailbroken = await FlutterJailbreakDetection.jailbroken;
    bool developerMode = await FlutterJailbreakDetection.developerMode;
    final deviceInfoPlugin = DeviceInfoPlugin();
    // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    final deviceInfo = await deviceInfoPlugin.androidInfo;
    Future<void>.delayed(const Duration(seconds: 3), () {
      if (deviceInfo.isPhysicalDevice == false) {
        exit(0);
      }
    });
  }
  Bloc.observer = SimpleBlocObserverr();
  Bloc.observer = MyBlocObserver();
  AppCubit();
  if (isRunningOnSimulator) {
    exit(0);
  }
  //CacheHelper.init();
  var shared = await SharedPreferences.getInstance();
  String? token;
  if (shared.containsKey('token')) {
    token = shared.getString('token');
  }
  String route;
  Widget widget;

  if (token != null) {
    widget = HomeLayout();
    route = '/';
  } else {
    widget = LoginScreen();
    route = 'login';
  }
  runApp(MyApp(
    startWidget: widget,
    Initroute: route,
    developerMode: false,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  final Initroute;
  bool? developerMode;

  MyApp({
    this.startWidget,
    this.Initroute,
    this.developerMode,
  });

  @override
  Widget build(BuildContext ctx) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()..toggleMode(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          Size size = WidgetsBinding.instance.window.physicalSize;
          double ratio = WidgetsBinding.instance.window.devicePixelRatio;
          double width = size.width / ratio;
          if (width > 600) {
            font_size = 16.0;
            main_size = 20.0;
            headline_size = 15;
            price_size = 9.0;
            title_course_size = 21.0;
          } else {
            font_size = 13.0;
            main_size = 15.0;
            headline_size = 13.0;
            price_size = 10.0;
            title_course_size = 18.0;
          }
          return MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: HomeLayout(),
          );
        },
      ),
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
