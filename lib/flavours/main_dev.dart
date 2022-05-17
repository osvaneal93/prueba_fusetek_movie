import 'package:flutter/material.dart';
import 'package:prueba_omj/flavours/my_app.dart';

import 'app_config.dart';

void main() {
  // 1
  const configuredApp = AppConfig(color: Colors.amber,
    child:MyApp(),
    // 2
    environment: Environment.dev,
    // 3
    appTitle: '[DEV]',
  );
  // 4
  runApp(configuredApp);
}