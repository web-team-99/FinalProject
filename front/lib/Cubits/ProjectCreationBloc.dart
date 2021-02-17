import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_url/models/ProjectModel.dart';
import 'package:test_url/providers/ProjectApi.dart';

part 'ProjectCreatinoState.dart';
part 'ProjectCreationEvent.dart';

class ProjectCreationBloc
    extends Bloc<ProjectCreationEvent, ProjectCreationState> {
  ProjectApi api = ProjectApi();

  ProjectCreationBloc(ProjectCreationState state) : super(state);

  @override
  Stream<ProjectCreationState> mapEventToState(
      ProjectCreationEvent event) async* {
    if (event is CreateProjectEvent) {
      yield CreateProjectPendingState();
      api
          .createNewProject(
              event.projectModel.title,
              event.projectModel.shortDescription,
              event.projectModel.description)
          .then((value) =>
              this.add(YieldCreationEvent(CreateProjectSuccessfulState(value))))
          .onError((error, stackTrace) =>
              this.add(YieldCreationEvent(CreateProjectFailedState(error))));
    } else if (event is YieldCreationEvent) {
      yield event.state;
    }
  }
}
