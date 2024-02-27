


abstract class SnapchatResponse<T> {
  int code;
  String message;

  SnapchatResponse({this.code = 200, this.message = 'Success'});
}