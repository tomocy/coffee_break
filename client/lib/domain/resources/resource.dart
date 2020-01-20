class ResourceException implements Exception {
  const ResourceException([this.message]);

  final String message;

  @override
  String toString() => message.isNotEmpty ? message : super.toString();
}
