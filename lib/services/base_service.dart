import 'package:http/http.dart';

abstract class BaseServices {
  Future<Response> getJoke();
}
