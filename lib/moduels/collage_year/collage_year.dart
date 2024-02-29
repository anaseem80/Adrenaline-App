import 'package:adrenaline/moduels/collage_year/cubit/cubit.dart';
import 'package:adrenaline/moduels/collage_year/cubit/state.dart';
import 'package:adrenaline/shared/compontents/imports.dart';
import 'package:flutter/material.dart';

import '../../shared/compontents/compenants.dart';

class Collage_Year extends StatelessWidget {

  dynamic? collageData;
  Collage_Year({
    this.collageData,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(collageData.name),
        ),
        body: BlocProvider(
          create: (context) =>
          CollageYearsLayoutCubit()..get_collage_years(collageData.id),
          child: BlocConsumer<CollageYearsLayoutCubit, CollageYearsLayoutState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = CollageYearsLayoutCubit.get(context);
              if (state is CollageYearsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CollageYearsLoaded) {
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
                                    (index) => Collages_year(
                                        context: context,
                                        collagesYearData: state.data.data![index],
                                    ),
                                  )
                              ),
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
        )
    );
  }
}
