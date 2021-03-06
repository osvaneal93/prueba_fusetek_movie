
import 'package:flutter/material.dart';
import 'package:prueba_omj/flavours/app_config.dart';

import 'package:prueba_omj/src/ui/views/description_view.dart';
import 'package:prueba_omj/src/ui/views/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppConfig.of(context).color,
        
      ),
      
      themeMode: ThemeMode.dark, 
      routes: {
        "home/": (context) => const HomeView(),
        "description/":(context) =>  DescriptionView()
      },
      initialRoute: "home/",
    );
  }
}