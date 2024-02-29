import 'package:adrenaline/moduels/modules/cubit/modules_layout_cubit.dart';
import 'package:adrenaline/moduels/modules/modules_screen/modules.dart';
import 'package:adrenaline/shared/compontents/compenants.dart';
import 'package:adrenaline/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class Modules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ModulesLayoutCubit()..getModules(),
      child: BlocConsumer<ModulesLayoutCubit, ModulesLayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ModulesLayoutCubit.get(context);
          if(state is ModulesLayoutLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(state is ModulesLayoutLoaded){
            double width = MediaQuery.of(context).size.width;
            if(cubit.modules[0].length >= 1){
              return Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  right: 15.0,
                  left: 15.0,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ModulesScreen()),
                                  );
                                },
                                icon: Icon(
                                  Icons.arrow_circle_left_rounded,
                                  color: whiteColor,
                                ),
                              ),
                              Text(
                                "احدث مديولات",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SingleChildScrollView(
                            child: SizedBox(
                              height: 305.0,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  //shrinkWrap: true,
                                  itemBuilder: (context, index) => modules(
                                      module: cubit.modules[0][index],
                                      context: context
                                  ),
                                  separatorBuilder: (context, index) => SizedBox(
                                    width: 20.0,
                                  ),
                                  itemCount: cubit.modules[0].length
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }else{
              return Container();
            }
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
