import 'package:adrenaline/models/universites/universites.dart';
import 'package:adrenaline/moduels/universites/cubit/cubit.dart';
import 'package:adrenaline/moduels/universites/cubit/state.dart';
import 'package:adrenaline/shared/compontents/compenants.dart';
import 'package:adrenaline/shared/compontents/imports.dart';
import 'package:adrenaline/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class Universites_Component extends StatelessWidget {
  const Universites_Component({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      UniversitesLayoutCubit()..get_universites(),
      child: BlocConsumer<UniversitesLayoutCubit, UniversitesLayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = UniversitesLayoutCubit.get(context);
          if (state is UniversitesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UniversitesLoaded) {
            return LayoutBuilder(builder: (context, constrain) {
              return Container(
                padding: EdgeInsets.all(15.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {

                              },
                              icon: Icon(
                                Icons.arrow_circle_left_rounded,
                                color: whiteColor,
                              ),
                            ),
                            Text(
                              "الجامعات",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            Data universityData = state.data.data![index];
                            return UniversitesComponent(
                              context: context,
                              universityData: universityData,
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            width: 20.0,
                          ),
                          itemCount: state.data.data!.length,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          } else {
            return ErrorIntrnet();
          }
        },
      ),
    );
  }
}

