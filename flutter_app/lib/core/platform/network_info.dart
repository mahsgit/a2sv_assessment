import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo{
  Future<bool> get isconnected;
  
}
class NetworkInfoImpl implements NetworkInfo{
  final InternetConnectionChecker connectionChecker;
  NetworkInfoImpl(this.connectionChecker);


  @override
  Future<bool> get isconnected => connectionChecker.hasConnection;
  }