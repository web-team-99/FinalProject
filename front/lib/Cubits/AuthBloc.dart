import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_url/models/user.dart';

enum AuthEvent { login, logout, signup }

class AuthState {
  User user;
  AuthEvent event;

  AuthState({@required this.user, this.event});
}

class AuthBloc extends Bloc<AuthState, String> {
  AuthBloc(String initialState) : super(initialState);

  @override
  Stream<String> mapEventToState(AuthState state) async* {
    switch (state.event) {
      case AuthEvent.signup:
        yield signupUser(state.user);
        print("Signup state");
        break;
      case AuthEvent.login:
        yield loginUser(state.user);
        print("Login state");
        break;
      case AuthEvent.logout:
        yield logoutUser(state.user);
        print("Logout state");
        break;
    }
  }

  dynamic signupUser(User user) {
    //request to server for signup
    
    print('signing up the user');
    
  }

  dynamic loginUser(User user) {
    print('login up the user');
  }

  dynamic logoutUser(User user) {
    print('logout the user');
  }
}
