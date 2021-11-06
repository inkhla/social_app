import 'package:todo_app/modules/social_app/social_login/social_login_screen.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';

void logOut(context) {
  CacheHelper.removeData(key: 'uId').then((value) {
    navigateAndFinish(context, SocialLoginScreen());
  });
}

///this function prints the whole text without cutting it

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
String uId = '';