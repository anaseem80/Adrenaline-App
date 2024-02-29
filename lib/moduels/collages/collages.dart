import 'package:adrenaline/models/collages/collages.dart';
import 'package:adrenaline/moduels/collages/cubit/cubit.dart';
import 'package:adrenaline/moduels/collages/cubit/state.dart';
import 'package:adrenaline/shared/compontents/compenants.dart';
import 'package:adrenaline/shared/compontents/imports.dart';
import 'package:flutter/material.dart';


class Collages_View extends StatelessWidget {
  dynamic? universityObject;
  Collages_View({
    this.universityObject,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(universityObject.name),
        ),
        body: BlocProvider(
          create: (context) =>
          CollagesLayoutCubit()..get_collages(universityObject.id),
          child: BlocConsumer<CollagesLayoutCubit, CollagesLayoutState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = CollagesLayoutCubit.get(context);
              if (state is CollagesLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CollagesLoaded) {
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
                                      (index) => CollagesView(
                                      context: context,
                                      collagesData: state.data.data![index],
                                      universityObject: universityObject
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
