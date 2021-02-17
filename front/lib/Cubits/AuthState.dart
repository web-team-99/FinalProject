part of "AuthBloc.dart";

class AuthState {
  User user;
  String errorText;
  AuthenticationEvents currentEvent;

  AuthState({this.user, this.errorText, this.currentEvent});
}

class InitialAuthState extends AuthState {
  InitialAuthState() : super(currentEvent: AuthenticationEvents.logedout);
}

class NewAuthState extends AuthState {
  NewAuthState.fromOldAuthState(AuthState oldAuthState,
      {User user, String errorText, AuthenticationEvents currentEvent})
      : super(
          user: user ?? oldAuthState.user,
          errorText: errorText ?? oldAuthState.errorText,
          currentEvent: currentEvent ?? oldAuthState.currentEvent,
        );
}
