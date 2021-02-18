part of 'UserBloc.dart';

abstract class UserEvent {
  User user;
  UserEvent(this.user);
}

class GetUserProjects extends UserEvent {
  GetUserProjects(User user) : super(user);
}

class GetUserAssignedProjects extends UserEvent {
  GetUserAssignedProjects(User user) : super(user);
}

class GetUserUnassignedProjects extends UserEvent {
  GetUserUnassignedProjects(User user) : super(user);
}

class GetUserAcceptedProjects extends UserEvent {
  GetUserAcceptedProjects(User user) : super(user);
}
