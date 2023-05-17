import 'package:simple_connection_checker/simple_connection_checker.dart';

Future<bool> checkConnection() async {
  bool connection = await SimpleConnectionChecker.isConnectedToInternet();
  return connection;
}
