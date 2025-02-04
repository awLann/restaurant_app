import 'package:flutter/material.dart';
import 'package:restaurant_app/style/custom_text_styles.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: Colors.green,
      brightness: Brightness.light,
      textTheme: _textTheme,
      useMaterial3: true
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
        colorSchemeSeed: Colors.green,
        brightness: Brightness.dark,
        textTheme: _textTheme,
        useMaterial3: true
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: CustomTextStyles.displayLarge,
      displayMedium: CustomTextStyles.displayMedium,
      displaySmall: CustomTextStyles.displaySmall,
      headlineLarge: CustomTextStyles.headlineLarge,
      headlineMedium: CustomTextStyles.headlineMedium,
      headlineSmall: CustomTextStyles.headlineSmall,
      titleLarge: CustomTextStyles.titleLarge,
      titleMedium: CustomTextStyles.titleMedium,
      titleSmall: CustomTextStyles.titleSmall,
      bodyLarge: CustomTextStyles.bodyLargeBold,
      bodyMedium: CustomTextStyles.bodyLargeMedium,
      bodySmall: CustomTextStyles.bodyLargeRegular,
      labelLarge: CustomTextStyles.labelLarge,
      labelMedium: CustomTextStyles.labelMedium,
      labelSmall: CustomTextStyles.labelSmall,
    );
  }
}
