// Login Exceptions
class InvalidUserCredentialAuthException implements Exception {}

class UserNotFoundAuthException implements Exception {}

// Register Exceptions
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

// Generic Exceptions
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}

class SignOutFailedAuthException implements Exception {}
