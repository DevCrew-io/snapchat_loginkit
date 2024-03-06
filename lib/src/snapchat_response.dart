/// Generic response abstract class
abstract class SnapchatResponse {
  int code;
  String message;

  SnapchatResponse({this.code = 200, this.message = 'Success'});
}
