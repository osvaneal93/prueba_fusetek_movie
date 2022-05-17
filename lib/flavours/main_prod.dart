import 'package:flutter/material.dart';
import 'package:prueba_omj/flavours/my_app.dart';

import 'app_config.dart';

void main() {
  const configuredApp = AppConfig(
    color: Colors.green,
    child: MyApp(),
    // 1
    environment: Environment.prod,
    // 2
    appTitle: 'PROD',
  );
  runApp(configuredApp);
}
