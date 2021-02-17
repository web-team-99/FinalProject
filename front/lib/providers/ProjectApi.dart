import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:test_url/Setting/serverUrl.dart';
import 'package:test_url/models/CommentModel.dart';
import 'package:test_url/models/OfferModel.dart';
import 'package:test_url/models/ProjectModel.dart';
import 'package:http/http.dart' as http;

class ProjectApi {
  Future<ProjectModel> createNewProject(
    String title,
    String shortDesc,
    String description,
  ) async {
    ProjectModel project = ProjectModel();
    final url = createNewProjectUrl;
    var map = new Map<String, dynamic>();
    map['title'] = title;
    map['sdesc'] = shortDesc;
    map['desc'] = description;

    try {
      final response = await http.post(url, body: map);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }

      final responseData =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if (responseData == null) return null;
      final projectData = responseData['project'] as Map<String, dynamic>;

      project = ProjectModel(
        id: projectData['_id'],
        authorId: projectData['_authorId'],
        title: projectData['title'],
        shortDescription: projectData['sdesc'],
        description: projectData['desc'],
        isAssigned: projectData['Assigned'],
        createdAt: projectData['created_at'],
      );

      return project;
    } catch (e) {
      throw e;
    }
  }

  Future<OfferModel> createNewOffer(
    String projectId,
    int price,
    String description,
    int period,
  ) async {
    OfferModel offer = OfferModel();
    final url = createOfferUrl;
    var map = new Map<String, dynamic>();
    map['_projectid'] = projectId;
    map['price'] = price;
    map['desc'] = description;
    map['priod'] = period;
    try {
      final response = await http.post(url, body: map);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }

      final responseData =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if (responseData == null) return null;
      final offerData = responseData['offer'] as Map<String, dynamic>;

      offer = OfferModel(
        id: offerData['_id'],
        authorId: offerData['_autherId'],
        projectId: offerData['_projectid'],
        freelancerId: offerData['_freelancerid'],
        price: offerData['price'],
        description: offerData['desc'],
        period: offerData['priod'],
      );

      return offer;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> assignOffer(String offerId) async {
    final url = assignOfferUrl;
    try {
      final response = await http.get(url + offerId);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }

      return true;
    } catch (e) {
      throw e;
    }
  }

  Future<List<OfferModel>> getProjectOffers(String projectId) async {
    List<OfferModel> offers = [];
    final url = projectOffersUrl;
    try {
      final response = await http.post(url + projectId);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }
      final responseData =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if (responseData == null) return null;

      final offersData = responseData['offers'] as List<dynamic>;
      offersData.forEach((element) {
        offers.add(OfferModel(
          id: element['_id'],
          authorId: element['_autherId'],
          projectId: element['_projectid'],
          freelancerId: element['_freelancerid'],
          price: element['price'],
          description: element['desc'],
          period: element['priod'],
        ));
      });
      return offers;
    } catch (e) {
      throw e;
    }
  }

  Future<CommentModel> createComment(String projectId, String text) async {
    CommentModel comment = CommentModel();
    final url = createCommentUrl;
    var map = new Map<String, dynamic>();
    map['_projectid'] = projectId;
    map['text'] = text;

    try {
      final response = await http.post(url);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }

      final responseData =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if (responseData == null) return null;
      final commentData = responseData['comment'] as Map<String, dynamic>;

      comment = CommentModel(
        id: commentData['_id'],
        authorId: commentData['_autherId'],
        projectId: commentData['_projectid'],
        writerId: commentData['_writerid'],
        text: commentData['text'],
      );

      return comment;
    } catch (e) {
      throw e;
    }
  }

  Future<List<CommentModel>> getComments(String projectId) async {
    List<CommentModel> comments = [];
    final url = getCommentsUrl;
    try {
      final response = await http.post(url + projectId);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }
      final responseData =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if (responseData == null) return null;

      final commentsData = responseData['comments'] as List<dynamic>;

      commentsData.forEach((element) {
        comments.add(CommentModel(
          id: element['_id'],
          authorId: element['_autherId'],
          projectId: element['_projectid'],
          writerId: element['_writerid'],
          text: element['text'],
        ));
      });
      return comments;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> deleteComment(String commentId) async {
    final url = getCommentsUrl;
    try {
      final response = await http.delete(url + commentId);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }

      return true;
    } catch (e) {
      throw e;
    }
  }

  Future<ProjectModel> getProject(String projectId) async {
    ProjectModel project = ProjectModel();

    final url = getProjectUrl;
    try {
      final response = await http.delete(url + projectId);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }

      final responseData =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if (responseData == null) return null;
      final projectData = responseData['project'] as Map<String, dynamic>;

      project = ProjectModel(
        id: projectData['_id'],
        authorId: projectData['_authorId'],
        title: projectData['title'],
        shortDescription: projectData['sdesc'],
        description: projectData['desc'],
        isAssigned: projectData['Assigned'],
        createdAt: projectData['created_at'],
      );

      return project;
    } catch (e) {
      throw e;
    }
  }
}
