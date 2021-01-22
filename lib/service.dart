import 'package:amazon_s3_cognito/amazon_s3_cognito.dart';
import 'package:amazon_s3_cognito/aws_region.dart';

class UploadService {
  static String identityPool = ""; // will add here soon

  static Future<String> uploadVideoFile(
      String videoName, String videoPath) async {
    String uploadedVideoUrl = await AmazonS3Cognito.upload(
        videoPath,
        "video-troll",
        identityPool,
        videoName,
        AwsRegion.AP_EAST_1,
        AwsRegion.AP_SOUTHEAST_1);

    return uploadedVideoUrl;
  }
}
