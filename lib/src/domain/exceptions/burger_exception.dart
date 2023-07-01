sealed class BurgerException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const BurgerException(this.message, [this.stackTrace]);

  @override
  String toString() {
    return "$runtimeType: $message${stackTrace == null ? '' : '\n$stackTrace'}";
  }
}

class BurgerServiceException extends BurgerException {
  const BurgerServiceException(super.message, [super.stackTrace]);
}
