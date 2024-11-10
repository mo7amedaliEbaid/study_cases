import 'package:injectable/injectable.dart';

import 'package:http/http.dart' as http;

@module
abstract class RegisterModule {
  @lazySingleton
  http.Client get httpClient => http.Client();
}
