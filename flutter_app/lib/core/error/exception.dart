import 'package:equatable/equatable.dart';

class ServerException implements Exception{
  
}
class CacheException extends Equatable implements Exception {
  final String message;

  const CacheException({required this.message});

  @override
  List<Object?> get props => [message];
}