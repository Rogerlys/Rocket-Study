import 'dart:math';

class InspirationalQuotes {
  static Map<int, String> quotes = {
    0 : 'The way to get started is to quit talking and begin doing',
    1 : 'The pessimist sees difficulty in every opportunity. The optimist sees the opportunity in every difficulty',
    2 : 'Dont let yesterday take up much of today',
    3 : 'Make your life a masterpiece\nImagine no limitation on what you can be, have or do',
    4 : 'You learn more from failure than success.\nDont let it stop you.\nFailure builds character',
    5 : 'Your limitation — it is only your imagination.',
    6 : 'Push yourself, because no one else is going to do it for you',
    7 : 'Sometimes later becomes never',
    8 : 'The harder you work for something, the greater you will feel when you achieve it',
    9 : 'Great things never come from comfort zones'
  };

  static String get uniqueQuote {
    return quotes[Random().nextInt(10)];
  }
}