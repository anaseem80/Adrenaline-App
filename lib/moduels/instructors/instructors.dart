import 'package:adrenaline/moduels/instructors/cubit/instructors_layout_cubit.dart';
import 'package:adrenaline/moduels/instructors/instructors_screen/instructors.dart';
import 'package:adrenaline/shared/compontents/compenants.dart';
import 'package:adrenaline/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class Instructors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
            if(cubit.instructors[0].length > 0){
              return Container(
                padding: EdgeInsets.only(
                  right: 15.0,
                  left: 15.0,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Instructors_screen()),
                              );
                            },
                            icon: Icon(
                              Icons.arrow_circle_left_rounded,
                              color: whiteColor,
                            ),
                          ),
                          Text(
                            "التصنيف علي حسب القسم",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ],
                      ),
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
                              itemBuilder: (context, index) => instructors(cubit.instructors[index], context, ""),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 20.0,
                              ),
                              itemCount: cubit.instructors.length
                          )
                        ],
                      ),
                    )
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
          };
        },
      ),
    );
  }
}
