import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/layout/social_app/cubit/cubit.dart';
import 'package:todo_app/layout/social_app/cubit/states.dart';
import 'package:todo_app/layout/social_app/social_layout.dart';
import 'package:todo_app/modules/social_app/social_login/social_login_screen.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';
import 'package:todo_app/shared/styles/themes.dart';

import 'shared/bloc_observer.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
print('On Background Message');
print(message.data.toString());
showToast(text: 'On BackGround Message', state: ToastStates.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();

  print(token);

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(text: 'On Message', state: ToastStates.SUCCESS);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(text: 'On Message Opened App', state: ToastStates.SUCCESS);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  DioHelper.init();
  await CacheHelper.init();

  Bloc.observer = MyBlocObserver();

  bool isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;

  uId = CacheHelper.getData(key: 'uId');
  print(uId);

  if(uId != null) {
    print(uId * 500);
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }

  runApp(MyApp(
      isDark: isDark,
    startWidget: widget,
  ),);
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({this.isDark, this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()..getUserData()..getPosts(),
        ),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            // darkTheme: darkTheme
            home: Directionality(
              child: startWidget,
              // startWidget,
              textDirection: TextDirection.ltr,
            ),
          );
        },
      ),
    );
  }
}
