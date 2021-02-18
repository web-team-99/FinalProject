import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:test_url/Setting/serverUrl.dart';
import 'package:test_url/models/ProjectModel.dart';

class ProjectsProvider with ChangeNotifier {
  List<ProjectModel> _projects;

  List<ProjectModel> get projects {
    return [..._projects];
  }

  Future<void> fetchProjects() async {
    _projects = [];
    final url = projectsApiUrl;
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }

      final responseData =
          json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      if (responseData == null) return null;
      responseData.forEach((element) {
        _projects.add(ProjectModel(
            id: element['_id'],
            authorId: element['_autherId'],
            freelanceId: element['_freelanceId'],
            title: element['title'],
            shortDescription: element['sdesc'],
            description: element['desc'],
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
