abstract class ProjectState {}

class Pending extends ProjectState {}

class Failed extends ProjectState {
  String error;
  Failed(this.error);
}

class 
