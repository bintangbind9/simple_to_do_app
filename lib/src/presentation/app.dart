import 'package:flutter/material.dart';

import '../common/constants/app_styles.dart';
import 'pages/initial_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        title: 'Simple Todo App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppStyles.primaryColor,
            brightness: Brightness.light,
          ),
          cardTheme: CardTheme(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        home: const InitialPage(),
      ),
    );
  }
}
