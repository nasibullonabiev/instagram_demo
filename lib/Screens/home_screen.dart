

import 'package:flutter/material.dart';
import '../Theme/Colors.dart';
import '../widget/Post_Items.dart';
import '../widget/Story_Banner.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: black,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const StoryBanner(),
            Divider(
              height: 1,
              color: white.withOpacity(0.2),
            ),
            const PostItems(),
          ],
        ),
      ),
    );
  }
}
