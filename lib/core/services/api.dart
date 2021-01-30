import 'mixins/caching_service.dart';
import 'mixins/upload_service.dart';

class Api with CachingService, UploadService {
  // TODO: Api class becomes the interface for the app.

  static final _instance = Api._();

  factory Api() => _instance;

  Api._();
}
