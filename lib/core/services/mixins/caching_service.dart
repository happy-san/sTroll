import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

mixin CachingService {
  Future<File> getCachedVideo(
      {@required String videoURL, CacheManager cacheManager}) async {
    cacheManager = cacheManager ?? DefaultCacheManager();

    try {
      final fileInfo = await cacheManager.getFileFromCache(videoURL);

      return fileInfo == null ? Future.value(null) : fileInfo.file;
    } catch (e) {
      throw (e);
    }
  }

  // TODO: implement logic to store video
}
