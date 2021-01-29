import 'package:amazon_s3_cognito/amazon_s3_cognito.dart';
import 'package:amazon_s3_cognito/aws_region.dart';

import '../secret.dart';

mixin UploadService {
  // Limit uploads for more trolling.
  static int uploadCount = 0;

  static const String identityPool = secret;

  static Future<String> uploadVideoFile(
      String videoName, String videoPath) async {
    String uploadedVideoUrl = await AmazonS3Cognito.upload(
        videoPath,
        "video-troll",
        identityPool,
        videoName,
        AwsRegion.US_EAST_1,
        AwsRegion.US_EAST_1);

    return uploadedVideoUrl;
  }

  static Future<List<String>> listVideoFiles() async {
    List<String> uploadedVideoUrl = await AmazonS3Cognito.listFiles(
        "video-troll",
        identityPool,
        "",
        "us-east-1",
        "us-east-1"); // Bug-here in package

    return uploadedVideoUrl;
  }
}
