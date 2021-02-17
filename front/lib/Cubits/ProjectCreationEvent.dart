part of 'ProjectCreationBloc.dart';

abstract class ProjectCreationEvent {
  ProjectModel projectModel;

  ProjectCreationEvent({this.projectModel});
}

class CreateProjectEvent extends ProjectCreationEvent {
  CreateProjectEvent(ProjectModel projectModel)
      : super(projectModel: projectModel);
}

class YieldCreationEvent extends ProjectCreationEvent {
  ProjectCreationState state;

  YieldCreationEvent(this.state);
}
