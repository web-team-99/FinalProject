import 'package:http/http.dart' as http;
import 'package:test_url/Setting/serverUrl.dart';
import 'package:test_url/models/OfferModel.dart';
import 'package:test_url/models/ProjectModel.dart';
import 'package:test_url/models/user.dart';

class UserDataApi {
  Future<List<ProjectModel>> getUserProjects(String userId) {
    final String url = usersAllProjects + '$userId';
    var response, data;
    try{
      response = http.get(url);

    }
    catch(e){

    }

  }


  Future<List<ProjectModel>> getUnassignedUserProjects(String userId){
    // final String url =
  }

  Future<List<ProjectModel>> getAssignedUserProjects(String userId){

  }

  Future<List<ProjectModel>> getUsersAcceptedProjects(String userId){

  }

  Future<List<OfferModel>> getUserOffers(String userId){

  }

  Future<void> updateUser(User user){

  }

  

}
