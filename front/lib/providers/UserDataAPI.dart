import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:test_url/Setting/serverUrl.dart';
import 'package:test_url/models/OfferModel.dart';
import 'package:test_url/models/ProjectModel.dart';
import 'package:test_url/models/user.dart';

class UserDataApi {
  Future<List<ProjectModel>> getUserProjects(String userId) async {
    List<ProjectModel> projects;
    final String url = usersAllProjects + '$userId';
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }
      final resData =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if (resData == null) return null;
      final projectList = resData['projects'] as List<dynamic>;
      projectList.forEach((element) {
        projects.add(ProjectModel(
          id: element['_id'],
          authorId: element['_authertid'],
          freelanceId: element['_freelancerid'],
          title: element['title'],
          shortDescription: element['sdecs'],
          description: element['desc'],
          isAssigned: element['assigned'],
          createdAt: element['created_at'],
          price: element['price'],
        ));
      });
      return projects;
    } catch (e) {
      throw (e);
    }
  }

  Future<List<ProjectModel>> getUnassignedUserProjects(String userId) async {
    List<ProjectModel> projects;
    final String url = usersUnassignedProjectsUrl + '$userId';
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }
      final resData =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if (resData == null) return null;
      final projectList = resData['projects'] as List<dynamic>;
      projectList.forEach((element) {
        projects.add(ProjectModel(
          id: element['_id'],
          authorId: element['_authertid'],
          freelanceId: element['_freelancerid'],
          title: element['title'],
          shortDescription: element['sdecs'],
          description: element['desc'],
          isAssigned: element['assigned'],
          createdAt: element['created_at'],
          price: element['price'],
        ));
      });
      return projects;
    } catch (e) {
      throw (e);
    }
  }

  Future<List<ProjectModel>> getAssignedUserProjects(String userId) async {
    List<ProjectModel> projects;
    final String url = usersAssignedProjectsUrl + '$userId';
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }
      final resData =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if (resData == null) return null;
      final projectList = resData['projects'] as List<dynamic>;
      projectList.forEach((element) {
        projects.add(ProjectModel(
          id: element['_id'],
          authorId: element['_authertid'],
          freelanceId: element['_freelancerid'],
          title: element['title'],
          shortDescription: element['sdecs'],
          description: element['desc'],
          isAssigned: element['assigned'],
          createdAt: element['created_at'],
          price: element['price'],
        ));
      });
      return projects;
    } catch (e) {
      throw (e);
    }
  }

  Future<List<ProjectModel>> getUsersAcceptedProjects(String userId) async {
    List<ProjectModel> projects;
    final String url = usersAcceptedProjectsUrl + '$userId';
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }
      final resData =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if (resData == null) return null;
      final projectList = resData['projects'] as List<dynamic>;
      projectList.forEach((element) {
        projects.add(ProjectModel(
          id: element['_id'],
          authorId: element['_authertid'],
          freelanceId: element['_freelancerid'],
          title: element['title'],
          shortDescription: element['sdecs'],
          description: element['desc'],
          isAssigned: element['assigned'],
          createdAt: element['created_at'],
          price: element['price'],
        ));
      });
      return projects;
    } catch (e) {
      throw (e);
    }
  }

  Future<List<ProjectModel>> getDoneUserProjects(String userId) async {
    List<ProjectModel> projects;
    final String url = userDoneProjectsUrl + '$userId';
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }
      final resData =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if (resData == null) return null;
      final projectList = resData['projects'] as List<dynamic>;
      projectList.forEach((element) {
        projects.add(ProjectModel(
          id: element['_id'],
          authorId: element['_authertid'],
          freelanceId: element['_freelancerid'],
          title: element['title'],
          shortDescription: element['sdecs'],
          description: element['desc'],
          isAssigned: element['assigned'],
          createdAt: element['created_at'],
          price: element['price'],
        ));
      });
      return projects;
    } catch (e) {
      throw (e);
    }
  }

  Future<List<OfferModel>> getUserOffers(String userId) async {
    List<OfferModel> offers;
    final String url = userOffersUrl + '$userId';
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }
      final resData =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if (resData == null) return null;
      final projectList = resData['offers'] as List<dynamic>;
      projectList.forEach((element) {
        offers.add(OfferModel(
          id: element['_id'],
          authorId: element['_authertid'],
          freelancerId: element['_freelancerid'],
          description: element['desc'],
          projectId: element['_projectid'],
          price: element['price'],
        ));
      });
      return offers;
    } catch (e) {
      throw (e);
    }
  }

  Future<void> updateUser(User user) async {
    final String url = updateProfileUrl;
    final headers = {'Content-type': 'application/x-www-form-urlencoded'};
    final body = "name=${user.name}&lname=${user.lastName}&email=${user.email}";
    try {
      final response = await http.put(url, headers: headers, body: body);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }
    } catch (e) {
      throw (e);
    }
  }
}
