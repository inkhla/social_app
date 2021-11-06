import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/social_app/cubit/cubit.dart';
import 'package:todo_app/layout/social_app/cubit/states.dart';
import 'package:todo_app/modules/social_app/new_post/new_post_screen.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialNewPostState) {
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var socialCubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(icon: Icon(IconBroken.Notification), onPressed: (){}),
              IconButton(icon: Icon(IconBroken.Search), onPressed: (){}),
            ],
            title: Text(socialCubit.titles[socialCubit.currentIndex]),
          ),
          body: socialCubit.screens[socialCubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: socialCubit.currentIndex,
              onTap: (index) => socialCubit.changeBottomNav(index),
              items: [
                BottomNavigationBarItem(icon: Icon(IconBroken.Home,),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Chat), label: 'Chats'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload), label: 'Post'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Location), label: 'Users'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Setting), label: 'Settings'),
              ],
            ),
        );
      },
    );
  }
}
