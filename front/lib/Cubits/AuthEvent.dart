part of 'AuthBloc.dart';

abstract class AuthEvent {
  User user;
  String errorText;
  AuthEvent(this.user, {this.errorText});
}

class LoggedIn extends AuthEvent {
  LoggedIn(User user) : super(user);

  @override
  // TODO: implement user
  User get user => super.user;
}

class LoggedOut extends AuthEvent {
  LoggedOut(User user) : super(user);
}

class SignUp extends AuthEvent {
  SignUp(User user) : super(user);
}

class Pending extends AuthEvent {
  Pending(User user) : super(user);
}

class Signin extends AuthEvent {
  Signin(User user) : super(user);
}

class Failure extends AuthEvent {
  Failure(User user, String errorText) : super(user, errorText: errorText);
}
