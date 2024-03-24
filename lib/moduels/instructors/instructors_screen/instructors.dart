import 'package:adrenaline/moduels/instructors/cubit/instructors_layout_cubit.dart';
import 'package:adrenaline/shared/compontents/compenants.dart';
import 'package:adrenaline/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Instructors_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("التصنيف علي حسب القسم"),
      ),
      body: BlocProvider(
        create: (context) => InstructorsLayoutCubit()..getInstructors(),
        child: BlocConsumer<InstructorsLayoutCubit, InstructorsLayoutState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = InstructorsLayoutCubit.get(context);
            if(state is InstructorsLayoutLoading){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else if(state is InstructorsLayoutLoaded){
              return Container(
                padding: EdgeInsets.only(
                  right: 15.0,
                  left: 15.0,
                ),
                child: Column(
                  children: [
                    screen_items_length(
                      title: "الاقسام",
                      length:  cubit.instructors.data!.length, context: context,
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
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => instructors(cubit.instructors.data![index], context, ""),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 20.0,
                              ),
                              itemCount: cubit.instructors.data!.length
                          ),
                        ],
                      ),
                    )
                  ],
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
