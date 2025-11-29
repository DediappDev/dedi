import 'package:equatable/equatable.dart';

class DediLookupChunkException with EquatableMixin implements Exception {
  final String? message;

  DediLookupChunkException(this.message);

  @override
  List<Object?> get props => [message];
}
