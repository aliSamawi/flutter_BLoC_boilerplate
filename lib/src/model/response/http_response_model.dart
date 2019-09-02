abstract class HttpResponseModel {}

class HttpResponseSuccessful implements HttpResponseModel {
  final String jsonResponse;

  HttpResponseSuccessful(this.jsonResponse);
}

class HttpResponseError implements HttpResponseModel {
  final int errorCode ;
  final String errorMessage;

  HttpResponseError(this.errorCode, this.errorMessage);
}