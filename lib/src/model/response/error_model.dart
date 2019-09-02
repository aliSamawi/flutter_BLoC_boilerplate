
class ErrorModel{
  Exception exception;
  int errorCode;
  String errorMessage;
  bool isConnectionError;

  ErrorModel( {this.exception , this.errorCode,this.errorMessage , this.isConnectionError});
}