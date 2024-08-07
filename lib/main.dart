import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_chart/logger_custom.dart';
import 'package:stock_chart/model/vietstock.dart';
import 'package:stock_chart/themes/light_mode.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set immersive system UI mode for Android (full screen)
    //- However it will make 2 times init app
    // --> can not fix this issue now
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    CustomLogger logger = CustomLogger();
    logger.error('MyApp Screen build');

    return MaterialApp(
        debugShowCheckedModeBanner: false, // turn off debug banner
        theme: lighMode,
        home: SafeArea(
          child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              body: const Center(
                child: HomePage(),
              )),
        ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    CustomLogger logger = CustomLogger();
    // Get Size of device
    double widthScreenDevice = MediaQuery.of(context).size.width;
    double heightScreenDevice = MediaQuery.of(context).size.height;
    if ((widthScreenDevice > 0) && (heightScreenDevice > 0)) {
      logger.debug(
          'HomePage: Width: $widthScreenDevice, Height: $heightScreenDevice');
    } else {
      logger.error(
          'HomePage: Width: $widthScreenDevice, Height: $heightScreenDevice');
    }
    if ((widthScreenDevice > 0) && (heightScreenDevice > 0)) {
      return const MyHomePage();
    } else {
      return const Center(child: Text('Loading......'));
    }
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(720, 1024),
      minTextAdapt: true,
      splitScreenMode: true,
      child: Center(
        child: Container(
          width: 720,
          height: 1024,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[200],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Recognizer Not Available',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  VietStock.getGiaoDichKhoiNgoai();
                },
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
