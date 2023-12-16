import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mpstailor/provider/theme_provider.dart';
import 'package:mpstailor/views/home_screen.dart';
import 'package:provider/provider.dart';
import 'models/customer.dart';
import 'theme/color_schemes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //register
  Hive.registerAdapter(CustomerAdapter());
  //open
  await Hive.openBox<Customer>('customers');

  await Future.delayed(Duration(seconds: 1));
  FlutterNativeSplash.remove();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MPS Tailor',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      themeMode: Provider.of<ThemeProvider>(context).darkTheme
          ? ThemeMode.dark
          : ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}
