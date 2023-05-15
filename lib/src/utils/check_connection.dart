import 'package:simple_connection_checker/simple_connection_checker.dart';

Future<bool> checkConnection() async {
  bool connected = await SimpleConnectionChecker.isConnectedToInternet();
  return connected;
}
