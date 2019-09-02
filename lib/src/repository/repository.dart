import 'dart:convert';

import 'package:flutter_bloc_boilerplate/src/model/response/error_model.dart';
import 'package:flutter_bloc_boilerplate/src/model/response/git_response.dart';
import 'package:flutter_bloc_boilerplate/src/repository/cloud/cloud_repository.dart';
import 'package:flutter_bloc_boilerplate/src/repository/local/local_repository.dart';

class Repository {
  final _cloudRepository = CloudRepository();
  final _localRepository = LocalRepository();

  Repository._privateConstructor() {
    //initialization logic here
  }

  static final Repository _instance = Repository._privateConstructor();

  factory Repository() {
    return _instance;
  }

  getTrendingGithubDataAsync(void onSuccessApi(GitResponse onValue),
      void onSuccessLocal(GitResponse onValue),
      void onError(ErrorModel error),
      {void onCancel(), String jobId})
  {
    //todo get from local and on response get from cloud
    _cloudRepository.getDataFromCloud(
        _cloudRepository.getCloudTrendingGithubDataAsync(),
        (response) {
        onSuccessApi(GitResponse.fromJson(json.decode(response.jsonResponse)));
      }, (error) {
        onError(
            ErrorModel(
                errorMessage: error.errorMessage,
                errorCode: error.errorCode,
                isConnectionError: true));
      },onCancel: (){
          onCancel();
        } , jobId: jobId );
  }
}
