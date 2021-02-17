import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:test_url/Setting/serverUrl.dart';
import 'package:test_url/models/ProviderModels/ProjectModel.dart';

class ProjectsProvider with ChangeNotifier {
  List<ProjectModel> _projects;

  List<ProjectModel> get projects {
    return [..._projects];
  }

  Future<void> fetchProjects() async {
    _projects = [];
    final url = unassignedProjectsUrl;
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }

      final responseData =
          json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      if (responseData == null) return;
      responseData.forEach((element) {
        _projects.add(ProjectModel(
            id: element['id'],
            authorId: element['authorId'],
            freelanceId: element['freelanceId'],
            title: element['title'],
            shortDescription: element['shortDescription'],
            description: element['description'],
            isAssigned: element['assigned'],
            createdAt: element['createdAt']
            ));
      });
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
