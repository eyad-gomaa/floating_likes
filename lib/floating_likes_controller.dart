
part of 'floating_likes.dart';

class FloatingLikesController {
  VoidCallback? _addLikeCallback;

  void attach(VoidCallback callback) {
    _addLikeCallback = callback;
  }

  void showLike() {
    _addLikeCallback?.call();
  }
}