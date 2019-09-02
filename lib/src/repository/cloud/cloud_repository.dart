import 'package:async/async.dart';
import '../../model/response/http_response_model.dart';
import 'cloud_repository_contract.dart';
import 'http_client/http_client.dart';

class CloudRepository with CloudRepositoryContract{

  final _httpClient = HttpClient();
  Map<String, CancelableCompleter<dynamic>> _specificJobs = Map();

  _cancelSpecificJob(String id) {
    if (_specificJobs.containsKey(id)) {
      var cancelableJob = _specificJobs.remove(id);
      cancelableJob.operation.cancel();
    }
  }

  getDataFromCloud(
      Future<HttpResponseModel> api,
      void onSuccess(HttpResponseSuccessful onValue),
      void onError(HttpResponseError error),
      {void onCancel(),
        String jobId,}) {
    if (jobId != null && jobId.isNotEmpty) {
      _cancelSpecificJob(jobId);
    }

    var completer = CancelableCompleter(onCancel: () {
      onCancel();
    });

    completer.complete(Future<HttpResponseModel>(() {
      return api;
    }).then((onValue) {
      if (completer.isCanceled) {
        return;
      }
      if (onValue is HttpResponseSuccessful) {
        onSuccess(onValue);
      } else {
        onError(HttpResponseError(0, "something went wrong!"));
      }
    }).catchError((error) {
      if (completer.isCanceled) {
        return;
      }
      if (error is HttpResponseError) {
        //repository handled errors
        onError(error);
      } else {
        onError(HttpResponseError(0, "unexpected error!"));
      }
    }));

    if (jobId != null &&
        jobId.isNotEmpty &&
        !_specificJobs.containsKey(jobId)) {
      _specificJobs[jobId] = completer;
    }

    completer.operation.value.whenComplete(() {
      if (_specificJobs.containsKey(jobId)) {
        _specificJobs.remove(jobId);
      }
    });
  }

  @override
  Future<HttpResponseModel> getCloudTrendingGithubDataAsync() {
    return _httpClient.getRequestApi("search/repositories" , queryParameters: {
      "sort" : "starts",
      "order" : "desc",
      "q" : "language:kotlin",
    });
  }
}
