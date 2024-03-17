import 'package:adrenaline/shared/compontents/imports.dart';
import 'package:flutter/material.dart';

import '../../../shared/compontents/compenants.dart';
import '../../../shared/widgets/app_bar.dart';
import '../../../shared/widgets/empty_data_widget.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, required this.searchText});
  final String searchText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: BlocProvider(
        create: (context) => SearchCubit()..searchCourses(searchText: searchText),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (context.read<SearchCubit>().courses.isNotEmpty) {
              return ListView.separated(
                  itemBuilder: (context, index) => CourseItem(course: context.read<SearchCubit>().courses[index], context: context),
                  separatorBuilder: (context, index) => SizedBox(height: 20,),
                  itemCount: context.read<SearchCubit>().courses.length,
              );
            } else {
              return EmptyData(text:" 😞 لا يوجد اى كورسات");
            }
          },
        ),
      ),
    );
  }
}
