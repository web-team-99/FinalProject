part of 'UserBloc.dart';

abstract class UserState {
  User user;
  UserState(this.user);
}

class UserProjectsFetchedState extends UserState {
  UserProjectsFetchedState(User user) : super(user);
}

class UserAssignedProjectsFetchedState extends UserState {
  UserAssignedProjectsFetchedState(User user) : super(user);
}

class UserUnassignedProjectsFetchedState extends UserState {
  UserUnassignedProjectsFetchedState(User user) : super(user);
}

class UserAcceptedProjectsFetchedState extends UserState {
  UserAcceptedProjectsFetchedState(User user) : super(user);
}

class PendingUserDataFetch extends UserState {
  PendingUserDataFetch(User user) : super(user);
}

class FailureUSerDataFetch extends UserState {
  String error;
  FailureUSerDataFetch(User user) : super(user);
}
