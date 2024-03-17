import 'package:adrenaline/moduels/Semester/cubit/cubit.dart';
import 'package:adrenaline/moduels/Semester/cubit/state.dart';
import 'package:adrenaline/shared/compontents/imports.dart';
import 'package:flutter/material.dart';

import '../../shared/compontents/compenants.dart';

class Semesters_View extends StatelessWidget {
  dynamic? collageYear;
  Semesters_View({
    this.collageYear
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ترمات سنة " + collageYear.yearNumber.toString()),
        ),
        body: BlocProvider(
          create: (context) =>
          SemestersLayoutCubit()..get_Semesters(collageYear.id),
          child: BlocConsumer<SemestersLayoutCubit, SemestersLayoutState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = SemestersLayoutCubit.get(context);
              if (state is SemestersLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SemestersLoaded) {
                return LayoutBuilder(builder: (context, constrain) {
                  return SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              right: 7.0,
                              left: 7.0
                          ),
                          child: Column(
                            children: [
                              GridView.count(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: (MediaQuery.of(context).orientation == Orientation.landscape) ? 4 : 2,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0,
                                children: List.generate(
                                  state.data.data!.length,
                                      (index) => SemestersView(
                                      context: context,
                                      SemestersData: state.data.data![index],
                                  ),
                                ),
                              )
                            ],
                          )
                      )
                  );
                });
              } else {
                return ErrorIntrnet();
              }
            },
          ),
        ),
    );
  }
}


