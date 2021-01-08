import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';

// пути к API
const kApiUrl = 'http://s.samopay.ru';
const kApiAuthUrl = 'http://s.samopay.ru/auth/jwt/create';

// Основные цвета
const Color kPrimeryColor = Color(0xFFF6F6F6);
const Color kPrimeryVariant = Color(0xFF253237);

const Color kAccentColor = Color(0xFF4FB68D);
Color kAccentSecond = kAccentColor.withOpacity(0.3);
const Brightness kBrightness = Brightness.light;
const kFontFamily = 'Open Sans';

const String kDefaultFontFamily = 'Roboto-Light.ttf';
const double kDefaultFontSize = 14;
const double kDefaultIconSize = 17;
