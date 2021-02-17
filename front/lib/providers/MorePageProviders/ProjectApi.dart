import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:test_url/models/CommentModel.dart';
import 'package:test_url/models/OfferModel.dart';
import 'package:test_url/models/ProviderModels/ProjectModel.dart';

class ProjectApi {
  

  Future<ProjectModel> createNewProject(
      String title, String shortDesc, String description) {}

  Future<OfferModel> createNewOffer() {}

  Future<bool> assignOffer({@required String offerId}) {}

  Future<OfferModel> getProjectOffers(String projectId){

  }

  Future<void> createComment(String projectId, String text){

  }

  Future<List<CommentModel>> getComments(String projectId){

  }

  Future<void> deleteComment(String commentId){

  }

  Future<ProjectModel> getProject(String projectId){
    
  }

}
