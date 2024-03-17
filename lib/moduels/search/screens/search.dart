import 'package:flutter/material.dart';

import '../../../shared/compontents/compenants.dart';
import '../../../shared/widgets/app_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: CourseItem(course: null, context: context),
    );
  }
}
