class AppConfig {
  AppConfig._();

  static const String appVersion = '1.0';
  static const String defaultFontFamily = 'Andina';

  static const  appName = 'PayTrack';
  // static const String baseUrl = 'http://127.0.0.1:8000/api';

  // static const String appHost = '192.168.7.177';
  static const String appHost = '127.0.0.1';
  // static const String appHost = 'trips.titotogo.com';
  static const String appUrl = 'http://$appHost:8000';

  // static const String appUrl = 'http://trips.titotogo.com/';
  static const String apiUrl = '$appUrl/api';

  // static const String websocketsKey = '6szwdoflgvb1lctggpib';
  // static const String websocketsScheme = 'ws';
  // static const int websocketsPort = 8080;


  static const String sdPath = '/storage/emulated/0/paytrack';
  static const String discImagePath = '$sdPath/images';
  static const String discVideoPath = '$sdPath/videos';
  static const String discAudioPath = '$sdPath/audio';

  static const String mapsApiKey = '-- IGNORE --';
  // static const String mapsApiKey = '-- IGNORE --';
}



 
//  static const String  supabaseUrl = '';
//  static const String supabaseAnonKey= ''.EtMAy2S7GH-k1WGKCszByvHMpZrik2f8aEU4pV71jak';
  