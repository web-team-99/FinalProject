
part of "AuthBloc.dart";

class AuthState {
  User user;
  AuthenticationEvents currentEvent;
  
    AuthState({this.user, this.currentEvent});
  }


class InitialAuthState extends AuthState {
  InitialAuthState() : super(currentEvent: AuthenticationEvents.logedout);
}

class NewAuthState extends AuthState {
  NewAuthState.fromOldAuthState(AuthState oldAuthState,
      {User user, AuthenticationEvents currentEvent})
      : super(
          user: user ?? oldAuthState.user,
          currentEvent: currentEvent ?? oldAuthState.currentEvent,
        );
}
