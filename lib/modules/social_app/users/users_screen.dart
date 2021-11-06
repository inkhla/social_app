import 'package:flutter/material.dart';
import 'package:todo_app/shared/styles/colors.dart';

class UsersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
              'https://firebasestorage.googleapis.com/v0/b/udemyflutter-c1df0.appspot.com/o/users%2Fimage_picker3399814148940032078.jpg?alt=media&token=bc57227b-a522-4e02-b195-6819ae29f661',
            ),
          ),
          SizedBox(width: 15),
          Text(
            'Arkant0000S',
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }
}
