import 'package:flutter_social_app/utils/constants_api.dart' as API;
import 'package:flutter_social_app/utils/logger.dart';

class Profile {
  String email;
  String userName;
  String bio;
  String city;
  String website;
  String image;

  void loadFromJson(Map<String, dynamic> json) {
    userName = json[API.FIELD_USERNAME];
    email = json[API.FIELD_EMAIL];
    bio = json[API.FIELD_BIO];
    city = json[API.FIELD_CITY];
    website = json[API.FIELD_WEBSITE];
    image = json[API.FIELD_IMAGE];
  }

  void printProfile() {
    logi(
        'Profile(email: $email, userName: $userName, bio: $bio, city: $city, website: $website, image: $image)');
  }
}
