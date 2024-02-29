import 'package:adrenaline/moduels/modules/cubit/modules_layout_cubit.dart';
import 'package:adrenaline/shared/compontents/compenants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("المديولات"),
        ),
        body: BlocProvider(
          create: (context) => ModulesLayoutCubit()..getModules(),
          child: BlocConsumer<ModulesLayoutCubit, ModulesLayoutState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = ModulesLayoutCubit.get(context);
              if(state is ModulesLayoutCubit){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else if(state is ModulesLayoutLoaded){
                return Container(
                  padding: EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        screen_items_length(
                          title: "الموديلات",
                          length:  cubit.modules[0].length, context: context,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 7.0,
                              left: 7.0
                          ),
                          child: Column(
                            children: [
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) => modules(
                                      module: cubit.modules[0][index],
                                      context: context
                                  ),
                                  separatorBuilder: (context, index) => SizedBox(
                                    height: 20.0,
                                  ),
                                  itemCount: cubit.modules[0].length
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              };
            },
          ),
        )
    );
  }
}
