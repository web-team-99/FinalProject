import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_url/models/user.dart';
import 'package:test_url/providers/AuthenticationAPI.dart';

part 'AuthState.dart';
part 'AuthEvent.dart';

enum AuthenticationEvents { logedin, logedout, signup, signin, pending, error }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthenticationAPI authenticationAPI = AuthenticationAPI();

  AuthBloc(AuthState initialState) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SignUp) {
      yield NewAuthState.fromOldAuthState(state,
          currentEvent: AuthenticationEvents.signup, user: event.user);
      print("Signup");
      this.add(Pending(event.user));
      authenticationAPI
          .sendSignUpRequest(event.user)
          .then((value) => {print(value), this.add(LoggedIn(event.user))})
          .onError((error, stackTrace) =>
              {this.add(Failure(event.user, error.toString()))});
    } else if (event is Signin) {
      yield NewAuthState.fromOldAuthState(state,
          user: event.user, currentEvent: AuthenticationEvents.signin);
      print("Signin");
    } else if (event is LoggedIn) {
      yield NewAuthState.fromOldAuthState(state,
          user: event.user, currentEvent: AuthenticationEvents.logedin);
      print("loggedin");
    } else if (event is LoggedOut) {
      print("loggedout");
    } else if (event is Pending) {
      yield NewAuthState.fromOldAuthState(state,
          user: event.user, currentEvent: AuthenticationEvents.pending);
      print("pending");
    } else if (event is Failure) {
      yield NewAuthState.fromOldAuthState(state,
          user: event.user,
          errorText: event.errorText,
          currentEvent: AuthenticationEvents.error);
      print("failure");
    }
  }
}
