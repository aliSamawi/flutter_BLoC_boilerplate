import 'package:flutter_bloc_boilerplate/src/model/response/http_response_model.dart';

mixin CloudRepositoryContract{
  Future<HttpResponseModel> getCloudTrendingGithubDataAsync();
}