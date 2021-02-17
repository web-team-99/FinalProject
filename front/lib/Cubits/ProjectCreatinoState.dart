part of 'ProjectCreationBloc.dart';

abstract class ProjectCreationState {
  ProjectModel project;
  ProjectCreationState({this.project});
}

class ProjectCreationInitialState extends ProjectCreationState {
}

class NewProjectCreationState extends ProjectCreationState {
  NewProjectCreationState.fromOldState(ProjectCreationState oldState,
      {ProjectModel projectModel})
      : super(project: projectModel ?? oldState.project);
}

class CreateProjectPendingState extends ProjectCreationState {}

class CreateProjectSuccessfulState extends ProjectCreationState {
  CreateProjectSuccessfulState(ProjectModel projectModel)
      : super(project: projectModel);
}

class CreateProjectFailedState extends ProjectCreationState {
  String error;

  CreateProjectFailedState(String error, {ProjectModel projectModel})
      : super(project: projectModel);
}
