abstract class AuthEvent {}

class AuthInitialEvent extends AuthEvent {}

class AuthRegisterEvent extends AuthEvent {
  AuthRegisterEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;
}

class AuthLoginEvent extends AuthEvent {
  AuthLoginEvent({required this.email, required this.password});

  final String email;
  final String password;
}
